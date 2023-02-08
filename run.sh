#!/bin/bash

pip install python-slugify

# Avoid copying over netlify.toml (will be exposed to public API)
echo "netlify.toml" >>.gitignore

# Sync Zola template contents
rsync -a __site/zola/ __site/build
rsync -a __site/content/ __site/build/content

ls -a 

# Use obsidian-export to export markdown content from obsidian
mkdir -p __site/build/content/docs __site/build/__docs
if [ -z "$STRICT_LINE_BREAKS" ]; then
	echo "reached here"
    chmod a+x __site/bin/obsidian-export
	__site/bin/obsidian-export --frontmatter=never --hard-linebreaks --no-recursive-embeds __obsidian __site/build/__docs
else
	__site/bin/obsidian-export --frontmatter=never --no-recursive-embeds __obsidian __site/build/__docs
fi

# Run conversion script
python __site/convert.py

echo "reached here next"
pwd

# Build Zola site
zola --root __site/build build --output-dir public
