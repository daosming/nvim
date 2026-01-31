# Neovim 插件说明

本文档列出了当前配置中的所有插件及其功能说明。

## 🎨 外观主题

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `tokyonight.nvim` | 默认深色主题 | `<leader>ut` 切换主题 |
| `catppuccin` | 备选主题 (mocha/latte等) | - |
| `lualine.nvim` | 状态栏美化 | - |
| `bufferline.nvim` | 缓冲区标签页 | `<leader>bn/bp/bd` |
| `noice.nvim` | 命令行/消息/通知美化 | - |
| `alpha-nvim` | 启动页美化 | - |
| `nvim-notify` | 通知增强 | - |
| `dressing.nvim` | 更好的 UI 选择框 | - |
| `nvim-scrollbar` | 滚动条美化 | - |
| `rainbow-delimiters.nvim` | 彩虹括号 | - |
| `indent-blankline.nvim` | 彩色缩进线 | - |
| `smear-cursor.nvim` | 光标动画 | - |
| `highlight-undo.nvim` | 撤销/重做高亮 | - |
| `zen-mode.nvim` | 专注模式 | `<leader>z` |
| `twilight.nvim` | 聚焦当前代码块 | `<leader>tw` |
| `transparent.nvim` | 透明背景 | `<leader>tb` |

## 📁 文件管理

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `nvim-tree.lua` | 文件树 | `<leader>e/E` |
| `telescope.nvim` | 模糊查找器 | `<leader>ff/fg/fb/fh/fr` |
| `telescope-fzf-native.nvim` | Telescope FZF 支持 | - |
| `telescope-ui-select.nvim` | Telescope UI 选择 | - |
| `project.nvim` | 项目管理 | `<leader>fp` |

## 📝 编辑增强

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `nvim-treesitter` | 语法高亮 | - |
| `nvim-treesitter-context` | 显示当前函数上下文 | - |
| `nvim-ts-autotag` | 自动标签闭合 | - |
| `nvim-autopairs` | 自动括号配对 | - |
| `Comment.nvim` | 快速注释 | `gcc/gc` |
| `nvim-surround` | 包围符号操作 | `ys/ds/cs` |
| `flash.nvim` | 快速跳转 | `s/S` |
| `vim-visual-multi` | 多光标编辑 | `Ctrl+d` |
| `vim-easy-align` | 代码对齐 | `ga` |
| `vim-sleuth` | 自动检测缩进 | - |
| `better-escape.nvim` | jk 退出插入模式 | `jk/jj` |
| `registers.nvim` | 寄存器管理 | `"` |
| `yanky.nvim` | 剪贴板历史 | `<c-p>/<c-n>` |
| `pantran.nvim` | 翻译工具 | `<leader>tr` |

## 🔍 搜索和替换

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `nvim-spectre` | 全局搜索替换 | `<leader>sr/sw` |
| `flash.nvim` | 快速跳转 | `s/S` |

## 🔧 自动补全

| 插件 | 功能 |
|------|------|
| `nvim-cmp` | 补全引擎 |
| `cmp-nvim-lsp` | LSP 补全源 |
| `cmp-buffer` | 缓冲区补全源 |
| `cmp-path` | 路径补全源 |
| `cmp-cmdline` | 命令行补全源 |
| `LuaSnip` | 代码片段引擎 |
| `cmp_luasnip` | LuaSnip 补全源 |
| `lspkind.nvim` | 补全菜单图标 |

## 🏗️ LSP 和代码分析

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `nvim-lspconfig` | LSP 配置 | `gd/gD/gr/gi/K/<leader>rn/ca` |
| `mason.nvim` | LSP 安装管理 | - |
| `mason-lspconfig.nvim` | Mason 与 LSPConfig 桥接 | - |
| `nvim-java` | Java 完整开发环境 | `<leader>j*` |
| `conform.nvim` | 代码格式化 | `<leader>cf/f` |
| `nvim-lint` | 代码检查 (Linting) | `<leader>cl` |
| `venv-selector.nvim` | Python 虚拟环境选择 | `<leader>ve/vc` |
| `fidget.nvim` | LSP 进度指示器 | - |

## 🧪 测试

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `nvim-java-test` | Java 测试运行 | `<leader>jt/jm/jv` |

