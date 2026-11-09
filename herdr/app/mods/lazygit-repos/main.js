// Lazygit for a repo of the current workspace. Root = outermost git repo
// around the focused terminal's folder (fallback: space folder, other panes
// of the space). Lists root + nested repos (.worktrees skipped), type to
// filter, ↑/↓ (ctrl-p/n, wheel) + Enter opens lazygit via terminal.peek (only
// overlay that takes the keyboard; window/dialog layouts don't). One repo ->
// opens it straight away. Esc closes.

import { View, div, svg } from "gpui-kit";
import { v_flex, h_flex, InputState, Input } from "gpui-base";
import { spaces, panes, terminals, focused, exec, hc, theme, props, closeOverlay, readTextFile, appHome, notify } from "herdr";

export default class LazygitRepos extends View {
  init(_props, cx) {
    this.filter = "";
    this.at = 0;
    this.repos = null; // [{ dir, rel, branch }]
    this.root = null;
    this.error = null;
    this.input = InputState.new({ placeholder: "Repo…" });
    this.input.on("change", (_e, cx) => { this.filter = this.input.value(); this.at = 0; cx.notify(); });
    this.input.on("submit", () => this.open(this.rows()[this.at]));
    this.input.focus();
    cx.timer.after(300, () => this.input.focus());
    this.handle = cx.focus_handle();

    const f = focused();
    this.space = spaces().find((s) => s.id === f?.space) ?? spaces().find((s) => s.active);
    const tabs = new Set((this.space?.tabs ?? []).map((t) => t.id));
    const cands = [f?.cwd, this.space?.folder, ...panes().filter((p) => tabs.has(p.tab)).map((p) => p.cwd)].filter(Boolean);

    cx.spawn(async (cx) => {
      try {
        const script = await readTextFile(`${appHome()}/mods/lazygit-repos/repos.sh`);
        const r = await exec("sh", ["-c", script, "repos.sh", ...new Set(cands)], { on: this.space?.machine ?? null, timeout: 10000 });
        if (r.code === 3) this.error = "Brak repo git w tym workspace";
        else if (r.code !== 0) this.error = r.stderr.trim() || `repos.sh: exit ${r.code}`;
        else {
          const lines = r.stdout.trim().split("\n").map((l) => l.split("\t"));
          this.root = lines.shift()?.[1];
          const name = this.root.split("/").pop();
          this.repos = lines.map(([dir, branch]) => ({
            dir,
            branch: branch ?? "",
            rel: dir === this.root ? name : dir.slice(this.root.length + 1),
            top: dir === this.root,
          }));
          if (this.repos.length === 1) return this.open(this.repos[0]);
        }
      } catch (e) {
        this.error = String(e?.message ?? e);
      }
      cx.notify();
    });
  }

  close() {
    closeOverlay(props().overlay);
  }

  rows() {
    const f = this.filter.toLowerCase();
    return (this.repos ?? []).filter((r) => !f || `${r.rel} ${r.branch}`.toLowerCase().includes(f));
  }

  async open(r) {
    if (!r) return;
    const on = this.space?.machine ?? null;
    const live = terminals().filter((x) => x.state === "live");
    // peek's ✕ only hides lazygit: reuse the one still running for this repo
    const running = live.find((x) => x.name?.startsWith("lazygit-") && x.cwd === r.dir && x.argv?.[0] === "lazygit");
    // name shows on the peek bar; unique among live terminals
    const slug = `lazygit-${r.rel.toLowerCase().replace(/[^a-z0-9_-]+/g, "-")}`.slice(0, 28);
    const name = live.some((x) => x.name === slug) ? `${slug}-${Date.now() % 1000}` : slug;
    const args = ["run", "--bg", "--json", "--no-parent", "--rm", "--name", name, "--cwd", r.dir];
    if (on) args.push("--on", on);
    args.push("--", "lazygit");
    if (this.opening) return;
    this.opening = true;
    // Peek must open AFTER this popup closes: closing it hands the keyboard back to
    // the pane underneath, so a peek opened earlier stays keyboard-less. Closing first
    // kills this async continuation, hence a detached shell retries the peek (it also
    // fails until the app sees the new terminal).
    try {
      let terminal = running?.address;
      if (!terminal) {
        const res = await hc(args);
        if (res.code !== 0) throw new Error(res.stderr.trim() || `hc run: exit ${res.code}`);
        terminal = JSON.parse(res.stdout).address;
      }
      const peek = 'for i in $(seq 40); do sleep 0.15; herdr-app do terminal.peek --terminal "$1" 2>/dev/null | grep -q \'"ok"\' && exit; done';
      await exec("sh", ["-c", `(${peek}) >/dev/null 2>&1 &`, "sh", terminal]);
    } catch (e) {
      notify({ title: "lazygit", body: String(e?.message ?? e), level: "error" });
    }
    this.close();
  }

