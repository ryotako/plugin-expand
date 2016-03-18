function expand:execute -d "Executes word expansion on the current token"
  # Choose a filter.
  if not set -q FILTER
    if type -q peco
      set FILTER 'peco --prompt ">" --layout bottom-up'
    else if type -q percol
      set FILTER 'percol'
    else if type -q fzf
      set FILTER 'fzf'
    else if type -q selecta
      set FILTER 'selecta'
    end
  end

  # Iterate available expansions for one that matches the current token.
  for expansion in $__word_expansions
    set -l expansion (echo $expansion)

    # Check if the expansion condition matches the token.
    if eval "$expansion[1]" > /dev/null
      # If the expansion matches, execute the expander and use its output as replacements.
      if set -l new (eval "$expansion[2]" | sed '/^\s*$/d')
        set replacements $replacements $new
      end
    end
  end

  # If a filter is specified and more than one replacement is available, use it to filter through the available
  # replacements.
  if begin; set -q replacements[2]; and set -q FILTER; end
    for line in $replacements
      echo $line
    end | eval "$FILTER" | read replacement

    # Interactive filters will cause Fish to need a repaint.
    commandline -f repaint

    # If a replacement was chosen, use it.
    if test -n "$replacement"
      commandline -t -r "$replacement"
    end

  # If only one replacement is available, just use it without prompt.
  else if set -q replacements[1]
    # No filter is specified, so just use the top replacement.
    commandline -t -r "$replacements[1]"

  # No replacements are available for the current token, so defer to regular completion.
  else
    commandline -f complete
  end
end
