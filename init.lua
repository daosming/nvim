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
  -- 示例插件：目录树
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
    end,
  },
  
  -- 示例插件：状态栏
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end,
  },
  
  -- 示例插件：主题
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
})

-- 基本设置
vim.opt.number = true          -- 显示行号
vim.opt.relativenumber = true  -- 相对行号
vim.opt.tabstop = 2            -- Tab 宽度
vim.opt.shiftwidth = 2         -- 缩进宽度
vim.opt.expandtab = true       -- 空格代替 Tab
vim.opt.termguicolors = true   -- 真彩色支持
