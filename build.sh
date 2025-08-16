#!/bin/bash
# build_site.sh - Simple recursive version that excludes docs
mkdir -p docs

# Find all .rst files recursively, excluding the docs directory
find . -name "*.rst" -type f -not -path "./docs/*" | while read -r file; do
    # Calculate relative path and create directory structure
    rel_path=$(dirname "$file" | sed 's|^\./||')

    # Skip if rel_path starts with "docs"
    if [[ "$rel_path" == docs* ]]; then
        continue
    fi

    output_dir="docs/$rel_path"
    mkdir -p "$output_dir"

    basename=$(basename "$file" .rst)
    echo "Converting $file..."
    rst2html5 \
        --stylesheet=responsive.css,minimal.css,italic-field-names.css \
        "$file" "$output_dir/$basename.html" 2>/dev/null || echo "Error converting $file (possibly due to missing includes)"
done

echo "Site built in docs/ directory"
