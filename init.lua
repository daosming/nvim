-- 引导 lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 设置 mapleader（必须在加载插件前设置）
vim.g.mapleader = " "
vim.g.maplocalleader = " \\"

-- 加载插件
require("lazy").setup({
  -- ============================================
  -- 外观主题
  -- ============================================
  
  -- 主题 - TokyoNight（默认）
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
          variables = {},
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help", "nvim-tree", "terminal", "packer", "toggleterm" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = true,
        on_colors = function(colors)
          colors.bg_statusline = colors.none
        end,
        on_highlights = function(hl, c)
          hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg }
          hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopePromptNormal = { bg = c.bg_dark }
          hl.TelescopePromptBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopePromptTitle = { bg = c.bg_dark, fg = c.fg }
          hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.fg }
          hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.fg }
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- 主题 - Catppuccin（备选，非常受欢迎）
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = { enabled = false },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = { "bold" },
          keywords = { "italic" },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = { "bold" },
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          mini = { enabled = true, indentscope_color = "" },
          native_lsp = {
            enabled = true,
            virtual_text = { errors = { "italic" }, hints = { "italic" }, warnings = { "italic" }, information = { "italic" }, ok = { "italic" } },
            underlines = { errors = { "underline" }, hints = { "underline" }, warnings = { "underline" }, information = { "underline" }, ok = { "underline" } },
            inlay_hints = { background = true },
          },
          telescope = { enabled = true, style = "nvchad" },
          lsp_trouble = true,
          which_key = true,
          indent_blankline = { enabled = true, scope_color = "lavender", colored_indent_levels = false },
          dashboard = true,
          bufferline = true,
          markdown = true,
          noice = true,
          ufo = true,
        },
      })
    end,
  },

  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local colors = {
        bg       = "#1f2335",
        fg       = "#bbc2cf",
        yellow   = "#ECBE7B",
        cyan     = "#008080",
        darkblue = "#081633",
        green    = "#98be65",
        orange   = "#FF8800",
        violet   = "#a9a1e1",
        magenta  = "#c678dd",
        blue     = "#51afef",
        red      = "#ec5f67",
      }
      
      local conditions = {
        buffer_not_empty = function() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 end,
        hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }
      
      local config = {
        options = {
          component_separators = "",
          section_separators = "",
          theme = { normal = { c = { fg = colors.fg, bg = colors.bg } }, inactive = { c = { fg = colors.fg, bg = colors.bg } } },
          globalstatus = true,
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }
      
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end
      
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end
      
      -- 左侧组件
      ins_left({ function() return "▊" end, color = { fg = colors.blue }, padding = { left = 0, right = 1 } })
      ins_left({ function() return "" end, color = function() local mode_color = { n = colors.red, i = colors.green, v = colors.blue, [""] = colors.blue, V = colors.blue, c = colors.magenta, no = colors.red, s = colors.orange, S = colors.orange, [""] = colors.orange, ic = colors.yellow, R = colors.violet, Rv = colors.violet, cv = colors.red, ce = colors.red, r = colors.cyan, rm = colors.cyan, ["r?"] = colors.cyan, ["!"] = colors.red, t = colors.red } return { fg = mode_color[vim.fn.mode()] } end, padding = { right = 1 } })
      ins_left({ "filesize", cond = conditions.buffer_not_empty })
      ins_left({ "filename", cond = conditions.buffer_not_empty, color = { fg = colors.magenta, gui = "bold" } })
      ins_left({ "location" })
      ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })
      ins_left({ "diagnostics", sources = { "nvim_diagnostic" }, symbols = { error = " ", warn = " ", info = " " }, diagnostics_color = { error = { fg = colors.red }, warn = { fg = colors.yellow }, info = { fg = colors.cyan } } })
      ins_left({ function() return "%=" end })
      ins_left({ function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then return msg end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then return client.name end
        end
        return msg
      end, icon = " LSP:", color = { fg = colors.fg, gui = "bold" } })
      
      -- 右侧组件
      ins_right({ "o:encoding", fmt = string.upper, cond = conditions.hide_in_width, color = { fg = colors.green, gui = "bold" } })
      ins_right({ "fileformat", fmt = string.upper, icons_enabled = false, color = { fg = colors.green, gui = "bold" } })
      ins_right({ "branch", icon = "", color = { fg = colors.violet, gui = "bold" } })
      ins_right({ "diff", symbols = { added = " ", modified = " ", removed = " " }, diff_color = { added = { fg = colors.green }, modified = { fg = colors.orange }, removed = { fg = colors.red } }, cond = conditions.hide_in_width })
      ins_right({ function() return "▊" end, color = { fg = colors.blue }, padding = { left = 1 } })
      
      require("lualine").setup(config)
    end,
  },

  -- 缓冲区标签页
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          style_preset = require("bufferline").style_preset.default,
          themable = true,
          numbers = "ordinal",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = { icon = "▎", style = "icon" },
          buffer_close_icon = "",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 18,
          max_prefix_length = 15,
          truncate_names = true,
          tab_size = 18,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          offsets = {
            { filetype = "NvimTree", text = "File Explorer", text_align = "center", separator = true },
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          show_duplicate_prefix = true,
          duplicates_across_groups = true,
          persist_buffer_sort = true,
          move_wraps_at_ends = false,
          separator_style = "slant",
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          auto_toggle_bufferline = true,
          hover = { enabled = true, delay = 200, reveal = { "close" } },
          sort_by = "insert_after_current",
        },
      })
    end,
  },

  -- ============================================
  -- 文件管理
  -- ============================================
  
  -- 文件树
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
      vim.keymap.set("n", "<leader>E", ":NvimTreeFindFile<CR>", { desc = "Find file in tree" })
    end,
  },

  -- 模糊查找器
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      
      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
          },
        },
      })
      
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
      -- yanky extension will be loaded after yanky is loaded
      
      -- 快捷键
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
      vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
      vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
    end,
  },

  -- ============================================
  -- 编辑增强
  -- ============================================
  
  -- 语法高亮
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { 
          "lua", "python", "javascript", "typescript", "tsx",
          "c", "cpp", "go", "rust", "bash", "json", 
          "yaml", "toml", "markdown", "html", "css", "scss", "vim", "vimdoc",
          "java", "vue", "svelte", "prisma", "graphql", "dockerfile"
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- 自动标签闭合 (HTML/JSX/Vue 等)
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({})
    end,
  },

  -- 自动括号配对
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  },

  -- 快速注释
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- 包围符号操作
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- 快速跳转
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    config = function()
      require("flash").setup()
      vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
      vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
    end,
  },

  -- ============================================
  -- 自动补全
  -- ============================================
  
  -- 补全引擎
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            scrollbar = true,
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Search:None",
          }),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            show_labelDetails = true,
            before = function(entry, vim_item)
              vim_item.menu = ({
                nvim_lsp = "「LSP」",
                luasnip = "「片段」",
                buffer = "「缓冲区」",
                path = "「路径」",
              })[entry.source.name] or "「其他」"
              return vim_item
            end,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
      
      -- 命令行补全美化
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },

  -- ============================================
  -- 代码格式化
  -- ============================================
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python = { "ruff_format", "ruff_organize_imports" },
          lua = { "stylua" },
          -- 前端格式化
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          vue = { "prettier" },
          svelte = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          less = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          jsonc = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          java = { "google-java-format" },
          -- Rust 格式化
          rust = { "rustfmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
      
      -- 手动格式化快捷键
      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        require("conform").format({ async = true })
      end, { desc = "Format code" })
    end,
  },

  -- ============================================
  -- Python 虚拟环境选择器
  -- ============================================
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    event = "VeryLazy",
    config = function()
      require("venv-selector").setup({
        settings = {
          search = {
            my_venvs = {
              command = "fd 'python$' ~/.venvs --full-path --color never -L",
            },
          },
          options = {
            on_telescope_result_callback = function(filepath)
              return require("venv-selector").utils.remove_last_slash(filepath)
            end,
            notify_user_on_venv_activation = true,
          },
        },
      })
    end,
    keys = {
      { "<leader>ve", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
      { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select cached venv" },
    },
  },

  -- ============================================
  -- 代码检查 (Linting)
  -- ============================================
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "ruff" },
        -- 前端代码检查
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
        svelte = { "eslint_d" },
      }
      
      -- 自动触发 lint
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
      
      vim.keymap.set("n", "<leader>cl", function()
        lint.try_lint()
      end, { desc = "Run linter" })
    end,
  },

  -- ============================================
  -- Java 开发环境 (nvim-java)
  -- ============================================
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-refactor",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    config = function()
      require("java").setup({
        -- JDK 配置
        jdk = {
          -- 自动检测 JAVA_HOME
          auto_install = false,
        },
        -- 根目录检测
        root_markers = {
          "pom.xml",
          "build.gradle",
          "build.gradle.kts",
          ".git",
        },
        -- LSP 配置
        java_test = {
          enable = true,
        },
        java_debug_adapter = {
          enable = true,
        },
        spring_boot_tools = {
          enable = true,
        },
        -- 通知设置
        notifications = {
          dap = true,
        },
      })
    end,
  },

  -- ============================================
  -- LSP 支持
  -- ============================================
  
  -- LSP 配置
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { 
          "lua_ls", "pyright", "ts_ls", "jdtls",
          -- 前端 LSP
          "html", "cssls", "tailwindcss", "eslint",
          "jsonls", "yamlls", "vuels", "svelte",
          "prismals", "graphql",
          -- Rust LSP
          "rust_analyzer",
        },
      })
      
      -- 确保安装 Java 格式化工具
      local registry = require("mason-registry")
      registry.refresh(function()
        local pkg = registry.get_package("google-java-format")
        if not pkg:is_installed() then
          pkg:install()
        end
      end)
      
      -- 确保安装前端格式化工具和 linter
      local frontend_tools = { "prettier", "eslint_d" }
      for _, tool in ipairs(frontend_tools) do
        local ok, pkg = pcall(registry.get_package, tool)
        if ok and not pkg:is_installed() then
          pkg:install()
        end
      end
      
      -- 确保安装 Rust 工具链
      local rust_tools = { "codelldb" }  -- Rust 调试器
      for _, tool in ipairs(rust_tools) do
        local ok, pkg = pcall(registry.get_package, tool)
        if ok and not pkg:is_installed() then
          pkg:install()
        end
      end
      
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- 配置 Python LSP (pyright)
      -- 配置 Python LSP (pyright)
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })
      vim.lsp.enable("pyright")
      
      -- 配置 Java LSP (jdtls) - 配合 nvim-java 使用
      vim.lsp.config("jdtls", {
        capabilities = capabilities,
        settings = {
          java = {
            configuration = {
              updateBuildConfiguration = "interactive",
            },
            format = {
              enabled = true,
            },
            saveActions = {
              organizeImports = true,
            },
            contentProvider = {
              preferred = "fernflower",
            },
            completion = {
              favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
                "org.junit.jupiter.api.DynamicContainer.*",
                "org.junit.jupiter.api.DynamicTest.*",
                "org.mockito.Mockito.*",
                "org.mockito.ArgumentMatchers.*",
                "org.mockito.Answers.*",
              },
            },
          },
        },
      })
      vim.lsp.enable("jdtls")
      
      -- TypeScript LSP (tsserver) 详细配置
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            suggest = {
              includeCompletionsForModuleExports = true,
              autoImports = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })
      vim.lsp.enable("ts_ls")
      
      -- HTML LSP
      vim.lsp.config("html", {
        capabilities = capabilities,
        settings = {
          html = {
            format = { wrapLineLength = 120, wrapAttributes = "auto" },
            hover = { documentation = true, references = true },
          },
        },
      })
      vim.lsp.enable("html")
      
      -- CSS LSP
      vim.lsp.config("cssls", {
        capabilities = capabilities,
        settings = {
          css = { validate = true, lint = { unknownAtRules = "ignore" } },
          scss = { validate = true, lint = { unknownAtRules = "ignore" } },
          less = { validate = true },
        },
      })
      vim.lsp.enable("cssls")
      
      -- Tailwind CSS LSP
      vim.lsp.config("tailwindcss", {
        capabilities = capabilities,
        settings = {
          tailwindCSS = {
            classAttributes = { "class", "className", "classList", "ngClass", "tw" },
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidConfigPath = "error",
              invalidScreen = "error",
              invalidTailwindDirective = "error",
              invalidVariant = "error",
              recommendedVariantOrder = "warning",
            },
            validate = true,
          },
        },
      })
      vim.lsp.enable("tailwindcss")
      
      -- JSON LSP
      vim.lsp.config("jsonls", {
        capabilities = capabilities,
        settings = {
          json = {
            schemas = (function()
              local ok, schemastore = pcall(require, "schemastore")
              if ok then
                return schemastore.json.schemas()
              end
              return {}
            end)(),
            validate = { enable = true },
          },
        },
      })
      vim.lsp.enable("jsonls")
      
      -- YAML LSP
      vim.lsp.config("yamlls", {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = (function()
              local ok, schemastore = pcall(require, "schemastore")
              if ok then
                return schemastore.yaml.schemas()
              end
              return {}
            end)(),
            validate = true,
            format = { enable = true },
          },
        },
      })
      vim.lsp.enable("yamlls")
      
      -- Vue LSP
      vim.lsp.config("vuels", {
        capabilities = capabilities,
        settings = {
          vetur = {
            completion = { autoImport = true, tagCasing = "kebab", useScaffoldSnippets = false },
            format = { defaultFormatter = { js = "prettier", ts = "prettier" } },
          },
        },
      })
      vim.lsp.enable("vuels")
      
      -- Svelte LSP
      vim.lsp.config("svelte", {
        capabilities = capabilities,
      })
      vim.lsp.enable("svelte")
      
      -- ESLint LSP
      vim.lsp.config("eslint", {
        capabilities = capabilities,
        settings = {
          format = false,
          quiet = false,
          run = "onType",
        },
      })
      vim.lsp.enable("eslint")
      
      -- Prisma LSP
      vim.lsp.config("prismals", {
        capabilities = capabilities,
      })
      vim.lsp.enable("prismals")
      
      -- GraphQL LSP
      vim.lsp.config("graphql", {
        capabilities = capabilities,
      })
      vim.lsp.enable("graphql")
      
      -- Rust LSP (rust-analyzer) 详细配置
      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            inlayHints = {
              bindingModeHints = {
                enable = false,
              },
              chainingHints = {
                enable = true,
              },
              closingBraceHints = {
                enable = true,
                minLines = 25,
              },
              closureReturnTypeHints = {
                enable = "never",
              },
              lifetimeElisionHints = {
                enable = "never",
                useParameterNames = false,
              },
              maxLength = 25,
              parameterHints = {
                enable = true,
              },
              reborrowHints = {
                enable = "never",
              },
              renderColons = true,
              typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
            rustfmt = {
              overrideCommand = nil,
              extraArgs = {},
            },
            completion = {
              autoimport = {
                enable = true,
              },
            },
          },
        },
      })
      vim.lsp.enable("rust_analyzer")
      
      -- 其他 LSP 服务器
      local other_servers = { "lua_ls", "gopls" }
      for _, server in ipairs(other_servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
        vim.lsp.enable(server)
      end
      
      -- LSP 快捷键
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover documentation" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      vim.keymap.set("n", "<leader>f", function() require("conform").format({ async = true }) end, { desc = "Format code" })
      
      -- 前端专属快捷键
      -- 重命名文件内所有相同单词 (适用于组件名等)
      vim.keymap.set("n", "<leader>cr", "*``cgn", { desc = "Rename next occurrence" })
      -- 组织导入 (Organize Imports)
      vim.keymap.set("n", "<leader>co", function()
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
      end, { desc = "Organize imports" })
      -- 修复所有可自动修复的问题
      vim.keymap.set("n", "<leader>cx", function()
        vim.lsp.buf.code_action({ context = { only = { "source.fixAll" } }, apply = true })
      end, { desc = "Fix all auto-fixable" })
      
      -- Java 专属快捷键
      vim.keymap.set("n", "<leader>jo", function() require("java").open_class_fully_qualified_name() end, { desc = "Java open class by FQN" })
      vim.keymap.set("n", "<leader>jc", function() require("java").clean_workspace() end, { desc = "Java clean workspace" })
      vim.keymap.set("n", "<leader>jt", function() require("java").test.run_current_class() end, { desc = "Java test current class" })
      vim.keymap.set("n", "<leader>jm", function() require("java").test.run_current_method() end, { desc = "Java test current method" })
      vim.keymap.set("n", "<leader>jv", function() require("java").test.view_last_report() end, { desc = "Java view test report" })
      
      -- Rust 专属快捷键
      vim.keymap.set("n", "<leader>cr", "<cmd>!cargo run<cr>", { desc = "Cargo run" })
      vim.keymap.set("n", "<leader>cb", "<cmd>!cargo build<cr>", { desc = "Cargo build" })
      vim.keymap.set("n", "<leader>cc", "<cmd>!cargo check<cr>", { desc = "Cargo check" })
      vim.keymap.set("n", "<leader>ct", "<cmd>!cargo test<cr>", { desc = "Cargo test" })
    end,
  },

  -- ============================================
  -- Git 集成
  -- ============================================
  
  -- Git 标记
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          
          vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
          vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
          vim.keymap.set("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { buffer = bufnr, desc = "Stage hunk" })
          vim.keymap.set("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { buffer = bufnr, desc = "Reset hunk" })
          vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
          vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
          vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
          vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
          vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { buffer = bufnr, desc = "Blame line" })
          vim.keymap.set("n", "<leader>tb", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle blame" })
          vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "Diff this" })
          vim.keymap.set("n", "<leader>hD", function() gs.diffthis("~") end, { buffer = bufnr, desc = "Diff this ~" })
          vim.keymap.set("n", "<leader>td", gs.toggle_deleted, { buffer = bufnr, desc = "Toggle deleted" })
          
          -- 文本对象
          vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr, desc = "Select hunk" })
        end,
      })
    end,
  },

  -- ============================================
  -- 工具辅助
  -- ============================================
  
  -- 快捷键提示
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      wk.setup({
        triggers = { "<leader>" }, -- 仅 leader 键触发提示
        delay = 500, -- 延迟 500ms 显示
      })
      
      -- 注册快捷键分组
      wk.add({
        { "<leader>f", group = "🔍 Find" },
        { "<leader>b", group = "Buffer" },
        { "<leader>h", group = "Git Hunk" },
        { "<leader>t", group = "Toggle" },
        -- { "<leader>u", group = "UI" }, -- 禁用，避免干扰
        { "<leader>c", group = "Code" },
        { "<leader>j", group = "Java" },
        { "<leader>e", desc = "📁 File tree" },
        { "<leader>rn", desc = "✏️ Rename" },
        { "<leader>ca", desc = "⚡ Code action" },
      })
    end,
  },

  -- 终端集成
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })
    end,
  },

  -- 会话管理
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
      })
    end,
  },

  -- 项目管理
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
      })
      require("telescope").load_extension("projects")
      vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>", { desc = "Find projects" })
    end,
  },

  -- 快速高亮当前单词
  {
    "echasnovski/mini.cursorword",
    config = function()
      require("mini.cursorword").setup()
    end,
  },

  -- 平滑滚动
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        easing_function = "quadratic",
      })
    end,
  },

  -- 更好的 UI 选择
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup()
    end,
  },

  -- 通知增强
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#1a1b26",
        fps = 60,
        icons = {
          DEBUG = "",
          ERROR = "",
          INFO = "",
          TRACE = "✎",
          WARN = "",
        },
        level = 2,
        minimum_width = 10,
        render = "compact",
        stages = "fade",
        timeout = 3000,
        top_down = false,
      })
      vim.notify = require("notify")
    end,
  },

  -- ============================================
  -- UI 美化增强
  -- ============================================

  -- 🌟 强大的 UI 美化插件（cmdline、消息、通知）
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = { enabled = true },
          signature = { enabled = true },
        },
        presets = {
          bottom_search = false,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = true,
        },
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          opts = {},
          format = {
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = " $", lang = "bash" },
            lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = " ", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = " " },
          },
        },
        views = {
          cmdline_popup = {
            position = { row = 5, col = "50%" },
            size = { width = 60, height = "auto" },
            border = { style = "rounded", padding = { 0, 1 } },
            win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" } },
          },
          popupmenu = {
            relative = "editor",
            position = { row = 8, col = "50%" },
            size = { width = 60, height = 10 },
            border = { style = "rounded", padding = { 0, 1 } },
            win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" } },
          },
        },
        routes = {
          { filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
          { filter = { event = "msg_show", find = "written" }, opts = { skip = true } },
          { filter = { event = "msg_show", find = "%d+L, %d+B" }, opts = { skip = true } },
        },
      })
    end,
  },

  -- 🎨 启动页美化
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      
      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }
      
      dashboard.section.buttons.val = {
        dashboard.button("f", "  查找文件", ":Telescope find_files<CR>"),
        dashboard.button("e", "  新建文件", ":ene <BAR> startinsert <CR>"),
        dashboard.button("p", "  项目", ":Telescope projects<CR>"),
        dashboard.button("r", "  最近文件", ":Telescope oldfiles<CR>"),
        dashboard.button("t", "  查找文本", ":Telescope live_grep<CR>"),
        dashboard.button("c", "  配置", ":e $MYVIMRC<CR>"),
        dashboard.button("q", "  退出", ":qa<CR>"),
      }
      
      dashboard.section.footer.val = {
        "",
        "   保持热爱，奔赴山海 🚀",
      }
      
      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end,
  },

  -- 🎯 补全菜单图标
  {
    "onsails/lspkind.nvim",
    config = function()
      require("lspkind").init({
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
          Copilot = "",
        },
      })
    end,
  },

  -- 🌈 彩虹括号
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = { [""] = rainbow.strategy["global"], vim = rainbow.strategy["local"] },
        query = { [""] = "rainbow-delimiters", lua = "rainbow-blocks" },
        priority = { [""] = 110, lua = 210 },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- 📜 滚动条美化
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup({
        show = true,
        show_in_active_only = false,
        set_highlights = true,
        folds = 1000,
        max_lines = false,
        hide_if_all_visible = false,
        throttle_ms = 100,
        handle = {
          text = " ",
          blend = 30,
          color = nil,
          color_nr = nil,
          highlight = "CursorColumn",
          hide_if_all_visible = true,
        },
        marks = {
          Cursor = { text = "•", priority = 0, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "Normal" },
          Search = { text = { "-", "=" }, priority = 1, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "Search" },
          Error = { text = { "-", "=" }, priority = 2, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "DiagnosticVirtualTextError" },
          Warn = { text = { "-", "=" }, priority = 3, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "DiagnosticVirtualTextWarn" },
          Info = { text = { "-", "=" }, priority = 4, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "DiagnosticVirtualTextInfo" },
          Hint = { text = { "-", "=" }, priority = 5, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "DiagnosticVirtualTextHint" },
          Misc = { text = { "-", "=" }, priority = 6, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "Normal" },
          GitAdd = { text = "│", priority = 7, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "GitSignsAdd" },
          GitChange = { text = "│", priority = 7, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "GitSignsChange" },
          GitDelete = { text = "-", priority = 7, gui = nil, color = nil, cterm = nil, color_nr = nil, highlight = "GitSignsDelete" },
        },
        excluded_buftypes = { terminal = true },
        excluded_filetypes = { "dropbar_menu", "dropbar_menu_fzf", " DressingInput", "cmp_docs", "cmp_menu", "noice", "prompt", "TelescopePrompt" },
        autocmd = {
          render = { "BufWinEnter", "TabEnter", "TermEnter", "WinEnter", "CmdwinLeave", "TextChanged", "VimResized", "WinScrolled" },
          clear = { "BufWinLeave", "TabLeave", "TermLeave", "WinLeave" },
        },
        handlers = { cursor = true, diagnostic = true, gitsigns = true, handle = true, search = false, ale = false },
      })
    end,
  },

  -- ⏳ LSP 进度指示器
  {
    "j-hui/fidget.nvim",
    opts = {
      progress = {
        poll_rate = 0,
        suppress_on_insert = false,
        ignore_done_already = false,
        ignore_empty_message = false,
        clear_on_detach = function(client_id)
          local client = vim.lsp.get_client_by_id(client_id)
          return client and client.name or nil
        end,
        notification_group = function(msg) return msg.lsp_client.name end,
        ignore = {},
        display = {
          render_limit = 16,
          done_ttl = 3,
          done_icon = "✓",
          done_style = "Constant",
          progress_ttl = math.huge,
          progress_icon = { pattern = "dots", period = 1 },
          progress_style = "WarningMsg",
          group_style = "Title",
          icon_style = "Question",
          priority = 30,
          skip_history = true,
          format_annote = function(msg) return msg.title end,
          format_group_name = function(group) return tostring(group) end,
          overrides = { rust_analyzer = { name = "rust-analyzer" } },
        },
        lsp = { progress_ringbuf_size = 0, log_handler = false },
      },
      notification = {
        poll_rate = 10,
        filter = vim.log.levels.INFO,
        history_size = 128,
        override_vim_notify = false,
        view = { stack_upwards = true, icon_separator = " ", group_separator = "---", group_separator_hl = "Comment" },
        window = { normal_hl = "Comment", winblend = 0, border = "none", zindex = 45, max_width = 0, max_height = 0, x_padding = 1, y_padding = 0, align = "bottom", relative = "editor" },
      },
      integration = { ["nvim-tree"] = { enable = false }, ["xcodebuild-nvim"] = { enable = false } },
      logger = { level = vim.log.levels.WARN, float_precision = 0.01, path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")) },
    },
  },

  -- 🔄 撤销/重做高亮
  {
    "tzachar/highlight-undo.nvim",
    opts = {
      duration = 300,
      undo = { hlgroup = "HighlightUndo", mode = "n", lhs = "u", map = "undo", opts = {} },
      redo = { hlgroup = "HighlightUndo", mode = "n", lhs = "<C-r>", map = "redo", opts = {} },
      highlight_for_count = true,
    },
  },

  -- 🎭 漂亮的代码折叠 UI
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      
      require("ufo").setup({ fold_virt_text_handler = handler })
      
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open folds except kinds" })
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close folds with" })
      vim.keymap.set("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then vim.lsp.buf.hover() end
      end, { desc = "Peek fold or hover" })
    end,
  },

  -- ✨ 光标动画
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
      hide_target_hack = false,
      cursor_color = "#ff7a69",
    },
  },

  -- ============================================
  -- 高效操作增强
  -- ============================================

  -- 🎯 Harpoon - 快速文件标记和跳转
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })

      -- 快捷键
      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add file" })
      vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
      vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Harpoon file 5" })
      vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon next" })
      vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon previous" })
    end,
  },

  -- 🔍 Spectre - 全局搜索和替换
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("spectre").setup({
        color_devicons = true,
        open_cmd = "vnew",
        live_update = true,
        line_sep_start = "┌-----------------------------------------",
        result_padding = "¦  ",
        line_sep = "└-----------------------------------------",
        highlight = {
          ui = "String",
          search = "DiffChange",
          replace = "DiffDelete",
        },
        mapping = {
          ["tab"] = {
            map = "<Tab>",
            cmd = "<cmd>lua require('spectre').tab()<cr>",
            desc = "next query",
          },
          ["shift-tab"] = {
            map = "<S-Tab>",
            cmd = "<cmd>lua require('spectre').tab_shift()<cr>",
            desc = "previous query",
          },
          ["toggle_line"] = {
            map = "dd",
            cmd = "<cmd>lua require('spectre').toggle_line()<cr>",
            desc = "toggle item",
          },
          ["enter_file"] = {
            map = "<cr>",
            cmd = "<cmd>lua require('spectre').enter_file()<cr>",
            desc = "open file",
          },
          ["send_to_qf"] = {
            map = "<leader>q",
            cmd = "<cmd>lua require('spectre').send_to_qf()<cr>",
            desc = "send all items to quickfix",
          },
          ["replace_cmd"] = {
            map = "<leader>c",
            cmd = "<cmd>lua require('spectre').replace_cmd()<cr>",
            desc = "input replace command",
          },
          ["show_option_menu"] = {
            map = "<leader>o",
            cmd = "<cmd>lua require('spectre').show_options()<cr>",
            desc = "show options",
          },
          ["run_current_replace"] = {
            map = "<leader>rc",
            cmd = "<cmd>lua require('spectre').run_current_replace()<cr>",
            desc = "replace current line",
          },
          ["run_replace"] = {
            map = "<leader>r",
            cmd = "<cmd>lua require('spectre').run_replace()<cr>",
            desc = "replace all",
          },
        },
      })

      vim.keymap.set("n", "<leader>sr", "<cmd>Spectre<CR>", { desc = "Search and replace (Spectre)" })
      vim.keymap.set("n", "<leader>sw", "<cmd>SpectreWord<CR>", { desc = "Search current word" })
      vim.keymap.set("v", "<leader>sw", "<cmd>SpectreWordVisual<CR>", { desc = "Search current word" })
    end,
  },

  -- 📝 TODO Comments - 高亮 TODO 注释
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        signs = true,
        sign_priority = 8,
        keywords = {
          FIX = { icon = "", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = "", color = "info" },
          HACK = { icon = "", color = "warning" },
          WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = "", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = "", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        gui_style = {
          fg = "NONE",
          bg = "BOLD",
        },
        merge_keywords = true,
        highlight = {
          multiline = true,
          multiline_pattern = "^\\.",
          multiline_context = 10,
          before = "",
          keyword = "wide",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_len = 400,
          exclude = {},
        },
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" },
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          pattern = [[\b(KEYWORDS):]],
        },
      })

      vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
      vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
      vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "Find TODOs" })
      vim.keymap.set("n", "<leader>fT", ":TodoLocList<CR>", { desc = "TODO list (quickfix)" })
    end,
  },

  -- ⚠️ Trouble - 诊断列表
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        position = "bottom",
        height = 10,
        width = 50,
        icons = true,
        mode = "workspace_diagnostics",
        severity = nil,
        fold_open = "▼",
        fold_closed = "▶",
        group = true,
        padding = true,
        cycle_results = true,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = { "<cr>", "<tab>" },
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = { "o" },
          toggle_mode = "m",
          switch_severity = "s",
          toggle_preview = "p",
          hover = "p",
          preview = "p",
          open_code_href = "c",
          close_folds = { "zM", "zm" },
          open_folds = { "zR", "zr" },
          toggle_fold = { "zA", "za" },
          previous = "k",
          next = "j",
          help = "?",
        },
        multiline = true,
        indent_lines = true,
        win_config = { border = "rounded" },
        auto_open = false,
        auto_close = false,
        auto_preview = true,
        auto_fold = false,
        auto_jump = { "lsp_definitions" },
        signs = {
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "",
        },
        use_diagnostic_signs = true,
      })

      vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
      vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
      vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols (Trouble)" })
      vim.keymap.set("n", "<leader>xl", "<cmd>Trouble lsp toggle<cr>", { desc = "LSP Definitions / references" })
      vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List" })
      vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List" })
    end,
  },

  -- 💡 Illuminate - 高亮当前单词的所有出现
  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure({
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 100,
        filetype_overrides = {},
        filetypes_denylist = {
          "dirbuf",
          "dirvish",
          "fugitive",
        },
        filetypes_allowlist = {},
        modes_denylist = {},
        modes_allowlist = {},
        providers_regex_syntax_denylist = {},
        providers_regex_syntax_allowlist = {},
        under_cursor = true,
        large_file_cutoff = nil,
        large_file_overrides = nil,
        min_count_to_highlight = 1,
        case_insensitive_regex = false,
      })
    end,
  },

  -- 🌲 Treesitter Context - 显示当前函数/类的上下文
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 5,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
        on_attach = nil,
      })
    end,
  },

  -- 🍞 Barbecue - 面包屑导航
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup({
        attach_navic = false,
        show_modified = true,
        show_dirname = true,
        show_basename = true,
        show_navic = true,
        lead_custom_section = function() return " " end,
        custom_section = function() return " " end,
        theme = "tokyonight",
        context_follow_icon_color = true,
        symbols = {
          separator = "›",
          ellipsis = "…",
          modified = "●",
          default_context = "",
        },
        kinds = {
          Array = "",
          Boolean = "",
          Class = "",
          Color = "",
          Constant = "",
          Constructor = "",
          Enum = "",
          EnumMember = "",
          Event = "",
          Field = "",
          File = "",
          Folder = "",
          Function = "",
          Interface = "",
          Key = "",
          Keyword = "",
          Method = "",
          Module = "",
          Namespace = "",
          Null = "",
          Number = "",
          Object = "",
          Operator = "",
          Package = "",
          Property = "",
          Reference = "",
          Snippet = "",
          String = "",
          Struct = "",
          Text = "",
          TypeParameter = "",
          Unit = "",
          Value = "",
          Variable = "",
        },
      })
    end,
  },

  -- 🪟 Smart Splits - 智能窗口分割
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      require("smart-splits").setup({
        ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
        ignored_buftypes = { "nofile" },
        default_amount = 3,
        at_edge = "wrap",
        float_win_behavior = "previous",
        move_cursor_same_row = false,
        cursor_follows_swapped_bufs = false,
        resize_mode = {
          quit_key = "<ESC>",
          resize_keys = { "h", "j", "k", "l" },
          silent = false,
          hooks = {
            on_enter = nil,
            on_leave = nil,
          },
        },
        ignored_events = {
          "BufEnter",
          "WinEnter",
        },
        multiplexer_integration = nil,
        disable_multiplexer_nav_when_zoomed = true,
        kitty_password = nil,
        log_level = "info",
      })

      -- 窗口导航
      vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Move to left window" })
      vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Move to down window" })
      vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move to up window" })
      vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Move to right window" })
      -- 调整窗口大小
      vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { desc = "Resize left" })
      vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { desc = "Resize down" })
      vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { desc = "Resize up" })
      vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { desc = "Resize right" })
      -- 交换窗口
      vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left, { desc = "Swap buffer left" })
      vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down, { desc = "Swap buffer down" })
      vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up, { desc = "Swap buffer up" })
      vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right, { desc = "Swap buffer right" })
    end,
  },

  -- 📋 Better Quickfix - 更好的 quickfix 体验
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup({
        auto_enable = true,
        magic_window = true,
        auto_resize_height = true,
        preview = {
          auto_preview = true,
          show_title = true,
          show_scroll_bar = true,
          delay_syntax = 50,
          border = "rounded",
          buf_label = true,
          win_height = 15,
          win_vheight = 15,
          win_blend = 12,
          wrap = false,
          should_preview_cb = nil,
        },
        func_map = {
          drop = "o",
          openc = "O",
          split = "<C-s>",
          vsplit = "<C-v>",
          tabdrop = "<C-t>",
          tabc = "",
          ptogglemode = "zp",
          ptoggleitem = "p",
          ptoggleauto = "P",
          preview = "p",
          close = "q",
          refresh = "r",
          lastleave = "\"",
          stoggleup = "<S-Tab>",
          stoggledown = "<Tab>",
          stogglevm = "<Tab>",
          stogglebuf = "<M-z>",
          sclear = "z<Tab>",
          prev = "k",
          next = "j",
          prevhist = "<Up>",
          nexthist = "<Down>",
          prevfile = "<C-p>",
          nextfile = "<C-n>",
          prevhist = "<",
          nexthist = ">",
          sr_toggle = "<C-r>",
          filter = "zf",
          filterr = "zF",
          fzffilter = "f",
        },
        filter = {
          fzf = {
            action_for = {
              ["ctrl-t"] = "tabedit",
              ["ctrl-v"] = "vsplit",
              ["ctrl-x"] = "split",
              ["ctrl-q"] = "signtoggle",
              ["ctrl-c"] = "close",
            },
            extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
          },
        },
      })
    end,
  },

  -- 📊 Diffview - Git diff 视图
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { "git" },
        hg_cmd = { "hg" },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,
        icons = {
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "",
        },
        view = {
          default = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
          win_config = {
            position = "left",
            width = 35,
            win_opts = {},
          },
        },
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
          },
          win_config = {
            position = "bottom",
            height = 16,
            win_opts = {},
          },
        },
        commit_log_panel = {
          win_config = {
            win_opts = {},
          },
        },
        default_args = {
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },
        hooks = {},
        keymaps = {
          disable_defaults = false,
          view = {
            ["<tab>"] = "select_next_entry",
            ["<s-tab>"] = "select_prev_entry",
            ["gf"] = "goto_file",
            ["<C-w><C-f>"] = "goto_file_split",
            ["<C-w>gf"] = "goto_file_tab",
            ["<leader>e"] = "focus_files",
            ["<leader>b"] = "toggle_files",
          },
          file_panel = {
            ["j"] = "next_entry",
            ["<down>"] = "next_entry",
            ["k"] = "prev_entry",
            ["<up>"] = "prev_entry",
            ["<cr>"] = "select_entry",
            ["o"] = "select_entry",
            ["<2-LeftMouse>"] = "select_entry",
            ["-"] = "toggle_stage_entry",
            ["S"] = "stage_all",
            ["U"] = "unstage_all",
            ["X"] = "restore_entry",
            ["R"] = "refresh_files",
            ["L"] = "open_commit_log",
            ["<c-b>"] = "scroll_view(-0.25)",
            ["<c-f>"] = "scroll_view(0.25)",
            ["<tab>"] = "select_next_entry",
            ["<s-tab>"] = "select_prev_entry",
            ["gf"] = "goto_file",
            ["<C-w><C-f>"] = "goto_file_split",
            ["<C-w>gf"] = "goto_file_tab",
            ["i"] = "listing_style",
            ["f"] = "toggle_flatten_dirs",
            ["<leader>e"] = "focus_files",
            ["<leader>b"] = "toggle_files",
          },
          file_history_panel = {
            ["g!"] = "options",
            ["<C-A-d>"] = "open_in_diffview",
            ["y"] = "copy_hash",
            ["L"] = "open_commit_log",
            ["zR"] = "open_all_folds",
            ["zM"] = "close_all_folds",
            ["j"] = "next_entry",
            ["<down>"] = "next_entry",
            ["k"] = "prev_entry",
            ["<up>"] = "prev_entry",
            ["<cr>"] = "select_entry",
            ["o"] = "select_entry",
            ["<2-LeftMouse>"] = "select_entry",
            ["<c-b>"] = "scroll_view(-0.25)",
            ["<c-f>"] = "scroll_view(0.25)",
            ["<tab>"] = "select_next_entry",
            ["<s-tab>"] = "select_prev_entry",
            ["gf"] = "goto_file",
            ["<C-w><C-f>"] = "goto_file_split",
            ["<C-w>gf"] = "goto_file_tab",
            ["<leader>e"] = "focus_files",
            ["<leader>b"] = "toggle_files",
          },
          option_panel = {
            ["<tab>"] = "select",
            ["q"] = "close",
          },
        },
      })

      vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Git diff view" })
      vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>", { desc = "Git file history" })
      vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory %<CR>", { desc = "Current file history" })
      vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" })
    end,
  },

  -- 📋 Yanky - 增强的剪贴板历史
  {
    "gbprod/yanky.nvim",
    dependencies = {
      { "kkharji/sqlite.lua", module = "sqlite" },
    },
    config = function()
      require("yanky").setup({
        ring = {
          history_length = 100,
          storage = "sqlite",
          sync_with_numbered_registers = true,
          cancel_event = "update",
          ignore_registers = { "_" },
          update_register_on_cycle = false,
        },
        picker = {
          select = {
            action = nil,
          },
          telescope = {
            use_default_mappings = true,
            mappings = nil,
          },
        },
        system_clipboard = {
          sync_with_ring = true,
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 200,
        },
        preserve_cursor_position = {
          enabled = true,
        },
        textobj = {
          enabled = true,
        },
      })

      vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Paste after" })
      vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Paste before" })
      vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "Gpaste after" })
      vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Gpaste before" })
      vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)", { desc = "Previous yank entry" })
      vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)", { desc = "Next yank entry" })
      vim.keymap.set("n", "<leader>fy", "<cmd>Telescope yank_history<CR>", { desc = "Yank history" })
    end,
  },

  -- 🎬 LazyGit - Git TUI 集成
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      -- Configure lazygit via global variables
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
      vim.g.lazygit_floating_window_use_plenary = 0
      vim.g.lazygit_use_neovim_remote = 1

      vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })
      vim.keymap.set("n", "<leader>gf", "<cmd>LazyGitCurrentFile<CR>", { desc = "LazyGit current file" })
      vim.keymap.set("n", "<leader>gc", "<cmd>LazyGitFilter<CR>", { desc = "LazyGit filter" })
      vim.keymap.set("n", "<leader>gC", "<cmd>LazyGitFilterCurrentFile<CR>", { desc = "LazyGit filter current file" })
    end,
  },

  -- 🧘 Zen Mode - 专注模式
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.95,
          width = 120,
          height = 1,
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = false,
            cursorcolumn = false,
            foldcolumn = "0",
            list = false,
          },
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false,
            showcmd = false,
            laststatus = 0,
          },
          twilight = { enabled = true },
          gitsigns = { enabled = false },
          tmux = { enabled = false },
          todo = { enabled = false },
          kitty = {
            enabled = false,
            font = "+4",
          },
          alacritty = {
            enabled = false,
            font = "14",
          },
          wezterm = {
            enabled = false,
            font = "+4",
          },
        },
        on_open = function(win) end,
        on_close = function() end,
      })

      vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Toggle Zen Mode" })
    end,
  },

  -- 🌆 Twilight - 聚焦当前代码块
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.25,
          color = { "Normal", "#ffffff" },
          term_bg = "#000000",
          inactive = false,
        },
        context = 10,
        treesitter = true,
        expand = {
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {},
      })

      vim.keymap.set("n", "<leader>tw", "<cmd>Twilight<CR>", { desc = "Toggle Twilight" })
    end,
  },

  -- 🔄 Live Command - 实时预览命令效果
  {
    "smjonas/live-command.nvim",
    config = function()
      require("live-command").setup({
        commands = {
          Norm = { cmd = "norm" },
          G = { cmd = "g" },
          S = { cmd = "s" },
        },
        highlight_duration = 300,
      })
    end,
  },

  -- 📊 Marks - 更好的标记管理
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup({
        default_mappings = false,
        signs = true,
        mappings = {
          set_next = "m,",
          next = "m]",
          preview = "m:",
          set_bookmark0 = "m0",
          prev = false,
        },
      })

      vim.keymap.set("n", "<leader>mm", "<cmd>MarksListBuf<CR>", { desc = "List buffer marks" })
      vim.keymap.set("n", "<leader>mM", "<cmd>MarksListGlobal<CR>", { desc = "List global marks" })
      vim.keymap.set("n", "<leader>mx", "<cmd>MarksDeleteBuf<CR>", { desc = "Delete buffer marks" })
      vim.keymap.set("n", "<leader>mX", "<cmd>MarksDeleteLine<CR>", { desc = "Delete line marks" })
    end,
  },

  -- 🎨 Colorizer - 颜色代码高亮
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = true,
          RRGGBBAA = true,
          AARRGGBB = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
          mode = "background",
          tailwind = true,
          sass = { enable = false, parsers = { "css" } },
          virtualtext = "■",
          always_update = false,
        },
        buftypes = {},
      })
    end,
  },

  -- 📝 Wilder - 命令行补全增强
  {
    "gelguy/wilder.nvim",
    dependencies = {
      "romgrk/fzy-lua-native",
    },
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })

      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.python_file_finder_pipeline({
            file_command = function(ctx, arg)
              if string.find(arg, ".") ~= nil then
                return { "fd", "-tf", "-H" }
              else
                return { "fd", "-tf" }
              end
            end,
            dir_command = { "fd", "-td" },
            filters = { "fuzzy_filter", "difflib_sorter" },
          }),
          wilder.substitute_pipeline({
            pipeline = wilder.python_search_pipeline({
              skip_cmdtype_check = 1,
              pattern = wilder.python_fuzzy_pattern({
                start_at_boundary = 0,
              }),
            }),
          }),
          wilder.cmdline_pipeline({
            language = "python",
            fuzzy = 1,
          }),
          {
            wilder.check(function(ctx, x) return x == "" end),
            wilder.history(),
          },
          wilder.python_search_pipeline({
            pattern = wilder.python_fuzzy_pattern({
              start_at_boundary = 0,
            }),
          })
        ),
      })

      local highlighters = {
        wilder.pcre2_highlighter(),
        wilder.lua_fzy_highlighter(),
      }

      local popupmenu_renderer = wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
          border = "rounded",
          empty_message = wilder.popupmenu_empty_message_with_spinner(),
          highlighter = highlighters,
          left = {
            " ",
            wilder.popupmenu_devicons(),
            wilder.popupmenu_buffer_flags({
              flags = " a + ",
              icons = { ["+"] = "", a = "", h = "" },
            }),
          },
          right = {
            " ",
            wilder.popupmenu_scrollbar(),
          },
        })
      )

      local wildmenu_renderer = wilder.wildmenu_renderer({
        highlighter = highlighters,
        separator = " · ",
        left = { " ", wilder.wildmenu_spinner(), " " },
        right = { " ", wilder.wildmenu_index() },
      })

      wilder.set_option("renderer", wilder.renderer_mux({
        [":"] = popupmenu_renderer,
        ["/"] = wildmenu_renderer,
        substitute = wildmenu_renderer,
      }))
    end,
  },

  -- 🕐 VSCode-like 彩色缩进线
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      require("ibl").setup({
        indent = { char = "│", highlight = highlight },
        scope = { enabled = true },
      })
    end,
  },

  -- 🎬 Neovim 透明背景
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        groups = {
          "Normal",
          "NormalNC",
          "Comment",
          "Constant",
          "Special",
          "Identifier",
          "Statement",
          "PreProc",
          "Type",
          "Underlined",
          "Todo",
          "String",
          "Function",
          "Conditional",
          "Repeat",
          "Operator",
          "Structure",
          "LineNr",
          "NonText",
          "SignColumn",
          "CursorLine",
          "CursorLineNr",
          "StatusLine",
          "StatusLineNC",
          "EndOfBuffer",
        },
        extra_groups = {},
        exclude_groups = {},
        on_clear = function() end,
      })

      vim.keymap.set("n", "<leader>tb", "<cmd>TransparentToggle<CR>", { desc = "Toggle transparent background" })
    end,
  },

  -- 📦 Neoconf - 管理 LSP/DAP/linter/formatter 的本地配置
  {
    "folke/neoconf.nvim",
    config = function()
      require("neoconf").setup({
        local_settings = ".nvim.json",
        global_settings = "nvim-global.json",
        import = {
          vscode = true,
          coc = false,
          nlsp = false,
        },
        live_reload = true,
        filetype_json_config = {
          default = "json",
          glob = { "*.json" },
        },
      })
    end,
  },

  -- ============================================
  -- 更多实用插件 (2024 推荐)
  -- ============================================

  -- 🗺️ 代码大纲/符号导航 - 类似 VSCode 的 Outline
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    config = function()
      require("outline").setup({
        outline_window = {
          position = "right",
          width = 25,
          auto_close = false,
          focus_on_open = true,
        },
        guides = {
          enabled = true,
          markers = {
            bottom = "└",
            middle = "├",
            vertical = "│",
          },
        },
        symbol_folding = {
          autofold_depth = 1,
          auto_unfold = { hovered = true },
        },
        keymaps = {
          close = { "<Esc>", "q" },
          goto_location = "<Cr>",
          peek_location = "p",
          fold = "h",
          unfold = "l",
          fold_toggle = "<Tab>",
          fold_all = "W",
          unfold_all = "E",
        },
      })
    end,
  },

  -- 🎯 多光标编辑 - 类似 VSCode 的 Ctrl+D
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
        ["Select All"] = "\\sa",
        ["Add Cursor Down"] = "<C-Down>",
        ["Add Cursor Up"] = "<C-Up>",
      }
      vim.g.VM_theme = "ocean"
    end,
  },

  -- 🔍 缩进检测 - 自动检测缩进风格
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- 📐 对齐工具 - 快速对齐代码
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", desc = "Easy align", mode = { "n", "x" } },
    },
  },

  -- 🔀 Git 冲突解决工具
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = "copen",
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
      })
    end,
  },

  -- 👁️ Git blame 内嵌显示
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    config = function()
      require("gitblame").setup({
        enabled = false,
        message_template = "  󰇮 <author> • <date> • <summary>",
        date_format = "%Y-%m-%d %H:%M",
        virtual_text_column = 1,
      })
      vim.keymap.set("n", "<leader>gB", "<cmd>GitBlameToggle<CR>", { desc = "Toggle git blame" })
    end,
  },

  -- 📋 更好的寄存器管理
  {
    "tversteeg/registers.nvim",
    cmd = "Registers",
    config = function()
      require("registers").setup({
        window = { border = "rounded", transparency = 10 },
      })
    end,
    keys = {
      { "\"", "<cmd>Registers<cr>", desc = "Registers", mode = { "n", "v" } },
      { "<C-R>", "<cmd>Registers<cr>", desc = "Registers", mode = "i" },
    },
  },

  -- 📝 更好的 jk 退出插入模式
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        mappings = {
          i = { j = { k = "<Esc>", j = "<Esc>" } },
          c = { j = { k = "<Esc>", j = "<Esc>" } },
          t = { j = { k = "<C-\\><C-n>" } },
          v = { j = { k = "<Esc>" } },
          s = { j = { k = "<Esc>" } },
        },
      })
    end,
  },

  -- 🔧 自动保存
  {
    "okuuva/auto-save.nvim",
    version = "^1.0.0",
    cmd = "ASToggle",
    event = { "InsertLeave", "TextChanged" },
    keys = {
      { "<leader>as", "<cmd>ASToggle<CR>", desc = "Toggle auto-save" },
    },
    opts = {
      enabled = false,
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost" },
        defer_save = { "InsertLeave", "TextChanged" },
        cancel_deferred_save = { "InsertEnter" },
      },
      debounce_delay = 1000,
    },
  },

  -- 🎯 大文件优化 - 自动禁用耗资源功能
  {
    "LunarVim/bigfile.nvim",
    event = { "FileReadPre", "BufReadPre", "User FileOpened" },
    opts = {
      filesize = 2, -- MB
      pattern = { "*" },
      features = {
        "indent_blankline",
        "illuminate",
        "lsp",
        "treesitter",
        "syntax",
        "matchparen",
        "vimopts",
        "filetype",
      },
    },
  },

  -- 🌐 翻译工具
  {
    "potamides/pantran.nvim",
    cmd = "Pantran",
    keys = {
      { "<leader>tr", "<cmd>Pantran<CR>", desc = "Translate", mode = { "n", "v" } },
    },
    config = function()
      require("pantran").setup({
        default_engine = "google",
        engines = {
          google = {
            default_source = "auto",
            default_target = "zh",
          },
        },
      })
    end,
  },

  -- 📊 启动时间分析
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
})

