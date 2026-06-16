#!/usr/bin/env bash
set -euo pipefail

APP_NAME="影音视界"
IPA_NAME="影音视界-TrollStore-3.6.9.ipa"

cd "$(dirname "$0")/.."

echo "检查 Flutter 环境..."
flutter --version

echo "补全 iOS / Android 平台工程..."
flutter create . --platforms=ios,android

echo "获取依赖..."
flutter pub get

echo "构建 iOS Release App（不使用 Apple 签名）..."
flutter build ios --release --no-codesign

APP_PATH="build/ios/iphoneos/Runner.app"
if [ ! -d "$APP_PATH" ]; then
  echo "未找到 $APP_PATH，构建失败。"
  exit 1
fi

echo "修正显示名称..."
/usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName $APP_NAME" "$APP_PATH/Info.plist" 2>/dev/null || \
/usr/libexec/PlistBuddy -c "Add :CFBundleDisplayName string $APP_NAME" "$APP_PATH/Info.plist"

echo "准备 TrollStore IPA 目录..."
rm -rf build/trollstore_ipa
mkdir -p build/trollstore_ipa/Payload
cp -R "$APP_PATH" build/trollstore_ipa/Payload/

if command -v ldid >/dev/null 2>&1; then
  echo "检测到 ldid，执行临时签名..."
  ldid -Sscripts/trollstore_entitlements.plist "build/trollstore_ipa/Payload/Runner.app/Runner" || true
else
  echo "未检测到 ldid，跳过临时签名。TrollStore 通常仍可导入 IPA。"
fi

echo "打包 IPA..."
rm -f "build/$IPA_NAME"
(
  cd build/trollstore_ipa
  zip -qry "../$IPA_NAME" Payload
)

echo "完成：build/$IPA_NAME"
echo "把这个 IPA 传到 iPhone 后，用 TrollStore 打开安装。"
