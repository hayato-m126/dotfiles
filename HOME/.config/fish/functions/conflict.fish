function conflict
  OUTPUT_FILE="merge_conflict_$(date +%Y%m%d_%H%M%S).md"

  echo "# Merge Conflict Resolution" > "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
  echo "Date: $(date)" >> "$OUTPUT_FILE"
  echo "Branch: $(git branch --show-current)" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"

  echo "## Conflicted Files" >> "$OUTPUT_FILE"
  echo '```' >> "$OUTPUT_FILE"
  git diff --name-only --diff-filter=U >> "$OUTPUT_FILE"
  echo '```' >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"

  echo "## Conflict Details" >> "$OUTPUT_FILE"
  for file in $(git diff --name-only --diff-filter=U); do
      echo "### $file" >> "$OUTPUT_FILE"
      echo '```diff' >> "$OUTPUT_FILE"
      git diff "$file" >> "$OUTPUT_FILE"
      echo '```' >> "$OUTPUT_FILE"
      echo "" >> "$OUTPUT_FILE"
  done

  echo "Saved to: $OUTPUT_FILE"
end
