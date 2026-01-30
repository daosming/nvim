# Neovim 配置文档

基于 lazy.nvim 的现代化 Neovim 配置，支持 Python/Java/前端开发。

---

## 🚀 快速上手

### 前置依赖

```bash
# 必需
- Neovim >= 0.10
- Git
- fd (文件查找)
- ripgrep (rg, 文本搜索)

# 可选但推荐
- Nerd Font (图标显示)
- lazygit (Git TUI)
- nodejs/npm (前端 LSP)
- python/pip (Python LSP)
```

### 安装

```bash
# 首次启动会自动安装 lazy.nvim 和所有插件
nvim
```

### 最常用快捷键 (必须记住)

| 快捷键 | 功能 | 场景 |
|--------|------|------|
| `Space` | Leader 键 | 所有命令前缀 |
| `<leader>ff` | 查找文件 | 快速打开文件 |
| `<leader>fg` | 全局搜索 | 搜索代码内容 |
| `<leader>e` | 文件树 | 浏览项目结构 |
| `gd` | 跳转到定义 | 代码导航 |
| `gr` | 查找引用 | 查看哪里用了这个变量 |
| `K` | 悬浮文档 | 查看函数文档 |
| `<leader>rn` | 重命名 | 重构变量名 |
| `<leader>ca` | 代码操作 | 自动修复/导入等 |
| `<leader>cf` | 格式化 | 代码格式化 |
| `<C-\>` | 终端 | 快速打开终端 |

---

## 📁 文件管理

### Telescope (模糊查找)

| 快捷键 | 功能 |
|--------|------|
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全局搜索 (live grep) |
| `<leader>fb` | 查找缓冲区 |
| `<leader>fh` | 帮助标签 |
| `<leader>fr` | 最近文件 |
| `<leader>fc` | 命令列表 |
| `<leader>fk` | 快捷键列表 |
| `<leader>fs` | 文档符号 |
| `<leader>fp` | 查找项目 |
| `<leader>ft` | 查找 TODO |
| `<leader>fy` | 剪贴板历史 |

**Telescope 操作** (在 Telescope 窗口中)
- `<C-j>` / `<C-k>` - 上下移动
- `<CR>` - 确认选择
- `<C-x>` - 水平分屏打开
- `<C-v>` - 垂直分屏打开
- `<C-t>` - 新标签打开

### NvimTree (文件树)

| 快捷键 | 功能 |
|--------|------|
| `<leader>e` | 切换文件树 |
| `<leader>E` | 在文件树中定位当前文件 |

**文件树操作** (在 NvimTree 中)
- `Enter` / `o` - 打开文件/展开目录
- `a` - 新建文件
- `d` - 删除
- `r` - 重命名
- `x` - 剪切
- `c` - 复制
- `p` - 粘贴
- `y` - 复制文件名
- `Y` - 复制相对路径
- `gy` - 复制绝对路径

---

## 🔧 代码编辑

### LSP (语言服务器)

| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `gD` | 跳转到声明 |
| `gr` | 查找引用 |
| `gi` | 跳转到实现 |
| `K` | 悬浮文档 |
| `<leader>rn` | 重命名符号 |
| `<leader>ca` | 代码操作 |
| `<leader>f` | 格式化代码 |
| `<leader>cf` | 格式化 (与 conform 共用) |

**前端专属**
| `<leader>co` | 组织导入 |
| `<leader>cx` | 修复所有可自动修复的问题 |
| `<leader>cr` | 重命名下一个匹配 |

### 代码补全 (nvim-cmp)

| 快捷键 | 功能 |
|--------|------|
| `<C-Space>` | 触发补全 |
| `<C-j>` / `<C-k>` | 选择下/上一个选项 |
| `<CR>` | 确认选择 |
| `<Tab>` | 确认或下一个 |
| `<S-Tab>` | 上一个 |
| `<C-b>` / `<C-f>` | 滚动文档 |
| `<C-e>` | 取消补全 |

### 编辑增强

