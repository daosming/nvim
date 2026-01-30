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
  
  -- 示例：LSP 配置
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      -- 配置具体 LSP 服务器
      -- lspconfig.lua_ls.setup({})
    end,
  },
}
