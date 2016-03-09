function substitute -a token
  if echo $token | grep -q '^s/..*/.*$'
    echo "$history[1]" | sed -e "$token/g"
    return 0
  end

  return 1
end

expand-word 'substitute'
