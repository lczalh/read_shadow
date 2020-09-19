//
//  CZVideoPlayerView.swift
//  cz_video_player
//
//  Created by yu mingming on 2020/9/2.
//
import UIKit
import SuperPlayer

class CZVideoPlayerView: NSObject, FlutterPlatformView {
    
    init(movieTitle: String, movieUrl: String) {
        super.init()
        // 监听电影信息
        NotificationCenter.default.addObserver(self, selector: #selector(movieInfoNotification), name: NSNotification.Name.init(rawValue: movieInfoIdentifier), object: nil)
        
        // 设置电影名称
        superPlayerView.controlView.title = movieTitle
        // 播放视频
        superPlayerModel.videoURL = movieUrl
        superPlayerView.play(with: superPlayerModel)
    }
    
    // MARK: - 收到电影信息
    @objc func movieInfoNotification(notification: Notification) {
        let movieIndoDict = notification.object as! Dictionary<String, Any>
        // 电影名称
        let movieTitle = movieIndoDict["movieTitle"] as? String ?? ""
        // 电影地址
        let movieUrl = movieIndoDict["movieUrl"] as? String ?? ""
        // 设置电影名称
        superPlayerView.controlView.title = movieTitle
        // 播放视频
        superPlayerModel.videoURL = movieUrl
        superPlayerView.play(with: superPlayerModel)
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
    

    deinit {
        superPlayerView.resetPlayer()
        NotificationCenter.default.removeObserver(self)
    }
    
//    /// 获取最上层window
//    private func cz_lastWindow() -> UIWindow? {
//        for window in UIApplication.shared.windows.reversed() {
//            if window.isKind(of: UIWindow.self) && window.bounds == UIScreen.main.bounds {
//                return window
//            }
//        }
//        if #available(iOS 13.0, *) {
//            return UIApplication.shared.windows.first
//        } else {
//            return UIApplication.shared.keyWindow
//        }
//    }
//    
//    /// 获取最上层的控制器
//    public func cz_topmostController(_ viewController: UIViewController = (UIApplication.shared.delegate?.window?!.rootViewController)!) -> UIViewController {
//        if viewController.isKind(of: UINavigationController.self) {
//            return cz_topmostController((viewController as! UINavigationController).visibleViewController!)
//        } else if viewController.isKind(of: UITabBarController.self) {
//            return cz_topmostController((viewController as! UITabBarController).selectedViewController!)
//        } else {
//            if (viewController.presentedViewController != nil) {
//                return cz_topmostController(viewController.presentedViewController!)
//            } else {
//                return viewController
//            }
//        }
//    }

}

extension CZVideoPlayerView: SuperPlayerDelegate {
    /// 返回事件
    func superPlayerBackAction(_ player: SuperPlayerView!) {
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: superPlayerBackActionIdentifier), object: nil)
        
    }
    
    /// 播放结束通知
    func superPlayerDidEnd(_ player: SuperPlayerView!) {
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: superPlayerDidEndIdentifier), object: nil)
    }
    
    /// 全屏改变通知
    func superPlayerFullScreenChanged(_ player: SuperPlayerView!) {
        
    }
}
