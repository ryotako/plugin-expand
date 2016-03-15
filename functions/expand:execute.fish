function expand:execute -d "Executes word expansion on the current token"
  # Iterate available expansions for one that matches the current token.
  for expansion in $__word_expansions
    set -l expansion (echo $expansion)

    # If the expansion matches, execute the expander and use its output as the replacement.
    if eval "$expansion[1]" > /dev/null
      if set -l replacement (eval "$expansion[2]")
        commandline -t -r "$replacement"
        return 0
      end
    end
  end

  # Defer to regular completion.
  commandline -f complete
end
