#!/bin/bash
# Convert org-mode file to Sphinx-compatible RST
# Usage: ./org_to_rst.sh input.org [output.rst]

set -e

INPUT="$1"
OUTPUT="${2:-${INPUT%.org}.rst}"

if [ -z "$INPUT" ]; then
    echo "Usage: $0 input.org [output.rst]"
    exit 1
fi

if [ ! -f "$INPUT" ]; then
    echo "Error: File '$INPUT' not found."
    exit 1
fi

# Check pandoc is available
if ! command -v pandoc &> /dev/null; then
    echo "Error: pandoc is not installed. Install it with:"
    echo "  sudo apt install pandoc   # Debian/Ubuntu"
    echo "  brew install pandoc       # macOS"
    exit 1
fi

# Step 1: Convert with pandoc
pandoc "$INPUT" -f org -t rst --standalone -o "$OUTPUT"

# Step 2: Post-process with Python
python3 - "$OUTPUT" <<'EOF'
import re, sys

path = sys.argv[1]
content = open(path).read()

# Remove raw org startup directive if present
content = re.sub(r'\.\. raw:: org\n\n   #\+startup:.*?\n\n', '', content)

# Replace pandoc container blocks with Sphinx directives
for container, directive in [('NOTE', 'note'), ('TIP', 'tip'), ('IMPORTANT', 'important')]:
    content = re.sub(
        r'\.\. container:: ' + container + r'\n\n(.*?)(?=\n\n(?!\s)|\Z)',
        lambda m, d=directive: f'.. {d}::\n\n' + m.group(1),
        content, flags=re.DOTALL
    )

open(path, 'w').write(content)
print(f"Done: {path}")
EOF
