local MiniDym = {}
local H = {}


function MiniDym.setup(config)
    -- Export the module
    _G.MiniDym = MiniDym

    -- Setup Config
    config = H.setup_config(config)

    -- Apply Config
    H.apply_config(config)

    -- Enable VimBufEnter events
    vim.cmd([[augroup minidym]])
    vim.cmd([[autocmd!]])
    vim.cmd([[autocmd BufNewFile * lua MiniDym.dym()]])
    vim.cmd([[augroup END]])
end

MiniDym.config = {
    -- Nothing for now
}

function MiniDym.get_matching_files()
    local matching_files = vim.fn.split(
        vim.fn.glob(
            vim.fn.expand("%") .. "*",
            0
        ),
        "\n"
    )
    if not next(matching_files) then
        matching_files = vim.fn.split(
            vim.fn.glob(
                vim.fn.expand("%") .. "*",
                0
            ),
            "\n"
        )
    end
    return matching_files
end

function MiniDym.DYMHandle(item)
    vim.api.nvim_command("e " .. item)
end

function MiniDym.dym()
    -- Check if file is readable, it may have been handled by another BufNewFile event
    print("Starting DYM")
    if vim.fn.filereadable(vim.fn.expand("%")) == 1 then
        return
    end

    print("File not handled, looking for matching files")
    -- If not, we are going to find files that may be what the user meant
    local result = MiniDym.get_matching_files()
    if #result ~= 0 then
        print("Starting UI")
        vim.ui.select(
            result,
            {prompt="Did you mean: "},
            function(item, _)
                if item then
                    MiniDym.DYMHandle(item)
                end
            end
        )
    else
        print("No results, leaving new buffer")
        return
    end
end

H.default_config = MiniDym.config

function H.setup_config(config)
    -- Basic config validation
    vim.validate({ config = {config, 'table', true}})
    -- Extend default config with custom
    config = vim.tbl_deep_extend('force', H.default_config, config or {})

    return config
end

function H.apply_config(config)
    MiniDym.config = config
end

return MiniDym
-- vim: set tw=0 sw=4 ft=lua ts=4:
