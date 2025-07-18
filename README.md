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
            require('minidym').setup()
        end
    },
```

You can customize the prompt as follows:

```
require('minidym').setup{
    prompt="Your custom prompt here"
}
```

Or you can force filetype detection after opening the file using

```
require('minidym').setup{
    redetect_ft=true
}
```

Suggestions
-----------

I suggest one of the following plugins:

- [dressing.nvim](https://github.com/stevearc/dressing.nvim) (now archived)
- [snacks.nvim](https://github.com/folke/snacks.nvim)
- [mini.pick](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pick.md)
- [fzf_lua](https://github.com/ibhagwan/fzf-lua)

to patch the native `nvim.ui.select` with a fuzzy finder (like FZF).