-- ============================================
-- 基本设置
-- ============================================

-- 行号和相对行号
vim.opt.number = true
vim.opt.relativenumber = true

-- 缩进设置 (2空格适合前端开发)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- 显示设置
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "80,120"
vim.opt.signcolumn = "yes"

-- 搜索设置
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- 性能设置
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.redrawtime = 1500
vim.opt.maxmempattern = 2000000

-- 编辑体验
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- 折叠设置（使用 treesitter）
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

-- 撤销文件
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- ============================================
-- UI 美化细节配置
-- ============================================

-- 更漂亮的折叠样式
vim.opt.fillchars = {
  fold = " ",
  foldopen = "▼",
  foldclose = "▶",
  foldsep = " ",
  diff = "╱",
  eob = " ",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}

-- 诊断图标和样式配置
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 4,
    source = "if_many",
    severity = { min = vim.diagnostic.severity.HINT },
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
})

-- 浮动窗口边框样式
vim.opt.winblend = 0
vim.opt.pumblend = 0

-- 高亮当前行号
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number,line"

-- 启动时禁用 netrw（使用 nvim-tree）
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ============================================
-- 基础快捷键
-- ============================================

-- 设置本地变量
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 前端开发快捷键
-- 快速创建 JSX 注释
keymap("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
keymap("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })
-- 快速打开 package.json
keymap("n", "<leader>ep", function()
  local package_json = vim.fn.findfile("package.json", vim.fn.getcwd() .. ";")
  if package_json ~= "" then
    vim.cmd("edit " .. package_json)
  else
    vim.notify("package.json not found", vim.log.levels.WARN)
  end
end, { desc = "Edit package.json" })
-- 快速在浏览器中打开当前文件 (需要 live-server 或类似工具)
keymap("n", "<leader>ob", function()
  local file = vim.fn.expand("%:p")
  local cmd = string.format("xdg-open '%s' 2>/dev/null || open '%s' 2>/dev/null || echo 'Cannot open browser'", file, file)
  vim.fn.system(cmd)
end, { desc = "Open file in browser" })

-- 窗口导航
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- 调整窗口大小
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- 缓冲区操作
keymap("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
keymap("n", "<leader>bw", ":bwipeout<CR>", { desc = "Wipeout buffer" })

-- 快速保存和退出
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>Q", ":qa!<CR>", { desc = "Force quit all" })

-- 快速移动
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- 取消搜索高亮
keymap("n", "<Esc>", ":nohlsearch<CR>", opts)

-- 在可视模式下移动文本
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- 保持粘贴后寄存器内容
keymap("v", "p", '"_dP', opts)

-- 系统剪贴板复制粘贴
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
keymap("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })
keymap({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
keymap({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from clipboard" })

-- 快速编辑配置文件
keymap("n", "<leader>ev", ":e $MYVIMRC<CR>", { desc = "Edit init.lua" })
keymap("n", "<leader>sv", ":source $MYVIMRC<CR>", { desc = "Source init.lua" })

-- 主题切换 (UI -> Theme)
keymap("n", "<leader>ut", function()
  local themes = { "tokyonight", "tokyonight-night", "tokyonight-storm", "tokyonight-day", "catppuccin", "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha" }
  local current = vim.g.colors_name or "tokyonight"
  vim.ui.select(themes, { prompt = "Select theme (current: " .. current .. "):" }, function(choice)
    if choice then vim.cmd("colorscheme " .. choice) end
  end)
end, { desc = "🎨 Change theme" })

-- 分屏
keymap("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split" })
keymap("n", "<leader>s", ":split<CR>", { desc = "Horizontal split" })

-- 退出终端模式
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
