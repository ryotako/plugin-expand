function do-expand-word -d "Binding that provides word expansion"
  # Get the current token to complete.
  set -l token (commandline -t)

  # Match the token against available expansions.
  for func in $__word_expansions
    if begin; test -n "$func"; and set -l expansion (eval "$func" "'$token'"); end
      commandline -t -r "$expansion"
      return 0
    end
  end

  # Defer to regular completion.
  commandline -f complete
end
