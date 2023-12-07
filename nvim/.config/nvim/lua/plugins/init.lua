return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = { style = "moon" },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = "BufReadPost",
    build = ":TSUpdate",
    config = function()
      vim.defer_fn(function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
          highlight = { enable = true },
          indent = { enable = true },
        })
      end, 0)
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension('fzf')
    end,
    cmd = "Telescope",
  },
  { "williamboman/mason.nvim", lazy = false, config = true },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "mason.nvim",
      { "williamboman/mason-lspconfig.nvim" },
      { "folke/neodev.nvim",                config = true },
    },
    config = function()
      -- Create an augroup that is used for managing our formatting autocmds.
      --      We need one augroup per client to make sure that multiple clients
      --      can attach to the same buffer without interfering with each other.
      local _augroups = {}
      local get_augroup = function(client)
        if not _augroups[client.id] then
          local group_name = 'kickstart-lsp-format-' .. client.name
          local id = vim.api.nvim_create_augroup(group_name, { clear = true })
          _augroups[client.id] = id
        end

        return _augroups[client.id]
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
        -- This is where we attach the autoformatting for reasonable clients
        callback = function(args)
          local client_id = args.data.client_id
          local client = vim.lsp.get_client_by_id(client_id)
          local bufnr = args.buf

          -- Only attach to clients that support document formatting
          if not client.server_capabilities.documentFormattingProvider then
            return
          end

          -- Tsserver usually works poorly. Sorry you work with bad languages
          -- You can remove this line if you know what you're doing :)
          if client.name == 'tsserver' then
            return
          end

          -- Create an autocmd that will run *before* we save the buffer.
          --  Run the formatting command for the LSP that has just attached.
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = get_augroup(client),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                async = false,
                filter = function(c)
                  return c.id == client.id
                end,
              }
            end,
          })
        end,
      })
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup()
      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local function on_attach(_, bufnr)
        local opts = { buffer = bufnr }
        local keymap = vim.keymap.set
        keymap("n", "gD", vim.lsp.buf.declaration, opts)
        keymap("n", "gd", vim.lsp.buf.definition, opts)
        keymap("n", "K", vim.lsp.buf.hover, opts)
        keymap("n", "gI", vim.lsp.buf.implementation, opts)
        keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
        keymap({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
        keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap("n", "gs", vim.lsp.buf.signature_help, opts)
        keymap('n', '<space>bf', function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end

      -- this is optional
      local server_settings = {
        ["lua_ls"] = {
          Lua = {
            completion = {
              callSnippet = "Replace"
            }
          }
        }
      }

      mason_lspconfig.setup_handlers {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = server_settings[server_name]
          })
        end,
      }
    end
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "nvim-lspconfig",
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          { "rafamadriz/friendly-snippets" },
          { 'saadparwaiz1/cmp_luasnip' },
        },
        config = function()
          -- require("luasnip").config.setup({})
          require("luasnip.loaders.from_vscode").lazy_load()
        end
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require('luasnip')
      cmp.setup({
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(2),
          ["<C-u>"] = cmp.mapping.scroll_docs(-2),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-f>"] = cmp.mapping(function()
            if luasnip.choice_active() then
              require("luasnip.extras.select_choice")()
            end
          end, { "i" }),
          ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable() then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i" }),
          ["<C-k>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable() then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i" }),
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" }
          },
          { name = "nvim_lua" },
          {
            { name = "buffer", keyword_length = 5, max_item_count = 3 },
            { name = "path" },
          }),
      })

      -- `/` cmdline setup.
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end
  }
}