  render() {
    const t = theme();
    const rows = this.rows();
    this.at = Math.max(0, Math.min(this.at, rows.length - 1));
    const sel = rows[this.at];
    // manual scroll window (overflow scroll doesn't work in a popup): VISIBLE rows, selection kept in view
    const VISIBLE = 10;
    const maxTop = Math.max(0, rows.length - VISIBLE);
    this.top = Math.max(0, Math.min(this.top ?? 0, maxTop));
    if (this.at < this.top) this.top = this.at;
    if (this.at >= this.top + VISIBLE) this.top = this.at - VISIBLE + 1;
    const shown = rows.slice(this.top, this.top + VISIBLE);

    const row = (r) =>
      h_flex()
        .id(`lg-${r.dir}`)
        .mx(4)
        .px(10)
        .h(32)
        .flex_none()
        .rounded(7)
        .gap(10)
        .items_center()
        .cursor_pointer()
        .when(r === sel, (el) => el.bg(t.hover))
        .hover((s) => s.bg(t.hover))
        .on_click(() => this.open(r))
        .child(div().w(12).flex_none().text_color(r.top ? t.accent : t.dim).child(r.top ? "◆" : "·"))
        .child(div().flex_1().truncate().text_color(t.foreground).when(r.top, (d) => d.font_semibold()).child(r.rel))
        .child(div().text_size(11).text_color(t.dim).child(r.branch ? r.branch : ""));

    const body = this.error
      ? div().px(10).py(8).text_color(t.blocked ?? t.dim).child(this.error)
      : !this.repos
        ? div().px(10).py(8).text_color(t.dim).child("Szukam repo…")
        : rows.length
          ? v_flex()
              .id("lg-list")
              .flex_none()
              .h(shown.length * 32)
              .on_scroll_wheel((e, cx) => {
                const d = e.delta.y < 0 ? 1 : e.delta.y > 0 ? -1 : 0;
                this.top = Math.max(0, Math.min(this.top + d, maxTop));
                this.at = Math.max(this.top, Math.min(this.at, this.top + VISIBLE - 1));
                cx.notify();
              })
              .children(shown.map(row))
          : div().px(10).py(8).text_color(t.dim).child("Brak dopasowań");

    return v_flex()
      .id("lazygit-repos")
      .track_focus(this.handle)
      .size_full()
      .min_h(0)
      .p(18)
      .gap(10)
      .bg(t.popover)
      .text_size(13)
      .on_key_down((e, cx) => {
        const k = e.key;
        const n = rows.length || 1;
        if (k === "escape") return this.close();
        if (k === "down" || (e.modifiers.control && k === "n")) this.at = (this.at + 1) % n;
        else if (k === "up" || (e.modifiers.control && k === "p")) this.at = (this.at + n - 1) % n;
        else return;
        cx.stop_propagation();
        cx.notify();
      })
      .child(
        h_flex().items_center()
          .child(div().flex_1().text_size(15).font_semibold().text_color(t.foreground).child("lazygit"))
          .child(div().text_size(11).text_color(t.dim).child(this.root ? this.root.replace(/^\/home\/[^/]+/, "~") : "")),
      )
      .child(
        h_flex().h(36).flex_none().px(10).gap(8).items_center().rounded(9).border_1().border_color(t.accent).bg(t.background)
          .child(svg("mods/workspace-chrome/search.svg").size(15).text_color(t.dim))
          .child(Input.new(this.input).flex_1().h_full().text_size(12.8).text_color(t.foreground)),
      )
      .child(body)
      .when(rows.length > VISIBLE, (el) =>
        el.child(div().flex_none().text_size(11).text_color(t.dim).child(`${this.top + 1}–${this.top + shown.length} z ${rows.length}`)));
  }
}
