function expand:match -d 'Matches a pattern against the current word' -a pattern
  commandline -t | grep -q $pattern
end
