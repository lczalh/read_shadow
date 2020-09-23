//
//  CZVideoPlayerView.swift
//  cz_video_player
//
//  Created by yu mingming on 2020/9/2.
//
import UIKit
import SuperPlayer

class CZVideoPlayerView: NSObject, FlutterPlatformView {
    
    override init() {
        super.init()
        // 监听电影信息
        NotificationCenter.default.addObserver(self, selector: #selector(methodChannelNotification), name: NSNotification.Name.init(rawValue: "cz_video_player/method_channel"), object: nil)
        superPlayerView.delegate = self
    }
    
    // MARK: - 收到电影信息
    @objc func methodChannelNotification(notification: Notification) {
        if let call = notification.object as? FlutterMethodCall {
            let arguments = call.arguments as? Dictionary<String, Any> ?? [:]
            if call.method == "setTitle" {
                superPlayerView.controlView.title = arguments["title"] as? String
            } else if call.method == "setUrl" {
                superPlayerModel.videoURL = arguments["url"] as? String ?? ""
                superPlayerView.play(with: superPlayerModel)
            }
        }
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
        //view.delegate = self
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
    

    deinit {
        NotificationCenter.default.removeObserver(self)
        superPlayerView.resetPlayer()
    }

}

extension CZVideoPlayerView: SuperPlayerDelegate {
    /// 返回事件
    func superPlayerBackAction(_ player: SuperPlayerView!) {
        //NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: superPlayerBackActionIdentifier), object: nil)
        
    }
    
    /// 播放结束通知
    func superPlayerDidEnd(_ player: SuperPlayerView!) {
        //NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: superPlayerDidEndIdentifier), object: nil)
    }
    
    /// 全屏改变通知
    func superPlayerFullScreenChanged(_ player: SuperPlayerView!) {
        
    }
}
