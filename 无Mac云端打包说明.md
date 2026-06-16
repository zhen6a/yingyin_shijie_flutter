# 没有 Mac 时如何生成 TrollStore IPA

你不需要自己有 Mac，可以使用 GitHub Actions 的云端 macOS 机器打包。

## 操作步骤

1. 打开 GitHub，新建一个仓库，例如 `yingyin_shijie_flutter`。
2. 把本工程源码全部上传到仓库根目录。
3. 进入仓库页面，点击 `Actions`。
4. 左侧选择 `构建 TrollStore IPA`。
5. 点击 `Run workflow`。
6. 等待构建完成。
7. 打开本次运行记录，在 `Artifacts` 里下载 `影音视界-TrollStore-IPA`。
8. 解压后得到 `影音视界-TrollStore-3.6.9.ipa`。
9. 把 IPA 传到 iPhone，用 TrollStore 打开安装。

## 重要说明

- 这个流程不需要你本地有 Mac。
- 这个流程使用 GitHub 提供的云端 macOS + Xcode。
- 这个流程不需要 Apple 开发者证书，因为构建命令使用了 `--no-codesign`。
- TrollStore 通常可以安装这种标准 `Payload/Runner.app` 结构的 IPA。
- 如果安装失败，通常是设备不支持 TrollStore、Bundle ID 冲突，或 iOS 系统版本不兼容。

## 已内置工作流

工作流文件位置：

```text
.github/workflows/build_trollstore_ipa.yml
```

你上传到 GitHub 后，Actions 会自动识别这个文件。