## 🔀 Git 集成

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `gitsigns.nvim` | Git 标记显示 | `<leader>hs/hr/hS/hu/hR/hp/hb` |
| `diffview.nvim` | Git diff 视图 | `<leader>gd/gh/gH/gq` |
| `lazygit.nvim` | LazyGit TUI | `<leader>gg/gf/gc/gC` |
| `git-conflict.nvim` | 冲突解决 | - |
| `git-blame.nvim` | Git blame | `<leader>gB` |

## 🪟 窗口和缓冲区管理

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `toggleterm.nvim` | 终端集成 | `<c-\>` |
| `auto-session` | 会话管理 | - |
| `smart-splits.nvim` | 智能窗口分割 | `<C-h/j/k/l>` `<A-h/j/k/l>` |
| `winshift.nvim` | 窗口移动 | `<C-W>m/X` |
| `harpoon` | 快速文件标记 | `<leader>ha/hm/1/2/3/4/5` |
| `persistence.nvim` | 会话管理增强 | `<leader>qs/qS/ql/qd` |

## 📋 代码导航

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `barbecue.nvim` | 面包屑导航 | - |
| `outline.nvim` | 代码大纲 | `<leader>o` |
| `todo-comments.nvim` | TODO 高亮 | `<leader>ft/fT` `]t/[t` |
| `trouble.nvim` | 诊断列表 | `<leader>xx/xX/xs/xl/xL/xQ` |
| `vim-illuminate` | 高亮当前单词 | - |
| `marks.nvim` | 标记管理 | `m,/]/:` `<leader>mm/mM/mx/mX` |

## 🎯 代码运行

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `sniprun` | 代码片段运行 | `<leader>r/rr/rc/ri` |

## 📊 其他工具

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `which-key.nvim` | 快捷键提示 | 按 `<leader>` 后等待 |
| `mini.cursorword` | 快速高亮当前单词 | - |
| `neoscroll.nvim` | 平滑滚动 | - |
| `nvim-ufo` | 代码折叠 | `zR/zM/zr/zm/K` |
| `nvim-bqf` | Quickfix 增强 | - |
| `nvim-colorizer.lua` | 颜色代码高亮 | - |
| `wilder.nvim` | 命令行补全增强 | - |
| `live-command.nvim` | 实时预览命令效果 | - |
| `auto-save.nvim` | 自动保存 | `<leader>as` |
| `bigfile.nvim` | 大文件优化 | - |
| `vim-startuptime` | 启动时间分析 | `:StartupTime` |
| `neoconf.nvim` | 本地 LSP 配置管理 | - |

## 🌐 数据库和 HTTP

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `vim-dadbod` + `vim-dadbod-ui` | 数据库工具 | `<leader>db` |
| `rest.nvim` | HTTP 客户端 | `<leader>rr/rl` |

## 📝 Markdown

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `markdown-preview.nvim` | Markdown 预览 | `<leader>mp` |

## 🤖 AI 辅助

| 插件 | 功能 | 快捷键 |
|------|------|--------|
| `copilot.lua` | GitHub Copilot | `<M-l>` 接受建议 |

## 新添加的插件说明

### 1. outline.nvim (`<leader>o`)
类似 VSCode 的 Outline 面板，显示当前文件的符号大纲，支持快速跳转和折叠。

### 2. vim-visual-multi (`Ctrl+d`)
多光标编辑插件，类似 VSCode 的 Ctrl+D，可以同时编辑多处相同文本。

### 3. vim-sleuth
自动检测文件的缩进风格 (tab/space, 缩进宽度)，无需手动设置。

### 4. vim-easy-align (`ga`)
快速对齐代码工具。示例：
- `gaip=` - 对齐段落内的等号
- `vipga=` - 可视模式下选择并对齐

### 5. git-conflict.nvim
Git 冲突解决工具，提供冲突高亮和快捷解决命令。

### 6. git-blame.nvim (`<leader>gB`)
在代码行尾显示 Git blame 信息。

### 7. registers.nvim (`"`)
更好的寄存器管理，按 `"` 可以可视化选择寄存器内容。

### 8. better-escape.nvim (`jk/jj`)
使用 `jk` 或 `jj` 快速退出插入模式。

### 9. auto-save.nvim (`<leader>as`)
自动保存文件，默认关闭，可按 `<leader>as` 开启。

### 10. bigfile.nvim
自动检测大文件并禁用耗资源的功能，提升性能。

### 11. pantran.nvim (`<leader>tr`)
翻译工具，支持选中翻译和整行翻译。

### 12. vim-startuptime (`:StartupTime`)
分析 Neovim 启动时间。
