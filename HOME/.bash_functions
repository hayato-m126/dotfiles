# zstd
taz() {
  if [ $# -ne 1 ]; then
    echo "command to compress directory using zstd"
    echo "Usage: taz <dir>"
    return 1
  fi

  dir="$1"
  archive="${dir}.tar.zst"
  tar -I zstd -cvf "$archive" "$dir"
}

gitca() {
  git reset --hard HEAD && \
  git clean -df && \
  git submodule foreach git reset --hard HEAD && \
  git submodule foreach git clean -df
}

gitcl() {
  local branch="${1:?Usage: gitcl <branch> <from_commit> [output_file]}"
  local from_commit="${2:?Usage: gitcl <branch> <from_commit> [output_file]}"
  local output="${3:-commits_$(echo "$branch" | tr '/' '_').csv}"

  echo "Fetching branch: ${branch} ..."
  git fetch origin "${branch}"

  # NOTE: "A..B" filters by ancestry, not by date. Unrelated/merged-in old
  # histories (e.g. imported from another project) can still show up even
  # though they are older than from_commit, because they are not its ancestor.
  # Filter by from_commit's date too, so only commits made after it are kept.
  local since_date
  since_date=$(git show -s --format=%aI "${from_commit}")

  echo "Extracting commits: ${from_commit}..FETCH_HEAD (since ${since_date}) ..."
  local tmpfile
  tmpfile=$(mktemp)
  git log "${from_commit}..FETCH_HEAD" --since="${since_date}" --pretty=format:"%H|||%s|||%an|||%aI" > "${tmpfile}"

  local commit_count
  commit_count=$(wc -l < "${tmpfile}")
  echo "Found ${commit_count} commits."

  python3 -c "
import csv
import re
import sys

tmpfile = sys.argv[1]
output = sys.argv[2]

with open(tmpfile, 'r', encoding='utf-8') as f:
    lines = f.read().strip().split('\n')

rows = []
for line in lines:
    parts = line.split('|||')
    if len(parts) != 4:
        continue
    commit_hash, title, author, commit_date = parts
    m = re.search(r'\(#(\d+)\)', title)
    pr_number = m.group(1) if m else ''
    rows.append([commit_hash, commit_date, pr_number, title, author])

with open(output, 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['Commit Hash', 'Commit Date', 'PR Number', 'Commit Title', 'Author'])
    for row in rows:
        writer.writerow(row)

print(f'Output: {output} ({len(rows)} commits)')
" "${tmpfile}" "${output}"

  rm -f "${tmpfile}"
}

conflict() {
  OUTPUT_FILE="merge_conflict_$(date +%Y%m%d_%H%M%S).md"
  CONFLICTED_FILES="$(git diff --name-only --diff-filter=U)"
  if [[ -z "$CONFLICTED_FILES" ]]; then
    CONFLICTED_COUNT=0
  else
    CONFLICTED_COUNT="$(printf '%s\n' "$CONFLICTED_FILES" | wc -l)"
  fi

  echo "# Merge Conflict" > "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
  echo "Date: $(date)" >> "$OUTPUT_FILE"
  echo "Branch: $(git branch --show-current)" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"

  echo "Conflicted files: $CONFLICTED_COUNT" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"

  echo "## Conflicted Files" >> "$OUTPUT_FILE"
  echo '```' >> "$OUTPUT_FILE"
  printf '%s\n' "$CONFLICTED_FILES" >> "$OUTPUT_FILE"
  echo '```' >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"

  echo "## Conflict Details" >> "$OUTPUT_FILE"
  while IFS= read -r file; do
    [[ -z "$file" ]] && continue
    echo "### $file" >> "$OUTPUT_FILE"
    echo '```diff' >> "$OUTPUT_FILE"
    git diff "$file" >> "$OUTPUT_FILE"
    echo '```' >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
  done <<< "$CONFLICTED_FILES"

  echo "Saved to: $OUTPUT_FILE"
}

__fzf_history_search() {
    local result
    result=$(history | tac | awk '{$1=""; print substr($0,2)}' | fzf) &&
    READLINE_LINE="$result"
    READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-r": __fzf_history_search'

__ghq_cd() {
  # ghqで管理しているリポジトリ一覧からfzfで選択し、そのディレクトリへ移動
  local repo_dir
  repo_dir=$(ghq list -p | fzf)
  if [[ -n "$repo_dir" ]]; then
    cd "$repo_dir" || return 1
  fi
}
bind -x '"\C-g": __ghq_cd'

# fishのabbrのように、alias名の後にスペースを押すと実体のコマンドへ展開する
declare -A __ABBR_MAP=()

# スペース押下のたびにサブシェルでaliasを引かないよう、事前に連想配列へキャッシュする
__abbr_refresh() {
  __ABBR_MAP=()
  local line name value
  while IFS= read -r line; do
    [[ $line =~ ^alias\ ([^=]+)=(.*)$ ]] || continue
    name="${BASH_REMATCH[1]}"
    value="${BASH_REMATCH[2]}"
    value="${value#\'}"
    value="${value%\'}"
    __ABBR_MAP["$name"]="$value"
  done < <(alias -p)
}
__abbr_refresh

__abbr_expand() {
  local cursor=$READLINE_POINT
  local line="$READLINE_LINE"
  local before="${line:0:cursor}"
  local after="${line:cursor}"
  local word="${before##*[[:space:]]}"
  local head="${before%"$word"}"
  local expansion=""

  # コマンド位置(行頭・; | & ( の直後)にある単語だけをalias展開の対象にする
  if [[ -n "$word" && "$head" =~ (^[[:space:]]*$|[\;\|\&\(][[:space:]]*$) ]]; then
    expansion="${__ABBR_MAP[$word]}"
  fi

  if [[ -n "$expansion" ]]; then
    READLINE_LINE="${head}${expansion} ${after}"
    READLINE_POINT=$((${#head} + ${#expansion} + 1))
  else
    READLINE_LINE="${before} ${after}"
    READLINE_POINT=$((cursor + 1))
  fi
}
bind -x '" ": __abbr_expand'
