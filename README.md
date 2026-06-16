# 影音视界 Flutter 跨平台版

这是一个 Flutter 跨平台壳应用源码，面向 Android 与 iOS。当前版本号为 `3.6.9+369`，设置页显示 `官网𝒐𝒌𝒇𝒎.𝒄𝒏`。

## 已包含

- 启动首页：`影音视界`
- 官网显示：`官网𝒐𝒌𝒇𝒎.𝒄𝒏`
- 默认接口：`http://www.饭太硬.cc/tv`
- 首页影视卡片瀑布式网格
- 搜索入口
- 播放详情占位页
- 换源界面：2 / 3 / 4 列可选，默认 2 列
- 设置页：接口地址、官网、版本号、IPA 打包提示

## 在 macOS 上生成 iOS 工程

当前源码包没有附带完整 `ios/` 和 `android/` 平台目录。请在 macOS 电脑安装 Flutter 后执行：

```bash
cd yingyin_shijie_flutter
flutter create . --platforms=ios,android
flutter pub get
flutter run
```

## 导出 IPA

需要 Apple 开发者账号、证书、描述文件和 Xcode：

```bash
flutter build ipa --release
```

如果没有 Apple 开发者账号，可以先用模拟器或真机调试：

```bash
flutter run -d ios
```

## 后续可接入

这个工程目前是可运行的界面与结构模板。要完整复刻 APK，需要继续补充：

- 真实接口解析
- 影视分类和筛选
- 真实播放源解析
- m3u8 / mp4 播放器
- 收藏、历史记录、本地缓存
- iOS 后台播放与投屏能力
