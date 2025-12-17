function conflict
  set -l OUTPUT_FILE "merge_conflict_"(date +%Y%m%d_%H%M%S)".md"
  set -l CONFLICTED_FILES (git diff --name-only --diff-filter=U)
  set -l CONFLICTED_COUNT (count $CONFLICTED_FILES)

  echo "# Merge Conflict" > "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
  echo "Date: $(date)" >> "$OUTPUT_FILE"
  echo "Branch: $(git branch --show-current)" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"

  echo "Conflicted files: $CONFLICTED_COUNT" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"

  echo "## Conflicted Files" >> "$OUTPUT_FILE"
  echo '```' >> "$OUTPUT_FILE"
  printf '%s\n' $CONFLICTED_FILES >> "$OUTPUT_FILE"
  echo '```' >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"

  echo "## Conflict Details" >> "$OUTPUT_FILE"
  for file in $CONFLICTED_FILES
      echo "### $file" >> "$OUTPUT_FILE"
      echo '```diff' >> "$OUTPUT_FILE"
      git diff "$file" >> "$OUTPUT_FILE"
      echo '```' >> "$OUTPUT_FILE"
      echo "" >> "$OUTPUT_FILE"
  end

  echo "Saved to: $OUTPUT_FILE"
end
