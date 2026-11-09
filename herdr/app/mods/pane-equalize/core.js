// Split sizing for the active tab, shared by pane-equalize and pane-resize-*.
// Each mod opens as an invisible popup (mod.open from keys.json), acts, closes.
//
// No public API exposes a tab's split tree, so it's read from herdr-core's doc
// (~/.local/state/herdr-core/default/docs.json, local machine only). Sizes are
// relative weights; layout.resize {id, weight} works on tab panes and splits.

import { View, div } from "gpui-kit";
import { focused, panes, spaces, readTextFile, home, run, closeOverlay, props, notify } from "herdr";

const DOC = () => `${home()}/.local/state/herdr-core/default/docs.json`;
const STEP = 0.05; // share of the split per keypress
const MIN = 0.05; // smallest share a pane can shrink to

const axis = (n) => (n.type === "row" ? "h" : n.type === "column" ? "v" : null);
const weight = (n) => n.size?.weight ?? 1;

// panes a node holds along axis a (same-axis splits add up, cross splits take the widest)
function span(n, a) {
  if (!n.children?.length) return 1;
  const s = n.children.map((c) => span(c, a));
  return axis(n) === a ? s.reduce((x, y) => x + y, 0) : Math.max(...s);
}

function pathTo(n, id) {
  if (n.id === id) return [n];
  for (const c of n.children ?? []) {
    const p = pathTo(c, id);
    if (p) return [n, ...p];
  }
  return null;
}

function equalize(n) {
  for (const c of n.children ?? []) {
    if (n.children.length > 1) run("layout.resize", { id: c.id, weight: span(c, axis(n)) });
    equalize(c);
  }
}

// Moves the divider of the focused pane in dir (tmux-like: its right/bottom
// divider when there is one, else its left/top one).
function resize(path, dir) {
  const a = dir === "left" || dir === "right" ? "h" : "v";
  const fwd = dir === "right" || dir === "down";
  for (let k = path.length - 2; k >= 0; k--) {
    const p = path[k];
    if (axis(p) !== a || p.children.length < 2) continue;
    const i = p.children.indexOf(path[k + 1]);
    const before = i < p.children.length - 1 ? i : i - 1; // divider between before and before+1
    const [grow, shrink] = fwd ? [before, before + 1] : [before + 1, before];
    const ws = p.children.map(weight);
    const total = ws.reduce((x, y) => x + y, 0);
    const take = Math.min(STEP * total, ws[shrink] - MIN * total);
    if (take <= 0) return;
    run("layout.resize", { id: p.children[grow].id, weight: ws[grow] + take });
    run("layout.resize", { id: p.children[shrink].id, weight: ws[shrink] - take });
    return;
  }
}

async function act(action) {
  const f = focused();
  const tabId = f?.tab;
  const space = spaces().find((s) => s.id === f?.space);
  if (space?.machine) throw new Error("tylko lokalne space");
  const text = await readTextFile(DOC());
  if (!text) throw new Error(`brak ${DOC()}`);
  const doc = JSON.parse(text)?.["herdr-app"]?.value;
  const tab = doc?.spaces?.flatMap((s) => s.tabs ?? []).find((t) => t.id === tabId);
  if (!tab?.root) throw new Error("nie znaleziono taba w docs.json (zmieniony format?)");
  if (action === "equalize") return equalize(tab.root);
  const pane = f?.pane ?? panes().find((p) => p.tab === tabId && p.focused)?.pane;
  const path = pane && pathTo(tab.root, pane);
  if (path) resize(path, action);
}

export function make(action) {
  return class extends View {
    init(_props, cx) {
      cx.spawn(async () => {
        try {
          await act(action);
        } catch (e) {
          notify({ title: `pane ${action}`, body: String(e?.message ?? e), level: "error" });
        }
        closeOverlay(props().overlay);
      });
    }

    render() {
      return div();
    }
  };
}
