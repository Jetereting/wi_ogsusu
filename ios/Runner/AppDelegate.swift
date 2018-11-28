import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
        ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
        let playStreamChannel = FlutterMethodChannel.init(name: "com.wiatec.ogsusu.video.player",
                                                          binaryMessenger: controller);
        playStreamChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            let method: String = call.method
            if (method.starts(with: "startPlayActivity")) {
                let params = method.components(separatedBy: "%%")
                let channelId = params[1]
                let token = params[2]
                self.launchVideoPlayController(controller, channelId: channelId, token: token)
                result("success")
            }else {
                result(FlutterMethodNotImplemented)
            }
        });
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    private func launchVideoPlayController(_ controller: UIViewController, channelId: String, token: String) {
        let board: UIStoryboard = UIStoryboard(name: "VideoPlayer", bundle: nil)
//        let videoController = board.instantiateViewController(withIdentifier: "VideoPlayerViewController") as! VideoPlayerViewController
        let videoController = board.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        videoController.channelId = channelId
        videoController.token = token
        controller.present(videoController, animated: false, completion: nil)
    }
}
