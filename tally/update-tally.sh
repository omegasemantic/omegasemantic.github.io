#!/usr/bin/env bash
# Rebuild the items block in index.html from items.txt.
# Usage: ./update-tally.sh          (rebuild and show the diff)
#        ./update-tally.sh --push   (rebuild, commit, push)
set -euo pipefail
cd "$(dirname "$0")"

SRC=items.txt
DST=index.html
MAX=12

[[ -s $SRC && -f $DST ]] || { echo "need a non-empty $SRC and $DST here" >&2; exit 1; }
grep -q 'ITEMS:BEGIN' "$DST" && grep -q 'ITEMS:END' "$DST" \
  || { echo "ITEMS:BEGIN / ITEMS:END markers missing in $DST" >&2; exit 1; }

tmp=$(mktemp ./.tally.XXXXXX)
trap 'rm -f "$tmp"' EXIT

awk -F'|' -v max="$MAX" '
  function trim(s) { gsub(/^[ \t]+|[ \t]+$/, "", s); return s }
  function err(m)  { printf "%s line %d: %s\n", FILENAME, FNR, m > "/dev/stderr"; bad = 1 }

  FNR == NR {                      # first file: items.txt
    if ($0 ~ /^[ \t]*(#|$)/) next
    if (NF != 3)                         { err("expected id|name|price"); next }
    id = trim($1); name = trim($2); price = trim($3)
    if (id !~ /^[a-z0-9_-]+$/)           { err("bad id (use a-z 0-9 _ -)"); next }
    if (seen[id]++)                      { err("duplicate id " id); next }
    if (name == "" || name ~ /["\\]/)    { err("empty name, or name has a quote or backslash"); next }
    if (price !~ /^[0-9]+(\.[0-9]|\.[0-9][0-9])?$/) { err("bad price"); next }
    n++
    row[n] = sprintf("    { id: \"%s\", name: \"%s\", price: %s },", id, name, price)
    next
  }

  /ITEMS:END/   { skip = 0 }       # second file: index.html
  !skip         { print }
  /ITEMS:BEGIN/ { for (i = 1; i <= n; i++) print row[i]; skip = 1 }

  END {
    if (n == 0)   { print "no items found in items.txt" > "/dev/stderr"; bad = 1 }
    if (n > max)  { printf "too many items (%d, max %d)\n", n, max > "/dev/stderr"; bad = 1 }
    exit bad
  }
' "$SRC" "$DST" > "$tmp"

mv "$tmp" "$DST"
trap - EXIT
echo "index.html updated."

if [[ ${1:-} == --push ]]; then
  git add items.txt index.html
  if git diff --cached --quiet -- items.txt index.html; then
    echo "No changes to commit."; exit 0
  fi
  git commit -m "Update tally items" -- items.txt index.html
  git push
else
  git --no-pager diff --stat -- index.html || true
  echo "Check it, then run: ./update-tally.sh --push"
fi
