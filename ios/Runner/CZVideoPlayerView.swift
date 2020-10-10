//
//  CZVideoPlayerView.swift
//  cz_video_player
//
//  Created by yu mingming on 2020/9/2.
//
import UIKit
import SuperPlayer

class CZVideoPlayerView: NSObject, FlutterPlatformView {
    
    var flutterViewController: FlutterViewController!
    
    // 传递信息的回调
    var eventSink: FlutterEventSink?
    
    init(controller: FlutterViewController) {
        super.init()
        flutterViewController = controller
        
        // iOS主动 与 Flutter 交互
        let eventChannel = FlutterEventChannel(name: "cz_video_player/event_channel", binaryMessenger: flutterViewController as! FlutterBinaryMessenger)
        eventChannel.setStreamHandler(self)
        
        
        // flutter 与 iOS 交互
        let channel = FlutterMethodChannel(name: "cz_video_player/method_channel", binaryMessenger: flutterViewController as! FlutterBinaryMessenger)
        channel.setMethodCallHandler {[weak self] (call, result) in
            let arguments = call.arguments as? Dictionary<String, Any> ?? [:]
            if call.method == "setTitle" {
                self?.superPlayerView.controlView.title = arguments["title"] as? String
            } else if call.method == "play" {
                self?.superPlayerModel.videoURL = arguments["url"] as? String ?? ""
                self?.superPlayerView.play(with: self?.superPlayerModel)
            } else if call.method == "pause" {
                self?.superPlayerView.pause()
            }
        }
        
       // superPlayerView.delegate = self
    }
    
    private lazy var containerView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    /// 腾讯视频播放器
    private lazy var superPlayerView: SuperPlayerView = {
        let view = SuperPlayerView(frame: containerView.bounds)
        view.coverImageView.contentMode = .scaleAspectFill
        view.autoPlay = true
        view.fatherView = containerView
        let superPlayerViewConfig = SuperPlayerViewConfig()
        superPlayerViewConfig.maxCacheItem = 10000
        view.playerConfig = superPlayerViewConfig
        view.delegate = self
        return view
    }()
    
    /// 腾讯视频播放器播放模型
    public lazy var superPlayerModel: SuperPlayerModel = {
        let model = SuperPlayerModel()
        return model
    }()
    
    func view() -> UIView {
        return containerView
    }
    
//    // 告知Flutter 点击了返回按钮
//    @objc func superPlayerBackAction(notification: Notification) {
//        if eventSink != nil {
//            eventSink!(
//                [
//                "type":"superPlayerBackAction",
//                "value": ""
//                ]
//            )
//        }
//    }
//
//    // 告知Flutter 视频播放结束
//    @objc func superPlayerDidEnd(notification: Notification) {
//        if eventSink != nil {
//            eventSink!(
//                [
//                    "type":"superPlayerDidEnd",
//                    "value": ""
//                ]
//            )
//        }
//    }
    

    deinit {
        superPlayerView.resetPlayer()
    }

}

extension CZVideoPlayerView: SuperPlayerDelegate {
    /// 返回事件
    func superPlayerBackAction(_ player: SuperPlayerView!) {
        if eventSink != nil {
            eventSink!(
                [
                "type":"superPlayerBackAction",
                "value": ""
                ]
            )
        }
    }
    
    /// 播放结束通知
    func superPlayerDidEnd(_ player: SuperPlayerView!) {
        if eventSink != nil {
            eventSink!(
                [
                    "type":"superPlayerDidEnd",
                    "value": ""
                ]
            )
        }
    }
    
    /// 全屏改变通知
    func superPlayerFullScreenChanged(_ player: SuperPlayerView!) {
        
    }
}

extension CZVideoPlayerView: FlutterStreamHandler {

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }


}
