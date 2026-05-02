local lspKeys = function(client, bufnr)
    local base_opts = { noremap = true, silent = false, buffer = bufnr }

    local function opts(desc) return vim.tbl_extend('error', base_opts, { desc = desc }) end

    local mappings = {
        { mode = { 'n', 'x' },      key = '<space>a', fn = vim.lsp.buf.code_action,                                          desc = 'Code action' },
        { mode = 'n',               key = '<space>e', fn = vim.lsp.buf.declaration,                                          desc = 'Declaration' },
        { mode = 'n',               key = '<space>h', fn = function() vim.lsp.buf.hover({ border = 'none' }) end,            desc = 'Hover' },
        { mode = 'n',               key = '<space>c', fn = vim.lsp.buf.outgoing_calls,                                       desc = 'Outgoing calls' },
        { mode = 'n',               key = '<space>C', fn = vim.lsp.buf.incoming_calls,                                       desc = 'Incoming calls' },
        { mode = 'n',               key = '<space>m', fn = vim.lsp.buf.rename,                                               desc = 'Rename' },
        { mode = 'n',               key = '<space>D', fn = vim.lsp.buf.type_definition,                                      desc = 'Type definition' },
        { mode = { 'n', 'i', 'x' }, key = '<C-k>',    fn = vim.lsp.buf.signature_help,                                       desc = 'Signature help' },
        { mode = 'n',               key = '<space>v', fn = function() vim.diagnostic.open_float({ border = 'rounded' }) end, desc = 'Diagnostics Float' },
        { mode = 'n',               key = '<A-o>',    fn = '<cmd>ClangdSwitchSourceHeader<CR>',                              desc = 'Switch Source/Header' },
    }

    for _, map in ipairs(mappings) do
        vim.keymap.set(map.mode, map.key, map.fn, opts(map.desc))
    end

    if client:supports_method('inlayHintProvider') then
        vim.keymap.set(
            'n',
            '<space>i',
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr }) end,
            opts('Toggle inlay hints')
        )
    end
end

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'SmiteshP/nvim-navic',
    },
    lazy = false,
    config = function()
        local servers = {
            basedpyright = {},
            ruff = {},
            clangd = {},
            stylua = {},
            lua_ls = {
                on_init = function(client)
                    client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = {
                            version = 'LuaJIT',
                            path = { 'lua/?.lua', 'lua/?/init.lua' },
                        },
                        workspace = {
                            checkThirdParty = false,
                            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
                            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
                            library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                                '${3rd}/luv/library',
                                '${3rd}/busted/library',
                            }),
                        },
                    })
                end,
                ---@type lspconfig.settings.lua_ls
                settings = {
                    Lua = {
                        format = { enable = false }, -- Disable formatting (formatting is done by stylua)
                    },
                },
            },
            jsonls = {},
            dockerls = {},
            yamlls = {},
            neocmake = {},
            -- 'markdown_oxide',
            taplo = {},
        }

        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = servers,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
        vim.lsp.config('*', {
            capabilities = capabilities,
        })

        vim.lsp.enable(servers)

        local lsp_group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true })
        vim.api.nvim_create_autocmd('LspAttach', {
            group = lsp_group,
            desc = 'Set buffer-local keymaps and options after an LSP client attaches',
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then
                    return
                end
                lspKeys(client, bufnr)

                if client.server_capabilities.completionProvider then
                    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()'
                end

                if client.server_capabilities.documentSymbolProvider then
                    local navic = require('nvim-navic')
                    navic.attach(client, bufnr)
                end
            end,
        })
    end,
}
