# 下载与合并 r53 安装包

[返回首页](../README.md) · [安装指南](INSTALL.md) · [r53 Release](https://github.com/FocusSearch/DataFocus_OT_Flash/releases/tag/v0.1.0-test-r53)

## 自动下载（推荐）

在 Release 页面下载 `download-r53.sh`，或打开仓库中的 [脚本原文](https://raw.githubusercontent.com/FocusSearch/DataFocus_OT_Flash/main/scripts/download-r53.sh) 保存为同名文件。在存放安装包的目录执行：

```bash
bash download-r53.sh
# 也可指定输出目录
bash download-r53.sh /path/to/downloads
```

需要 Bash、curl，以及 `sha256sum`（Linux）或 `shasum`（macOS）。不需要 Python、GitHub CLI 或代理。脚本始终使用 HTTPS 直连，保留 TLS 校验。

脚本依次校验、下载或续传四个分卷，合并后核对原始完整包摘要。断网后重跑同一命令即可继续；已校验的分卷复用。若已有完整包通过校验，直接返回成功。若已有文件损坏，脚本报出具体文件名，请将该文件移到其他位置后重试，不会静默覆盖。

分卷与完整归档会同时保留，至少预留 **15 GiB** 下载空间；解包和安装另需空间。

## 手动下载

从 [r53 Release](https://github.com/FocusSearch/DataFocus_OT_Flash/releases/tag/v0.1.0-test-r53) 的 **Assets** 下载以下文件到同一个目录：

| 文件尾缀 | 字节数 |
| --- | ---: |
| `.tar.gz.part-01` | 1,992,294,400 |
| `.tar.gz.part-02` | 1,992,294,400 |
| `.tar.gz.part-03` | 1,992,294,400 |
| `.tar.gz.part-04` | 1,214,599,292 |

四个文件的共同前缀是 `OT_Flash_0.1.0-test_CentOS7_X86_64-r53`。同时下载 `SHA256SUMS-r53.txt` 和 `OT_Flash_0.1.0-test_CentOS7_X86_64-r53.tar.gz.sha256`。

Linux 校验与合并：

```bash
sha256sum -c SHA256SUMS-r53.txt
cat OT_Flash_0.1.0-test_CentOS7_X86_64-r53.tar.gz.part-01 \
    OT_Flash_0.1.0-test_CentOS7_X86_64-r53.tar.gz.part-02 \
    OT_Flash_0.1.0-test_CentOS7_X86_64-r53.tar.gz.part-03 \
    OT_Flash_0.1.0-test_CentOS7_X86_64-r53.tar.gz.part-04 \
    > OT_Flash_0.1.0-test_CentOS7_X86_64-r53.tar.gz
sha256sum -c OT_Flash_0.1.0-test_CentOS7_X86_64-r53.tar.gz.sha256
```

macOS 使用 `shasum -a 256 -c` 替换上述 `sha256sum -c`；合并命令相同。macOS 可下载与合并，实际安装须在目标 CentOS 7 x86_64 服务器上进行。

四个分卷是同一归档的连续字节切片，不能单独解压。合并顺序必须为 `01 → 02 → 03 → 04`。GitHub 自动生成的 **Source code (zip/tar.gz)** 仅包含发行资料，不是产品安装包。

## 完整包标识

```text
文件：OT_Flash_0.1.0-test_CentOS7_X86_64-r53.tar.gz
字节数：7191482492
SHA-256：e045423b2744e0f28c3f46b649aa20724ea8d79686d5d96e8ed7c48b4e699abd
```

分卷和完整包的机器可读信息见 [r53-manifest.json](../releases/r53-manifest.json)。合并后大小与 SHA-256 必须同时匹配，之后按 [安装指南](INSTALL.md) 解包部署。
