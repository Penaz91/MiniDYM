MiniDYM
=======

A very small "did you mean?" plugin for Neovim. Also a rewrite of my [fzf_dym](https://github.com/Penaz91/fzf_dym) plugin.

Installing
-----------

You can use [lazy.nvim](https://github.com/folke/lazy.nvim) and the following configuration:

```
    {
        'penaz91/MiniDYM',
        config = function()
            require('minidym.minidym').setup()
        end
    },
```

You can customize the prompt as follows:

```
require('minidym.minidym').setup{
    prompt="Your custom prompt here"
}
```

Suggestions
-----------

I suggest using [dressing.nvim](https://github.com/stevearc/dressing.nvim) (now archived) or [snacks.nvim](https://github.com/folke/snacks.nvim) to patch the native `nvim.ui.select` with a fuzzy finder (like FZF).
