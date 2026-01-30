# Neovim 配置文档

基于 [lazy.nvim](https://github.com/folke/lazy.nvim) 的现代化 Neovim 配置，集成了多种效率工具，提供出色的编辑体验。

---

## 📋 目录

- [快速开始](#快速开始)
- [插件列表](#插件列表)
  - [外观主题](#外观主题)
  - [文件管理](#文件管理)
  - [编辑增强](#编辑增强)
  - [自动补全](#自动补全)
  - [LSP 支持](#lsp-支持)
  - [Git 集成](#git-集成)
  - [工具辅助](#工具辅助)
- [快捷键](#快捷键)
  - [基础快捷键](#基础快捷键)
  - [文件管理](#文件管理-1)
  - [缓冲区操作](#缓冲区操作)
  - [搜索查找](#搜索查找)
  - [LSP 相关](#lsp-相关)
  - [Python 开发](#python-开发)
  - [Git 操作](#git-操作)
- [插件使用说明](#插件使用说明)

---

## ⌨️ 常用快捷键速查

> **Leader 键**: `<Space>` (空格键)

### 最常用

| 快捷键 | 功能 |
|--------|------|
| `<Space>e` | 切换文件树 |
| `<Space>ff` | 查找文件 |
| `<Space>fg` | 全局搜索文本 |
| `<Space>w` | 保存文件 |
| `<Space>q` | 退出 |
| `<Space>bn/bp` | 下/上一个缓冲区 |
| `<Space>bd` | 关闭缓冲区 |
| `gd` | 跳转到定义 |
| `gr` | 查找引用 |
| `K` | 查看文档 |
| `<Space>rn` | 重命名 |
| `<Space>ca` | 代码操作 |
| `<Space>f` | 格式化代码 |
| `gcc` | 注释/取消注释 |
| `s` | 快速跳转 |
| `<Ctrl+\>` | 打开终端 |
| `<Space>oe` | 选择 Python 虚拟环境 |

### 文件管理 (Telescope)

| 快捷键 | 功能 |
|--------|------|
| `<Space>ff` | 查找文件 |
| `<Space>fg` | 实时搜索文本 |
| `<Space>fb` | 查找缓冲区 |
| `<Space>fr` | 最近文件 |
| `<Space>fp` | 查找项目 |
| `<Space>fk` | 查找快捷键 |
| `<Space>fh` | 查找帮助 |

### 窗口与导航

| 快捷键 | 功能 |
|--------|------|
| `<Ctrl+h/j/k/l>` | 窗口间切换 |
| `<Space>v` | 垂直分屏 |
| `<Space>s` | 水平分屏 |
| `<Ctrl+d/u>` | 翻半页并居中 |

### Git 操作

| 快捷键 | 功能 |
|--------|------|
| `<Space>hs` | 暂存 hunk |
| `<Space>hr` | 重置 hunk |
| `<Space>hp` | 预览修改 |
| `<Space>hb` | 查看 blame |
| `<Space>tb` | 切换 blame 显示 |

---

## 🚀 快速开始

### 安装要求

- Neovim >= 0.9.0
- Git
- Nerd Font（用于显示图标）
- ripgrep（用于 Telescope 实时搜索）
- 编译工具（gcc/clang，用于 treesitter 编译）

### 安装步骤

```bash
# 1. 备份原有配置
mv ~/.config/nvim ~/.config/nvim.backup

# 2. 克隆配置
git clone <your-repo> ~/.config/nvim

# 3. 启动 Neovim，插件会自动安装
nvim
```

---

## 📦 插件列表

### 外观主题

| 插件 | 描述 | 仓库 |
|------|------|------|
| **tokyonight.nvim** | 深色主题，支持多种变体 | folke/tokyonight.nvim |
| **lualine.nvim** | 底部状态栏，显示文件信息、模式等 | nvim-lualine/lualine.nvim |
| **bufferline.nvim** | 顶部缓冲区标签页，带图标 | akinsho/bufferline.nvim |
| **indent-blankline.nvim** | 显示缩进对齐线 | lukas-reineke/indent-blankline.nvim |
| **nvim-web-devicons** | 文件类型图标库 | nvim-tree/nvim-web-devicons |

### 文件管理

| 插件 | 描述 | 仓库 |
|------|------|------|
| **nvim-tree.lua** | 侧边文件树浏览器 | nvim-tree/nvim-tree.lua |
| **telescope.nvim** | 模糊查找器，支持文件/文本/符号搜索 | nvim-telescope/telescope.nvim |
| **telescope-fzf-native.nvim** | Telescope 的 fzf 排序引擎 | nvim-telescope/telescope-fzf-native.nvim |
| **project.nvim** | 项目根目录自动检测和管理 | ahmedkhalf/project.nvim |
| **auto-session** | 自动保存和恢复编辑会话 | rmagatti/auto-session |

### 编辑增强

| 插件 | 描述 | 仓库 |
|------|------|------|
| **nvim-treesitter** | 语法树解析，提供精准语法高亮 | nvim-treesitter/nvim-treesitter |
| **nvim-autopairs** | 自动补全括号、引号等配对符号 | windwp/nvim-autopairs |
| **Comment.nvim** | 快速注释/取消注释代码 | numToStr/Comment.nvim |
| **nvim-surround** | 快速添加、修改、删除包围符号 | kylechui/nvim-surround |
| **flash.nvim** | 快速跳转到任意位置 | folke/flash.nvim |
| **mini.cursorword** | 高亮当前光标下的单词 | echasnovski/mini.cursorword |
| **neoscroll.nvim** | 平滑滚动动画 | karb94/neoscroll.nvim |

### 自动补全

| 插件 | 描述 | 仓库 |
|------|------|------|
| **nvim-cmp** | 自动补全引擎主插件 | hrsh7th/nvim-cmp |
| **cmp-nvim-lsp** | LSP 补全源 | hrsh7th/cmp-nvim-lsp |
| **cmp-buffer** | 缓冲区文本补全源 | hrsh7th/cmp-buffer |
| **cmp-path** | 文件路径补全源 | hrsh7th/cmp-path |
| **cmp-cmdline** | 命令行补全源 | hrsh7th/cmp-cmdline |
| **LuaSnip** | 代码片段引擎 | L3MON4D3/LuaSnip |
| **cmp_luasnip** | LuaSnip 补全源 | saadparwaiz1/cmp_luasnip |

### LSP 支持

| 插件 | 描述 | 仓库 |
|------|------|------|
| **nvim-lspconfig** | LSP 服务器配置集合 | neovim/nvim-lspconfig |
| **mason.nvim** | LSP/DAP/格式化工具安装管理器 | williamboman/mason.nvim |
| **mason-lspconfig.nvim** | Mason 与 lspconfig 的桥梁 | williamboman/mason-lspconfig.nvim |

### Python 开发

| 插件 | 描述 | 仓库 |
|------|------|------|
| **conform.nvim** | 代码格式化工具，支持 ruff | stevearc/conform.nvim |
| **nvim-lint** | 代码检查工具，支持 ruff | mfussenegger/nvim-lint |
| **venv-selector.nvim** | Python 虚拟环境选择器，支持 venv/poetry/conda 等 | linux-cultist/venv-selector.nvim |
| **pyright** (LSP) | Python 语言服务器，提供补全和类型检查 | microsoft/pyright |

### Git 集成

| 插件 | 描述 | 仓库 |
|------|------|------|
| **gitsigns.nvim** | 显示行内 Git 状态标记，支持 blame | lewis6991/gitsigns.nvim |

### 工具辅助

| 插件 | 描述 | 仓库 |
|------|------|------|
| **which-key.nvim** | 快捷键提示面板 | folke/which-key.nvim |
| **toggleterm.nvim** | 浮动/底部终端集成 | akinsho/toggleterm.nvim |
| **dressing.nvim** | 美化 vim.ui 选择/输入界面 | stevearc/dressing.nvim |
| **nvim-notify** | 通知消息美化 | rcarriga/nvim-notify |

---

## ⌨️ 快捷键

> **说明**: `<leader>` 键默认为空格键 `Space`

### 基础快捷键

| 快捷键 | 模式 | 描述 |
|--------|------|------|
| `<C-h/j/k/l>` | Normal | 在窗口间切换（左/下/上/右） |
| `<C-Up/Down/Left/Right>` | Normal | 调整窗口大小 |
| `<C-d>` | Normal | 向下翻半页并居中 |
| `<C-u>` | Normal | 向上翻半页并居中 |
| `n/N` | Normal | 下一个/上一个搜索结果并居中 |
| `<Esc>` | Normal | 取消搜索高亮 |
| `J/K` (visual) | Visual | 移动选中的文本块 |
| `p` (visual) | Visual | 粘贴后不替换寄存器 |
| `<leader>w` | Normal | 保存文件 |
| `<leader>q` | Normal | 退出 |
| `<leader>Q` | Normal | 强制退出所有 |
| `<leader>v` | Normal | 垂直分屏 |
| `<leader>s` | Normal | 水平分屏 |
| `<leader>ev` | Normal | 编辑 init.lua |
| `<leader>sv` | Normal | 重载 init.lua |
| `<leader>y` | Normal/Visual | 复制到系统剪贴板 |
| `<leader>Y` | Normal | 复制整行到系统剪贴板 |
| `<leader>p/P` | Normal/Visual | 从系统剪贴板粘贴 |
| `<C-\>` | Normal | 打开/关闭终端 |

### 文件管理

| 快捷键 | 模式 | 描述 |
|--------|------|------|
| `<leader>e` | Normal | 切换文件树显示 |
| `<leader>E` | Normal | 在文件树中定位当前文件 |

### 缓冲区操作

| 快捷键 | 模式 | 描述 |
|--------|------|------|
| `<leader>bn` | Normal | 下一个缓冲区 |
| `<leader>bp` | Normal | 上一个缓冲区 |
| `<leader>bd` | Normal | 删除当前缓冲区 |
| `<leader>bw` | Normal | 彻底清除当前缓冲区 |

### 搜索查找 (Telescope)

| 快捷键 | 模式 | 描述 |
|--------|------|------|
| `<leader>ff` | Normal | 查找文件 |
| `<leader>fg` | Normal | 实时搜索文本内容 |
| `<leader>fb` | Normal | 查找缓冲区 |
| `<leader>fh` | Normal | 查找帮助文档 |
| `<leader>fr` | Normal | 查找最近打开的文件 |
| `<leader>fc` | Normal | 查找命令 |
| `<leader>fk` | Normal | 查找快捷键 |
| `<leader>fs` | Normal | 查找当前文档符号 |
| `<leader>fp` | Normal | 查找项目 |

### LSP 相关

| 快捷键 | 模式 | 描述 |
|--------|------|------|
| `gd` | Normal | 跳转到定义 |
| `gD` | Normal | 跳转到声明 |
| `gr` | Normal | 查找引用 |
| `gi` | Normal | 跳转到实现 |
| `K` | Normal | 显示悬停文档 |
| `<leader>rn` | Normal | 重命名符号 |
| `<leader>ca` | Normal | 代码操作（快速修复等） |
| `<leader>f` | Normal | 格式化代码 |

### Python 开发

| 快捷键 | 模式 | 描述 |
|--------|------|------|
| `<leader>oe` | Normal | 选择 Python 虚拟环境 |
| `<leader>oc` | Normal | 选择缓存的虚拟环境 |
| `<leader>f` | Normal | 格式化代码（使用 ruff） |
| `<leader>cf` | Normal/Visual | 手动格式化选中区域 |
| `<leader>cl` | Normal | 手动运行代码检查 (ruff) |

### Git 操作 (Gitsigns)

| 快捷键 | 模式 | 描述 |
|--------|------|------|
| `<leader>hs` | Normal/Visual | 暂存 hunk |
| `<leader>hr` | Normal/Visual | 重置 hunk |
| `<leader>hS` | Normal | 暂存整个缓冲区 |
| `<leader>hu` | Normal | 取消暂存 hunk |
| `<leader>hR` | Normal | 重置整个缓冲区 |
| `<leader>hp` | Normal | 预览 hunk |
| `<leader>hb` | Normal | 显示当前行 blame |
| `<leader>tb` | Normal | 切换 blame 显示 |
| `<leader>hd` | Normal | 显示 diff |
| `<leader>hD` | Normal | 显示与上一版本的 diff |
| `<leader>td` | Normal | 切换已删除行的显示 |
| `ih` | Operator/Visual | 选择 hunk 文本对象 |

### 快速跳转 (Flash)

| 快捷键 | 模式 | 描述 |
|--------|------|------|
| `s` | Normal/Visual/Operator | Flash 快速跳转 |
| `S` | Normal/Visual/Operator | Flash Treesitter 跳转 |

---

## 📖 插件使用说明

### nvim-tree.lua - 文件树浏览器

**功能**: 侧边栏文件浏览器，支持拖拽、重命名、创建删除文件等操作。

**使用方法**:
- 按 `<leader>e` 打开/关闭文件树
- 按 `<leader>E` 在文件树中定位当前文件
- 在文件树窗口中按 `g?` 显示所有快捷键

**文件操作快捷键**:

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `a` | 创建文件/目录 | 输入名称后按回车，以 `/` 结尾创建目录 |
| `d` | 删除文件/目录 | 会弹出确认提示 |
| `D` | 强制删除 | 不提示直接删除 |
| `r` | 重命名文件 | 修改当前文件/目录名 |
| `x` | 剪切 | 剪切到剪贴板 |
| `c` | 复制 | 复制到剪贴板 |
| `p` | 粘贴 | 粘贴剪贴板内容到当前目录 |
| `y` | 复制文件名 | 复制文件名到系统剪贴板 |
| `Y` | 复制相对路径 | 复制相对路径到系统剪贴板 |
| `gy` | 复制绝对路径 | 复制绝对路径到系统剪贴板 |
| `R` | 刷新 | 刷新文件树 |
| `q` | 关闭 | 关闭文件树窗口 |

**导航快捷键**:

| 快捷键 | 功能 |
|--------|------|
| `<CR>` 或 `o` | 打开文件/展开折叠目录 |
| `<C-v>` | 垂直分屏打开 |
| `<C-x>` | 水平分屏打开 |
| `<C-t>` | 在新标签页打开 |
| `P` | 跳转到父目录 |
| `<C-]>` | 进入目录 |
| `<BS>` | 返回上级目录 |
| `K` | 跳转到第一个子项 |
| `J` | 跳转到最后一个子项 |
| `I` | 切换隐藏文件显示 |
| `H` | 切换点文件显示 |
| `E` | 展开所有目录 |
| `W` | 折叠所有目录 |

**示例**: 创建新文件
```
1. 按 <leader>e 打开文件树
2. 导航到目标目录，按 a
3. 输入文件名如 "newfile.lua" 按回车
4. 或输入 "newfolder/" 创建目录
```

### Telescope - 模糊查找器

**功能**: 强大的搜索工具，支持文件、文本、符号、Git 等多种搜索。

**使用方法**:
- 打开搜索窗口后，输入关键词进行过滤
- `<C-n/p>` 或 `<Down/Up>` 上下移动选择
- `<CR>` 确认选择
- `<C-x>` 水平分屏打开
- `<C-v>` 垂直分屏打开
- `<C-t>` 在新标签页打开
- `<C-c>` 取消

### nvim-treesitter - 语法高亮

**功能**: 基于语法树的精准高亮和代码分析。

**已安装语言**: lua, python, javascript, typescript, c, cpp, go, rust, bash, json, yaml, toml, markdown, html, css, vim, vimdoc

**使用方法**:
- 自动启用语法高亮
- 支持代码折叠（使用 `zc` 折叠，`zo` 展开）
- `:TSInstall <language>` 安装新语言
- `:TSUpdate` 更新所有语言解析器

### Comment.nvim - 快速注释

**功能**: 快速注释/取消注释代码。

**使用方法**:
- `gcc` - 注释当前行
- `gc` + 动作 - 注释目标（如 `gcip` 注释段落）
- `gc` (visual) - 注释选中区域
- `gbc` - 块注释当前行
- `gb` (visual) - 块注释选中区域

### nvim-surround - 包围符号操作

**功能**: 快速添加、修改、删除包围符号（括号、引号等）。

**使用方法**:
- `ys{motion}{char}` - 添加包围（如 `ysiw"` 给单词加引号）
- `ys{motion}f{func}()` - 添加函数包围
- `ds{char}` - 删除包围（如 `ds"` 删除引号）
- `cs{old}{new}` - 修改包围（如 `cs"'` 双引号改单引号）
- `S{char}` (visual) - 给选中区域加包围

**示例**:
```
ysiw"    - 给当前单词添加双引号
ysiw<div> - 给当前单词添加 HTML 标签
ds"      - 删除双引号
cs"'     - 双引号改为单引号
```

### flash.nvim - 快速跳转

**功能**: 类似 vim-easymotion 的快速跳转工具。

**使用方法**:
- 按 `s` 进入跳转模式，然后输入目标字符，按提示标签跳转
- 按 `S` 进入 Treesitter 模式，可选择语法节点

### which-key.nvim - 快捷键提示

**功能**: 输入 leader 键后显示可用快捷键列表。

**使用方法**:
- 按 `<leader>` 后等待片刻，会自动显示快捷键面板
- 继续输入可过滤显示
- `<Esc>` 关闭面板

### toggleterm.nvim - 终端集成

**功能**: 在 Neovim 内集成终端。

**使用方法**:
- `<C-\>` - 打开/关闭浮动终端
- 在终端模式下按 `<Esc>` 退出终端模式
- 支持多终端切换（需额外配置）

### gitsigns.nvim - Git 集成

**功能**: 显示文件修改标记，支持 blame、diff 预览、hunk 操作等。

**界面符号**:
- `+` - 新增行
- `~` - 修改行
- `_` - 删除行
- `‾` - 顶部删除行

**快捷键**:

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<leader>hs` | Normal/Visual | 暂存 hunk (stage) |
| `<leader>hr` | Normal/Visual | 重置 hunk (reset) |
| `<leader>hS` | Normal | 暂存整个缓冲区 |
| `<leader>hu` | Normal | 取消暂存 hunk (unstage) |
| `<leader>hR` | Normal | 重置整个缓冲区 |
| `<leader>hp` | Normal | 预览 hunk 修改 |
| `<leader>hb` | Normal | 显示当前行 blame |
| `<leader>tb` | Normal | 切换 blame 显示模式 |
| `<leader>hd` | Normal | 显示 diff |
| `<leader>hD` | Normal | 显示与上一版本的 diff |
| `<leader>td` | Normal | 切换已删除行的显示 |
| `]c` | Normal | 跳转到下一个修改 |
| `[c` | Normal | 跳转到上一个修改 |
| `ih` | Operator/Visual | 选择 hunk 文本对象 |

**常用操作示例**:

```
查看修改:
1. 打开一个有修改的文件
2. 左侧会显示修改标记 (+/~/_)
3. 按 ]c 跳转到下一个修改，[c 跳转到上一个

暂存部分修改:
1. 将光标移到要暂存的修改块
2. 按 <leader>hs 暂存当前 hunk
3. 或进入 visual 模式选择多行后按 <leader>hs

查看 blame:
1. 按 <leader>hb 查看当前行是谁修改的
2. 按 <leader>tb 开启/关闭行内 blame 显示

撤销修改:
1. 将光标移到要撤销的修改
2. 按 <leader>hr 重置该 hunk 到上次提交状态
3. 或按 <leader>hR 重置整个文件

预览修改:
1. 将光标移到修改处
2. 按 <leader>hp 弹出修改对比窗口
```

---

### 其他常用 Git 插件推荐

如果你需要更强大的 Git 功能，可以考虑添加以下插件：

#### vim-fugitive - 全面的 Git 命令封装

```lua
-- 添加到 lazy.nvim 配置
{ "tpope/vim-fugitive" }
```

**常用命令**:
| 命令 | 功能 |
|------|------|
| `:G` 或 `:Git` | 查看 Git 状态窗口 |
| `:Gdiffsplit` | 查看 diff |
| `:Gwrite` | 相当于 `git add %` |
| `:Gread` | 撤销当前文件修改 |
| `:Gcommit` | 提交 |
| `:Gpush` | 推送 |
| `:Gpull` | 拉取 |
| `:Gblame` | 查看 blame |
| `:Gclog` | 查看当前文件提交历史 |

#### neogit - Magit 风格的 Git 界面

```lua
-- 添加到 lazy.nvim 配置
{
  "NeogitOrg/neogit",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true
}
```

**使用**:
- `:Neogit` - 打开主界面
- 界面内按 `?` 查看快捷键
- `s` - stage, `u` - unstage, `c` - commit, `p` - push, `P` - pull

#### diffview.nvim - 查看 diff 和文件历史

```lua
-- 添加到 lazy.nvim 配置
{
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }
}
```

**常用命令**:
| 命令 | 功能 |
|------|------|
| `:DiffviewOpen` | 打开 diff 视图 |
| `:DiffviewClose` | 关闭 diff 视图 |
| `:DiffviewFileHistory` | 查看文件历史 |
| `:DiffviewFileHistory %` | 查看当前文件历史 |

#### lazygit.nvim - 集成 lazygit 终端

```lua
-- 需要先安装 lazygit: https://github.com/jesseduffield/lazygit
{
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open LazyGit" })
  end
}
```

**使用**:
- `:LazyGit` - 打开 lazygit 界面
- `:LazyGitCurrentFile` - 查看当前文件历史

### nvim-cmp - 自动补全

**功能**: 代码自动补全引擎。

**使用方法**:
- `<C-Space>` - 手动触发补全
- `<C-n/p>` - 上下选择补全项
- `<CR>` - 确认选择
- `<Tab>` - 确认或选择下一个
- `<C-e>` - 取消补全
- `<C-b/f>` - 滚动文档

### Mason - LSP 管理器

**功能**: 图形化安装和管理 LSP 服务器、DAP、格式化工具等。

**使用方法**:
- `:Mason` - 打开管理界面
- `i` - 安装选中的工具
- `u` - 更新
- `X` - 卸载
- `g?` - 显示帮助

### Python 开发配置

本配置为 Python 开发提供了完整的支持：

**功能**: 
- **代码补全**: 基于 pyright 的智能补全和类型检查
- **代码格式化**: 使用 ruff 自动格式化，保存时自动触发
- **代码检查**: 使用 ruff 检测代码问题（未使用导入、语法错误等）
- **虚拟环境管理**: 使用 venv-selector 快速切换 Python 虚拟环境

**快捷键**:

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `<leader>oe` | Normal | 选择 Python 虚拟环境 |
| `<leader>oc` | Normal | 选择缓存的虚拟环境 |
| `<leader>f` | Normal | 格式化整个文件 |
| `<leader>cf` | Normal/Visual | 格式化选中区域 |
| `<leader>cl` | Normal | 手动运行代码检查 |

**使用方法**:
- 打开 Python 文件时自动启用
- 保存文件时自动格式化代码
- 代码问题会显示在左侧标记栏和诊断列表中

**虚拟环境管理 (venv-selector)**:

该功能让你在 Neovim 内部快速切换 Python 虚拟环境，无需重启编辑器。

**支持的虚拟环境类型**:
- `venv` / `virtualenv` - 标准虚拟环境
- `poetry` - Poetry 项目环境
- `pdm` - PDM 项目环境
- `conda` - Conda 环境
- `hatch` - Hatch 项目环境
- `pipenv` - Pipenv 环境

**常用命令**:

| 命令 | 功能 |
|------|------|
| `:VenvSelect` | 打开虚拟环境选择器 |
| `:VenvSelectCached` | 选择之前使用的虚拟环境 |

**使用流程**:

```
1. 在项目中创建虚拟环境（如: uv venv .venv 或 poetry init）
2. 在 Neovim 中打开 Python 文件
3. 按 <leader>Ve 打开虚拟环境选择器
4. 使用 Telescope 搜索并选择要激活的环境
5. LSP 、格式化器、lint 将自动使用新环境
```

**配置示例** - 自定义搜索路径（在 init.lua 中）:

```lua
require("venv-selector").setup({
  settings = {
    search = {
      my_venvs = {
        command = "fd 'python$' ~/.venvs --full-path --color never -L",
      },
    },
  },
})
```

**常见问题**:
- 如果格式化不工作，确保 ruff 已安装: `pip install ruff`
- 检查 ruff 路径: `:checkhealth conform`
- 虚拟环境切换后 LSP 需要重新加载缓冲区才能生效：`:e`

---

### nvim-lspconfig - LSP 配置

**功能**: 配置语言服务器协议支持。

**使用方法**:
- 自动为已安装的语言服务器提供代码分析功能
- 详见快捷键表中的 LSP 相关快捷键

---

## 🔧 自定义配置

配置文件位于 `~/.config/nvim/init.lua`，可根据需要修改：

1. **添加新插件**: 在 `require("lazy").setup({...})` 中添加插件配置
2. **修改主题**: 更换 `tokyonight.nvim` 为其他主题插件
3. **调整快捷键**: 在文件底部的基础快捷键区域修改
4. **LSP 服务器**: 在 LSP 配置段添加所需的服务器

---

## 📝 常见问题

### Q: 图标显示为方块或问号？

A: 需要安装 Nerd Font 并在终端中启用。推荐字体：
- FiraCode Nerd Font
- JetBrainsMono Nerd Font
- Hack Nerd Font

### Q: Telescope 实时搜索很慢？

A: 确保已安装 ripgrep (`rg` 命令)，它会大幅提升搜索性能。

### Q: 如何安装新的语言支持？

A: 运行 `:TSInstall <language>` 安装 treesitter 支持，
在 Mason (`:Mason`) 中安装对应的 LSP 服务器。

### Q: 插件没有自动安装？

A: 首次启动时 lazy.nvim 会自动安装，如果失败可以：
1. 删除 `~/.local/share/nvim/lazy` 目录
2. 重新启动 Neovim

---

## 📄 许可证

MIT License

---

## 🙏 致谢

- [lazy.nvim](https://github.com/folke/lazy.nvim) - 强大的插件管理器
- [Neovim](https://neovim.io/) - 优秀的编辑器
- 所有插件作者
