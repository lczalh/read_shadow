import 'dart:io';

/// AdMobAppId
String getAdMobAppId() {
  if (Platform.isAndroid) {
    return "ca-app-pub-7194032995143004~8363517700";
  } else if (Platform.isIOS) {
    return "ca-app-pub-7194032995143004~6052577691";
  }
  return "";
}

/// 插页式广告id
String getInsertAdsId() {
  if (Platform.isAndroid) {
    return "ca-app-pub-7194032995143004/5545782674";
  } else if (Platform.isIOS) {
    return "ca-app-pub-7194032995143004/7501390732";
  }
  return "";
}