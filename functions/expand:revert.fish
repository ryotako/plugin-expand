function expand:revert
  # Replace the entire buffer with the original contents before any expansion was performed.
  commandline -r $__expand_last_string
end