| 快捷键 | 功能 | 插件 |
|--------|------|------|
| `gcc` | 切换行注释 | Comment.nvim |
| `gc` (visual) | 切换注释 | Comment.nvim |
| `s` | 快速跳转 (Flash) | flash.nvim |
| `S` | Treesitter 选择 | flash.nvim |
| `ys{motion}{char}` | 添加包围符号 | nvim-surround |
| `ds{char}` | 删除包围符号 | nvim-surround |
| `cs{old}{new}` | 修改包围符号 | nvim-surround |
| `p` / `P` | 粘贴 (增强版) | yanky.nvim |
| `<C-p>` | 上一个粘贴历史 | yanky.nvim |
| `<C-n>` | 下一个粘贴历史 | yanky.nvim |

### 格式化 (Conform)

| 快捷键 | 功能 |
|--------|------|
| `<leader>cf` | 格式化代码 |

**自动格式化**: 保存时自动格式化 (Python/前端/Java)

### 代码检查 (Linting)

| 快捷键 | 功能 |
|--------|------|
| `<leader>cl` | 手动运行 Linter |

---

## 🌲 Git 集成

### Gitsigns (行级 Git 状态)

| 快捷键 | 功能 |
|--------|------|
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage 整个缓冲区 |
| `<leader>hu` | Undo stage hunk |
| `<leader>hR` | Reset 缓冲区 |
| `<leader>hp` | 预览 hunk |
| `<leader>hb` | Blame 行 |
| `<leader>tb` | 切换 blame 显示 |
| `<leader>hd` | Diff |
| `ih` (文本对象) | 选择 hunk |

### LazyGit (Git TUI)

| 快捷键 | 功能 |
|--------|------|
| `<leader>gg` | 打开 LazyGit |
| `<leader>gf` | 当前文件历史 |
| `<leader>gc` | 提交筛选 |
| `<leader>gC` | 当前文件提交筛选 |

### Diffview

| 快捷键 | 功能 |
|--------|------|
| `<leader>gd` | Git diff 视图 |
| `<leader>gh` | 文件历史 |
| `<leader>gH` | 当前文件历史 |
| `<leader>gq` | 关闭 diffview |

---

## 🎯 高效工具

### Harpoon (快速文件标记)

| 快捷键 | 功能 |
|--------|------|
| `<leader>ha` | 添加当前文件到标记 |
| `<leader>hm` | 打开标记菜单 |
| `<leader>1~5` | 跳转到标记 1-5 |
| `<leader>hn` | 下一个标记 |
| `<leader>hp` | 上一个标记 |

### Spectre (全局搜索替换)

| 快捷键 | 功能 |
|--------|------|
| `<leader>sr` | 打开 Spectre |
| `<leader>sw` | 搜索当前单词 |

**Spectre 内操作**
- `dd` - 切换选择行
- `<CR>` - 打开文件
- `<leader>r` - 全部替换
- `<leader>rc` - 替换当前行

### TODO Comments

| 快捷键 | 功能 |
|--------|------|
| `]t` | 下一个 TODO |
| `[t` | 上一个 TODO |
| `<leader>ft` | 查找所有 TODO |
| `<leader>fT` | TODO 列表 |

**支持标签**: `TODO`, `FIX`, `HACK`, `WARN`, `PERF`, `NOTE`, `TEST`

### Trouble (诊断列表)

| 快捷键 | 功能 |
|--------|------|
| `<leader>xx` | 工作区诊断 |
| `<leader>xX` | 当前缓冲区诊断 |
| `<leader>xs` | 符号列表 |
| `<leader>xl` | LSP 定义/引用 |
| `<leader>xL` | Location List |
| `<leader>xQ` | Quickfix List |

### Marks (标记管理)

| 快捷键 | 功能 |
|--------|------|
| `m,` | 设置下一个标记 |
| `m]` | 下一个标记 |
| `m:` | 预览标记 |
| `<leader>mm` | 列出缓冲区标记 |
| `<leader>mM` | 列出全局标记 |
| `<leader>mx` | 删除缓冲区标记 |
| `<leader>mX` | 删除行标记 |

---

## 🪟 窗口管理

### Smart Splits (智能窗口分割)

