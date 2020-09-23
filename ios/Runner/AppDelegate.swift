import UIKit
import Flutter

// 电影信息标识
let movieInfoIdentifier = "movieInfoIdentifier"

// 电影视图返回标识
let superPlayerBackActionIdentifier = "superPlayerBackActionIdentifier"

// 电影播放结束标识
let superPlayerDidEndIdentifier = "superPlayerDidEndIdentifier"

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    
    // 传递信息的回调
    var eventSink: FlutterEventSink?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // 注册视图
    self.registrar(forPlugin: "CZVideoPlayerViewFactory")?.register(CZVideoPlayerViewFactory(), withId: "CZVideoPlayerViewFactory")
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
   
    // flutter 与 iOS 交互
    let channel = FlutterMethodChannel(name: "cz_video_player/method_channel", binaryMessenger: controller as! FlutterBinaryMessenger)
    channel.setMethodCallHandler { (call, result) in
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "cz_video_player/method_channel"), object: call)
    }
    
    // iOS主动 与 Flutter 交互
    let eventChannel = FlutterEventChannel(name: "cz_video_player/event_channel", binaryMessenger: controller as! FlutterBinaryMessenger)
    eventChannel.setStreamHandler(self)
    
    // 监听播放视图上的返回按事件
    NotificationCenter.default.addObserver(self, selector: #selector(superPlayerBackAction), name: NSNotification.Name.init(rawValue: superPlayerBackActionIdentifier), object: nil)
    
    // 监听播放结束
    NotificationCenter.default.addObserver(self, selector: #selector(superPlayerDidEnd), name: NSNotification.Name.init(rawValue: superPlayerDidEndIdentifier), object: nil)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    // 告知Flutter 点击了返回按钮
    @objc func superPlayerBackAction(notification: Notification) {
        if eventSink != nil {
            eventSink!(
                [
                "type":"superPlayerBackAction",
                "value": ""
                ]
            )
        }
    }
    
    // 告知Flutter 视频播放结束
    @objc func superPlayerDidEnd(notification: Notification) {
        if eventSink != nil {
            eventSink!(
                [
                    "type":"superPlayerDidEnd",
                    "value": ""
                ]
            )
        }
    }

}

extension AppDelegate: FlutterStreamHandler {
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    
}
