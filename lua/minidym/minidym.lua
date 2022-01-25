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
    -- For now it's just the prompt
    prompt = "Did you mean: "
}

function MiniDym.get_filename_from_path(filename)
      return filename:match("^.+/(.+)$")
end

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
                1
            ),
            "\n"
        )
    end
    return matching_files
end

function MiniDym.DYMHandle(item)
    -- Save the empty buffer number for later removal
    local empty_buffer_nr = vim.fn.bufnr("%")
    -- Edit the selected file, this will open a new buffer
    vim.api.nvim_command("e " .. MiniDym.get_filename_from_path(item))
    -- Remove the unused buffer
    vim.api.nvim_command("silent bd " .. empty_buffer_nr)
end

function MiniDym.dym()
    -- Check if file is readable, it may have been handled by another BufNewFile event
    if vim.fn.filereadable(vim.fn.expand("%")) == 1 then
        return
    end

    -- If not, we are going to find files that may be what the user meant
    local result = MiniDym.get_matching_files()
    if #result ~= 0 then
        vim.ui.select(
            result,
            {prompt=MiniDym.config.prompt},
            function(item, _)
                if item then
                    MiniDym.DYMHandle(item)
                end
            end
        )
    else
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