| 快捷键 | 功能 |
|--------|------|
| `<C-h>` | 左移 |
| `<C-j>` | 下移 |
| `<C-k>` | 上移 |
| `<C-l>` | 右移 |
| `<A-h>` | 向左调整大小 |
| `<A-j>` | 向下调整大小 |
| `<A-k>` | 向上调整大小 |
| `<A-l>` | 向右调整大小 |
| `<leader><leader>h` | 与左窗口交换 |
| `<leader><leader>j` | 与下窗口交换 |
| `<leader><leader>k` | 与上窗口交换 |
| `<leader><leader>l` | 与右窗口交换 |

### 基础窗口操作

| 快捷键 | 功能 |
|--------|------|
| `<leader>v` | 垂直分屏 |
| `<leader>s` | 水平分屏 |
| `<C-Up>` | 增加高度 |
| `<C-Down>` | 减少高度 |
| `<C-Left>` | 减少宽度 |
| `<C-Right>` | 增加宽度 |

### 终端

| 快捷键 | 功能 |
|--------|------|
| `<C-\>` | 切换浮动终端 |
| `<Esc>` (终端模式) | 退出终端模式 |

---

## 🎨 UI 与主题

### 主题切换

| 快捷键 | 功能 |
|--------|------|
| `<leader>ut` | 切换主题 |

**可用主题**: TokyoNight (默认), Catppuccin

### 其他 UI 切换

| 快捷键 | 功能 |
|--------|------|
| `<leader>z` | Zen Mode (专注模式) |
| `<leader>tw` | Twilight (聚焦当前代码) |
| `<leader>tb` | 透明背景 |

### 代码折叠 (UFO)

| 快捷键 | 功能 |
|--------|------|
| `zR` | 展开所有折叠 |
| `zM` | 折叠所有 |
| `zr` | 展开指定级别外 |
| `zm` | 折叠指定级别 |
| `K` (在折叠行) | 预览折叠内容 |

---

## 🔍 其他实用功能

### 缓冲区操作

| 快捷键 | 功能 |
|--------|------|
| `<leader>bn` | 下一个缓冲区 |
| `<leader>bp` | 上一个缓冲区 |
| `<leader>bd` | 删除缓冲区 |
| `<leader>bw` | 彻底删除缓冲区 |

### 文件操作

| 快捷键 | 功能 |
|--------|------|
| `<leader>w` | 保存 |
| `<leader>q` | 退出 |
| `<leader>Q` | 强制退出所有 |
| `<leader>ev` | 编辑配置文件 |
| `<leader>sv` | 重新加载配置 |

### 系统剪贴板

| 快捷键 | 功能 |
|--------|------|
| `<leader>y` | 复制到系统剪贴板 |
| `<leader>Y` | 复制行到系统剪贴板 |
| `<leader>p` | 从系统剪贴板粘贴 |
| `<leader>P` | 从系统剪贴板粘贴到前面 |

### 导航

| 快捷键 | 功能 |
|--------|------|
| `<C-d>` | 半页下 (居中) |
| `<C-u>` | 半页上 (居中) |
| `n` | 下一个匹配 (居中) |
| `N` | 上一个匹配 (居中) |
| `<Esc>` | 取消搜索高亮 |

### 可视模式

| 快捷键 | 功能 |
|--------|------|
| `J` | 将选中行下移 |
| `K` | 将选中行上移 |
| `p` | 粘贴 (不替换寄存器) |

---

## 🐍 Python 开发

### 虚拟环境选择器

| 快捷键 | 功能 |
|--------|------|
| `<leader>ve` | 选择 Python 虚拟环境 |
| `<leader>vc` | 选择缓存的虚拟环境 |

---

## ☕ Java 开发

### Java 专属命令

| 快捷键 | 功能 |
|--------|------|
| `<leader>jo` | 通过完整类名打开类 |
| `<leader>jc` | 清理工作区 |
| `<leader>jt` | 测试当前类 |
| `<leader>jm` | 测试当前方法 |
| `<leader>jv` | 查看测试报告 |

---

## 🌐 前端开发

### 快速打开

| 快捷键 | 功能 |
|--------|------|
| `<leader>ep` | 打开 package.json |
| `<leader>ob` | 在浏览器中打开当前文件 |

### LSP 操作

| 快捷键 | 功能 |
|--------|------|
| `<leader>co` | 组织导入 |
| `<leader>cx` | 修复所有可自动修复的问题 |
| `<leader>cr` | 重命名下一个匹配 |

---

