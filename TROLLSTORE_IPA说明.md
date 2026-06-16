# 巨魔 TrollStore IPA 打包说明

当前环境没有 macOS、Xcode 和 iOS SDK，所以不能在这里直接编译出真正可安装的 iOS IPA。

我已经给工程加入了 TrollStore 打包脚本：

- `scripts/build_trollstore_ipa.sh`
- `scripts/trollstore_entitlements.plist`

## 使用方法

在 Mac 上安装好 Flutter 和 Xcode 后，解压本工程并执行：

```bash
cd yingyin_shijie_flutter
chmod +x scripts/build_trollstore_ipa.sh
./scripts/build_trollstore_ipa.sh
```

成功后会生成：

```bash
build/影音视界-TrollStore-3.6.9.ipa
```

把这个 IPA 传到 iPhone，使用 TrollStore 打开安装即可。

## 可选：安装 ldid

如果你希望脚本执行临时签名，可以先安装 `ldid`：

```bash
brew install ldid
```

没有 `ldid` 时脚本也会继续打包，TrollStore 通常可以直接导入标准 Payload 结构的 IPA。

## 注意事项

- IPA 必须由 iOS `.app` 目录打包而来，不能由 Android APK 直接转换。
- Flutter iOS 编译必须依赖 macOS + Xcode。
- 如果 TrollStore 提示安装失败，请先确认设备支持 TrollStore，并检查系统版本、Bundle ID 是否冲突。
- 如需覆盖安装旧版本，建议保持 Bundle ID 不变。
