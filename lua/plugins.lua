-- plugins.lua - 将插件定义分离到单独文件（可选）
-- 然后在 init.lua 中使用: require("lazy").setup("plugins")

return {
  -- 示例：语法高亮
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "javascript", "typescript", "c", "cpp" },
        highlight = { enable = true },
      })
    end,
  },
  
  -- 示例：模糊查找
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    end,
  },
  
  -- LSP 配置
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- C/C++ LSP: clangd
      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",      -- 后台索引整个项目
          "--clang-tidy",            -- 启用 clang-tidy 检查
          "--header-insertion=iwyu", -- 自动插入头文件
          "--completion-style=bundled",
          "--pch-storage=memory",    -- 预编译头存内存，提升速度
          "--cross-file-rename",     -- 支持跨文件重命名
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = lspconfig.util.root_pattern(
          ".clangd",
          ".clang-tidy",
          ".clang-format",
          "compile_commands.json",
          "compile_flags.txt",
          "configure.ac",
          ".git"
        ),
      })
    end,
  },
}
