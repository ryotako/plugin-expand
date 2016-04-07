function expand:choose-next
  # If a filter is specified and more than one replacement is available, use it to filter through the available
  # replacements.
  if begin; set -q __expand_replacements[2]; and set -q __expand_filter; end
    for line in $__expand_replacements
      echo $line
    end | eval $__expand_filter | read -a replacement

    # Interactive filters will cause Fish to need a repaint.
    commandline -f repaint

  # Otherwise, use basic tab cycling.
  else
    # Select the top replacement.
    set replacement "$__expand_replacements[1]"
  end

  # If a replacement was chosen, use it.
  if test -n "$replacement"
    # Enquote replacements with spaces.
    if echo "$replacement" | grep -q ' '
      commandline -t -r "\"$replacement\""
    else
      commandline -t -r "$replacement"
    end
  end

  # If there are at least two replacements, cycle the replacement queue order.
  set -q __expand_replacements[2]
    and set -g __expand_replacements $__expand_replacements[2..-1] $__expand_replacements[1]
end
