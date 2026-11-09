#!/usr/bin/env python3
"""Export keymap markdown cheatsheets to printable landscape 2-column PDFs."""

import markdown
import os
import re
import subprocess
import sys
import tempfile

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))

CSS = """
@page {
    size: A4 landscape;
    margin: 10mm 12mm;
}

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: "Segoe UI", "DejaVu Sans", Arial, Helvetica, sans-serif;
    font-size: 8.5pt;
    line-height: 1.3;
    columns: 2;
    column-gap: 20px;
    color: #1a1a1a;
}

h1 {
    column-span: all;
    font-size: 16pt;
    margin-bottom: 4px;
    padding-bottom: 3px;
    border-bottom: 2px solid #333;
}

/* Description line right after h1 */
h1 + p {
    column-span: all;
    font-size: 8pt;
    color: #666;
    margin-bottom: 8px;
}

section {
    break-inside: avoid;
    margin-bottom: 6px;
}

h2 {
    font-size: 10pt;
    margin-bottom: 3px;
    padding: 2px 4px;
    background: #2a2a2a;
    color: #fff;
    border-radius: 2px;
}

h3 {
    font-size: 8.5pt;
    margin-bottom: 2px;
    color: #444;
    border-bottom: 1px solid #ccc;
    padding-bottom: 1px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 4px;
    font-size: 8pt;
}

th {
    background: #f0f0f0;
    font-weight: 600;
    text-align: left;
    padding: 2px 4px;
    border: 1px solid #ddd;
    font-size: 7.5pt;
}

td {
    padding: 1.5px 4px;
    border: 1px solid #ddd;
    vertical-align: top;
}

tr:nth-child(even) {
    background: #fafafa;
}

code {
    font-family: "JetBrains Mono", "Fira Code", "DejaVu Sans Mono", "Courier New", monospace;
    font-size: 7.5pt;
    background: #f0f0f0;
    padding: 0.5px 3px;
    border-radius: 2px;
    white-space: nowrap;
}

p {
    margin-bottom: 3px;
    font-size: 8pt;
}

ul, ol {
    margin-bottom: 4px;
    padding-left: 16px;
    font-size: 8pt;
}

li {
    margin-bottom: 1px;
}

strong {
    font-weight: 600;
}

hr {
    display: none;
}
"""


def wrap_sections(html: str) -> str:
    """Wrap each h2 section (h2 + content until next h2/end) in <section> tags.
    Also wrap h3 sub-sections to prevent splitting."""
    # First, wrap h3 sub-sections within the content
    # Split by h2 first
    parts = re.split(r'(<h2[^>]*>)', html)

    result = []
    for i, part in enumerate(parts):
        if part.startswith('<h2'):
            # Start collecting this h2 section
            heading = part
            # Content is the next part
            if i + 1 < len(parts):
                content = parts[i + 1]
                # Wrap h3 sub-sections within this content
                content = wrap_h3_sections(content)
                result.append(f'<section>{heading}{content}</section>')
            else:
                result.append(f'<section>{heading}</section>')
        elif i == 0 or not parts[i - 1].startswith('<h2'):
            # Content before first h2 or standalone content
            result.append(part)

    return ''.join(result)


def wrap_h3_sections(html: str) -> str:
    """Wrap each h3 + its following content in <section> tags."""
    parts = re.split(r'(<h3[^>]*>)', html)

    result = []
    for i, part in enumerate(parts):
        if part.startswith('<h3'):
            heading = part
            if i + 1 < len(parts):
                content = parts[i + 1]
                result.append(f'<section>{heading}{content}</section>')
            else:
                result.append(f'<section>{heading}</section>')
        elif i == 0 or not parts[i - 1].startswith('<h3'):
            result.append(part)

    return ''.join(result)


def md_to_pdf(md_path: str) -> None:
    base = os.path.splitext(md_path)[0]
    pdf_path = base + '.pdf'

    with open(md_path, 'r') as f:
        md_content = f.read()

    html_body = markdown.markdown(md_content, extensions=['tables', 'fenced_code'])
    html_body = wrap_sections(html_body)

    html = f"""<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>{CSS}</style>
</head>
<body>
{html_body}
</body>
</html>"""

    # Write temp HTML, convert with Chromium
    with tempfile.NamedTemporaryFile(mode='w', suffix='.html', dir=SCRIPT_DIR,
                                      delete=False) as tmp:
        tmp.write(html)
        tmp_path = tmp.name

    try:
        subprocess.run([
            'chromium',
            '--headless',
            '--disable-gpu',
            '--no-sandbox',
            f'--print-to-pdf={pdf_path}',
            '--no-pdf-header-footer',
            f'file://{tmp_path}',
        ], check=True, capture_output=True, text=True)
        print(f"  {pdf_path}")
    finally:
        os.unlink(tmp_path)


def main():
    md_files = sorted(
        f for f in os.listdir(SCRIPT_DIR) if f.endswith('.md')
    )

    if not md_files:
        print("No .md files found in", SCRIPT_DIR)
        sys.exit(1)

    print("Exporting to PDF:")
    for f in md_files:
        md_to_pdf(os.path.join(SCRIPT_DIR, f))
    print("Done.")


if __name__ == '__main__':
    main()
