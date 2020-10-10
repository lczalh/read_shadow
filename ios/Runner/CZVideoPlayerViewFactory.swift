//
//  CZVideoPlayerViewFactory.swift
//  cz_video_player
//
//  Created by yu mingming on 2020/9/2.
//

import UIKit

class CZVideoPlayerViewFactory: NSObject, FlutterPlatformViewFactory {
    
    var flutterViewController: FlutterViewController!
    
    init(controller: FlutterViewController) {
        super.init()
        flutterViewController = controller
    }
    
    /**
    * 返回platformview实现类
    *@param frame 视图的大小
    *@param viewId 视图的唯一表示id
    *@param args 从flutter  creationParams 传回的参数
    *
    */
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
       // let argsDict = args as? Dictionary<String, String>
//        let movieTitle = argsDict?["movieTitle"] ?? ""
//        let movieUrl = argsDict?["movieUrl"] ?? ""
        return CZVideoPlayerView(controller: flutterViewController)
    }
    
    //如果需要使用args传参到ios，需要实现这个方法，返回协议。否则会失败。
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
