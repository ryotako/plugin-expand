# expand
Word expansion for [Oh My Fish][omf].

## Overview
This plugin provides the means of adding word-by-word expansions for other plugins, as well as for your own expansions. A word expansion is a real-time substitution of the words you type on the command line.

Word expansions are triggered when you use the <kbd>TAB</kbd> key when the cursor is over a word. Before checking for your regular command completions, the current word will be checked against available word expansions. If a suitable expansion is found, the current word will be replaced with the result of the expansion. Expansions can be more than simple abbreviations; the current word can be used to introduce patterns and queries to provide dynamic expansions in real-time.


## Install
```fish
$ omf install expand
```


## Writing expansions
Writing expansions is incredibly simple. First, you need to write an expansion function. This function will take the word to expand as an argument, and print out the expanded word. If the function is able to expand the given word, it should return `0`. If the function cannot expand the given word, a non-zero value should be returned instead, and expansion will be deferred to another expander.

The function can then be registered as a word expander by calling the `expand-word` function with the correct function name. For example, we can expand the word `home` with the path contained in the `$HOME` variable as follows:

```fish
function expand_home -a word
  if test "$word" != "home"
    return 1
  end

  echo $HOME
end

expand-word 'expand_home'
```


## License
[MIT][mit] © [Stephen Coakley][author] et [al][contributors]


[author]: https://github.com/coderstephen
[completions]: http://fishshell.com/docs/current/tutorial.html#tut_tab_completions
[contributors]: https://github.com/oh-my-fish/plugin-fasd/graphs/contributors
[license-badge]: https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square
[mit]: http://opensource.org/licenses/MIT
[omf]: https://www.github.com/oh-my-fish/oh-my-fish
