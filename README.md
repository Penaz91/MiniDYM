MiniDYM
=======

A very small "did you mean?" plugin. Also a rewrite of my [fzf_dym](https://github.com/Penaz91/fzf_dym) plugin

Installing
-----------

You can use lazy.nvim and the following configuration:

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
