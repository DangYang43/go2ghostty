# go2ghostty

[English](README.md) | **中文**

我一直使用 [Go2Shell](https://zipzapmac.com/go2shell) 配合 macOS 自带的 Terminal 终端。最近切换到 [Ghostty](https://ghostty.org) 以后，发现 Go2Shell 不支持 Ghostty，于是写了这个项目。

go2ghostty 是一个 macOS Finder 工具栏按钮，点击后会在当前 Finder 目录打开 Ghostty 终端 —— 类似 Go2Shell，但专为 Ghostty 设计。

## 功能特性

- 一键从 Finder 工具栏打开 Ghostty
- 自动 `cd` 到当前 Finder 窗口所在目录
- 在终端顶部以蓝色高亮显示当前目录路径
- 若无 Finder 窗口打开，则回退到 `$HOME` 目录

## 系统要求

- **Apple Silicon** 架构的 macOS 11.0+
- [Ghostty](https://ghostty.org) 已安装至 `/Applications/Ghostty.app`

## 安装

```bash
./install.sh
```

此命令会将 `.app` 包复制到 `/Applications`。

### 手动添加到 Finder 工具栏

1. 打开一个 Finder 窗口
2. 按住 `⌘ Command` 键，将 `/Applications` 中的 `go2ghostty.app` 拖拽到 Finder 工具栏
3. 松开鼠标即可放置

## 卸载

```bash
./install.sh uninstall
```

## 文件说明

| 文件 | 描述 |
|------|------|
| `go2ghostty` | 主脚本 —— 获取当前 Finder 路径并启动 Ghostty |
| `get_finder_path` | 编译后的二进制文件 —— 处理 Finder 工具栏按钮点击 |
| `Info.plist` | macOS 应用包元数据 |
| `Resources/Ghostty.icns` | 应用图标 |

## 工作原理

点击工具栏按钮时：

1. `get_finder_path`（工具栏二进制）被 macOS 触发
2. 它调用 `go2ghostty`（bash 脚本）
3. 脚本通过 AppleScript 查询 Finder 当前目录
4. 创建临时初始化脚本，打印路径后 `exec` 进入交互式 zsh 会话
5. Ghostty 打开新窗口运行该初始化脚本，正常加载你的 `.zshrc`
