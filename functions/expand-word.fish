function expand-word -d "Edit word expansions" -a expansion
  set -g __word_expansions $__word_expansions "$expansion"
end
