-- ============================================
-- 额外实用插件集合
-- 使用方法:
-- 1. 在 init.lua 中导入: import = "plugins.extra"
-- 2. 或复制特定插件到你的 lazy.setup 配置中
-- ============================================

return {
  -- ============================================
  -- 代码导航和结构化
  -- ============================================

  -- 🗺️ 代码大纲/符号导航 (类似 VSCode 的 Outline)
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
          split_command = nil,
          width = 25,
          relative_width = true,
          auto_close = false,
          auto_jump = false,
          jump_highlight_duration = 300,
          center_on_jump = true,
          show_numbers = false,
          show_relative_numbers = false,
          wrap = false,
          show_cursorline = true,
          hide_cursor = false,
          focus_on_open = true,
          winhl = "",
        },
        outline_items = {
          show_symbol_details = true,
          show_symbol_lineno = false,
          highlight_hovered_item = true,
          auto_update_events = {
            follow = { "CursorMoved" },
            items = { "BufWritePost" },
          },
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
          auto_unfold = {
            hovered = true,
            only = true,
          },
        },
        preview_window = {
          auto_preview = false,
          open_hover_on_preview = false,
          width = 50,
          min_width = 50,
          relative_width = true,
          height = 50,
          min_height = 10,
          relative_height = true,
          border = "rounded",
          winhl = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          winblend = 0,
          live = false,
        },
        keymaps = {
          show_help = "?",
          close = { "<Esc>", "q" },
          goto_location = "<Cr>",
          peek_location = "o",
          goto_and_close = "<S-Cr>",
          restore_location = "<C-g>",
          hover_symbol = "<C-space>",
          toggle_preview = "K",
          rename_symbol = "r",
          code_actions = "a",
          fold = "h",
          unfold = "l",
          fold_toggle = "<Tab>",
          fold_toggle_all = "<S-Tab>",
          fold_all = "W",
          unfold_all = "E",
          fold_reset = "R",
          down_and_jump = "<C-j>",
          up_and_jump = "<C-k>",
        },
        providers = {
          priority = { "lsp", "treesitter", "markdown" },
          lsp = {
            blacklist_clients = {},
          },
          treesitter = {
            blacklist_filetypes = {},
          },
          markdown = {
            blacklist_filetypes = {},
          },
        },
      })
    end,
  },

  -- 🔖 会话管理增强 (替代 auto-session)
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.stdpath("state") .. "/sessions/",
        options = { "buffers", "curdir", "tabpages", "winsize" },
        pre_save = nil,
        save_empty = false,
      })

      vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore session" })
      vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end, { desc = "Select session" })
      vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Restore last session" })
      vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't save session" })
    end,
  },

  -- ============================================
  -- 编辑效率工具
  -- ============================================

  -- 🎯 多光标编辑 (类似 VSCode 的 Ctrl+D)
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_mouse_mappings = 1
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
        ["Select All"] = "\\sa",
        ["Start Regex Search"] = "\\/",
        ["Add Cursor Down"] = "<C-Down>",
        ["Add Cursor Up"] = "<C-Up>",
        ["Add Cursor At Pos"] = "\\\\",
        ["Visual Regex"] = "\\/",
        ["Visual All"] = "\\sa",
        ["Visual Add"] = "\\a",
        ["Visual Find"] = "\\f",
        ["Visual Cursors"] = "\\c",
      }
      vim.g.VM_theme = "ocean"
      vim.g.VM_highlight_matches = "underline"
    end,
  },

  -- 📝 更好的粘贴体验 (智能处理缩进)
  {
    "sickill/vim-pasta",
    event = "VeryLazy",
  },

  -- 🔍 缩进检测 (自动检测缩进风格)
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- 📐 对齐工具 (替代 tabular)
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", desc = "Easy align", mode = { "n", "x" } },
    },
  },

  -- ============================================
  -- 代码运行和测试
  -- ============================================

  -- ▶️ 代码片段运行器
  {
    "michaelb/sniprun",
    branch = "master",
    build = "sh install.sh",
    cmd = { "SnipRun", "SnipInfo" },
    keys = {
      { "<leader>r", "<cmd>SnipRun<CR>", desc = "Run code snippet", mode = { "n", "v" } },
      { "<leader>rr", "<cmd>SnipRun<CR>", desc = "Run code snippet" },
      { "<leader>rc", "<cmd>SnipClose<CR>", desc = "Close SnipRun" },
      { "<leader>ri", "<cmd>SnipInfo<CR>", desc = "SnipRun info" },
    },
    config = function()
      require("sniprun").setup({
        selected_interpreters = {},
        repl_enable = {},
        repl_disable = {},
        interpreter_options = {},
        display = {
          "Classic",
          "VirtualTextOk",
          "VirtualTextErr",
          "TempFloatingWindow",
        },
        display_options = {
          terminal_scrollback = vim.o.scrollback,
          terminal_line_number = false,
          terminal_signcolumn = false,
          terminal_persistence = true,
          terminal_width = 45,
        },
        show_no_output = {
          "Classic",
          "TempFloatingWindow",
        },
        live_mode_toggle = "off",
        borders = "rounded",
      })
    end,
  },

  -- 🧪 测试运行器
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
      { "<leader>ts", function() require("neotest").run.stop() end, desc = "Stop test" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Open test output" },
      { "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
      { "<leader>tl", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
          }),
          require("neotest-jest")({
            jestCommand = "npm test --",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-vitest"),
        },
        status = { virtual_text = true, signs = true },
        output = { open_on_run = true },
      })
    end,
  },

  -- ============================================
  -- Git 增强
  -- ============================================

  -- 🔀 冲突解决工具
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

      vim.keymap.set("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", { desc = "Toggle git blame" })
      vim.keymap.set("n", "<leader>gB", "<cmd>GitBlameOpenCommitURL<CR>", { desc = "Open commit URL" })
    end,
  },

  -- ============================================
  -- 数据库工具
  -- ============================================
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<CR>", desc = "Toggle DB UI" },
    },
    config = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_win_position = "right"
      vim.g.db_ui_winwidth = 40
    end,
  },

  -- ============================================
  -- HTTP 客户端
  -- ============================================
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "http",
    keys = {
      { "<leader>rr", "<cmd>Rest run<CR>", desc = "Run HTTP request" },
      { "<leader>rl", "<cmd>Rest last<CR>", desc = "Run last HTTP request" },
    },
    config = function()
      require("rest-nvim").setup({
        client = "curl",
        env_file = ".env",
        env_pattern = "\\.env$",
        encode_url = true,
        show_icons = "on_request",
        timeout = 15000,
        result = {
          show_url = true,
          show_http_info = true,
          show_headers = true,
          formatters = {
            json = "jq",
          },
        },
        highlight = {
          enabled = true,
          timeout = 150,
        },
      })
    end,
  },

  -- ============================================
  -- Markdown 增强
  -- ============================================
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = { "markdown" },
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle markdown preview", ft = "markdown" },
    },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_theme = "dark"
    end,
  },

  -- ============================================
  -- 窗口管理增强
  -- ============================================
  {
    "sindrets/winshift.nvim",
    cmd = "WinShift",
    keys = {
      { "<C-W><C-M>", "<cmd>WinShift<CR>", desc = "WinShift" },
      { "<C-W>m", "<cmd>WinShift<CR>", desc = "WinShift" },
      { "<C-W>X", "<cmd>WinShift swap<CR>", desc = "Swap windows" },
    },
    config = function()
      require("winshift").setup({
        highlight_moving_win = true,
        focused_hl_group = "Visual",
        moving_win_options = {
          wrap = false,
          cursorline = false,
          cursorcolumn = false,
          colorcolumn = "",
        },
      })
    end,
  },

  -- ============================================
  -- 代码截图分享
  -- ============================================
  {
    "michaelrommel/nvim-silicon",
    lazy = true,
    cmd = "Silicon",
    keys = {
      { "<leader>ss", ":Silicon<CR>", desc = "Screenshot code", mode = "v" },
    },
    config = function()
      require("silicon").setup({
        font = "JetBrainsMono Nerd Font=26",
        theme = "Dracula",
        background = "#7AA2F7",
        pad_horiz = 100,
        pad_vert = 80,
        line_number = true,
        line_pad = 2,
        tab_width = 4,
        round_corner = true,
        window_controls = true,
        output = {
          path = "/home/sming/Pictures/Screenshots",
          format = "silicon_[year][month][day]_[hour][minute][second].png",
        },
        clipboard = true,
      })
    end,
  },

  -- ============================================
  -- AI 辅助编程
  -- ============================================
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          ["."] = false,
        },
      })
    end,
  },

  -- ============================================
  -- 实用小工具
  -- ============================================

  -- 📝 更好的输入体验 (jk 退出插入模式)
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        timeout = vim.o.timeoutlen,
        default_mappings = true,
        mappings = {
          i = {
            j = {
              k = "<Esc>",
              j = "<Esc>",
            },
          },
          c = {
            j = {
              k = "<Esc>",
              j = "<Esc>",
            },
          },
          t = {
            j = {
              k = "<C-\\><C-n>",
            },
          },
          v = {
            j = {
              k = "<Esc>",
            },
          },
          s = {
            j = {
              k = "<Esc>",
            },
          },
        },
      })
    end,
  },

  -- 📋 更好的寄存器管理
  {
    "tversteeg/registers.nvim",
    cmd = "Registers",
    config = function()
      require("registers").setup({
        window = {
          border = "rounded",
          transparency = 10,
        },
      })
    end,
    keys = {
      { "\"", "<cmd>Registers<cr>", desc = "Registers", mode = { "n", "v" } },
      { "<C-R>", "<cmd>Registers<cr>", desc = "Registers", mode = "i" },
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

  -- 🎯 大文件优化
  {
    "LunarVim/bigfile.nvim",
    event = { "FileReadPre", "BufReadPre", "User FileOpened" },
    opts = {
      filesize = 2,
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
}