## 📋 启动页 (Alpha)

启动 Neovim 时显示的快捷菜单：

| 快捷键 | 功能 |
|--------|------|
| `f` | 查找文件 |
| `e` | 新建文件 |
| `p` | 项目 |
| `r` | 最近文件 |
| `t` | 查找文本 |
| `c` | 编辑配置 |
| `q` | 退出 |

---

## 🔧 插件列表

### 外观主题
- `tokyonight.nvim` - TokyoNight 主题
- `catppuccin/nvim` - Catppuccin 主题
- `lualine.nvim` - 状态栏
- `bufferline.nvim` - 缓冲区标签页
- `alpha-nvim` - 启动页
- `nvim-web-devicons` - 文件图标

### 文件管理
- `nvim-tree.lua` - 文件树
- `telescope.nvim` - 模糊查找
- `telescope-fzf-native.nvim` - fzf 算法支持
- `telescope-ui-select.nvim` - UI 选择器
- `project.nvim` - 项目管理

### 编辑增强
- `nvim-treesitter` - 语法高亮
- `nvim-ts-autotag` - 自动标签闭合
- `nvim-autopairs` - 自动括号配对
- `Comment.nvim` - 快速注释
- `nvim-surround` - 包围符号操作
- `flash.nvim` - 快速跳转
- `yanky.nvim` - 剪贴板历史
- `nvim-ufo` - 代码折叠
- `indent-blankline.nvim` - 缩进线

### LSP & 补全
- `nvim-lspconfig` - LSP 配置
- `mason.nvim` - LSP 管理器
- `mason-lspconfig.nvim` - Mason LSP 配置
- `nvim-cmp` - 补全引擎
- `cmp-nvim-lsp` - LSP 补全源
- `cmp-buffer` - 缓冲区补全源
- `cmp-path` - 路径补全源
- `cmp-cmdline` - 命令行补全源
- `LuaSnip` - 代码片段
- `cmp_luasnip` - 片段补全源
- `lspkind.nvim` - 补全图标
- `fidget.nvim` - LSP 进度指示器

### 代码质量
- `conform.nvim` - 代码格式化
- `nvim-lint` - 代码检查
- `venv-selector.nvim` - Python 虚拟环境
- `nvim-java` - Java 开发环境

### Git
- `gitsigns.nvim` - Git 标记
- `lazygit.nvim` - LazyGit 集成
- `diffview.nvim` - Diff 视图

### 工具增强
- `which-key.nvim` - 快捷键提示
- `toggleterm.nvim` - 终端集成
- `auto-session` - 会话管理
- `mini.cursorword` - 高亮当前单词
- `neoscroll.nvim` - 平滑滚动
- `dressing.nvim` - UI 选择增强
- `nvim-notify` - 通知增强
- `noice.nvim` - 命令行/消息 UI
- `rainbow-delimiters.nvim` - 彩虹括号
- `nvim-scrollbar` - 滚动条
- `highlight-undo.nvim` - 撤销高亮
- `smear-cursor.nvim` - 光标动画
- `wilder.nvim` - 命令行补全
- `transparent.nvim` - 透明背景
- `neoconf.nvim` - 本地配置管理

### 高效工具
- `harpoon` - 快速文件标记
- `nvim-spectre` - 全局搜索替换
- `todo-comments.nvim` - TODO 注释
- `trouble.nvim` - 诊断列表
- `vim-illuminate` - 单词高亮
- `nvim-treesitter-context` - 上下文显示
- `barbecue.nvim` - 面包屑导航
- `smart-splits.nvim` - 智能窗口分割
- `nvim-bqf` - Quickfix 增强
- `marks.nvim` - 标记管理
- `nvim-colorizer.lua` - 颜色代码高亮
- `zen-mode.nvim` - 专注模式
- `twilight.nvim` - 代码聚焦
- `live-command.nvim` - 命令实时预览

---

## 💡 提示

1. **记住 Leader 键是空格 `<Space>`**
2. **`<leader>fk`** 可以查看所有快捷键
3. **which-key** 会在输入 leader 键后显示可用命令
4. **Telescope** 是最常用的文件/文本查找工具
5. **Harpoon** 可以标记常用文件，用 `<leader>1-5>` 快速跳转
