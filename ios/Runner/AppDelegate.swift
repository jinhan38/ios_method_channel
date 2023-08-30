import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var count :Int = 0
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: "iosMethodChannel", binaryMessenger : controller.binaryMessenger)
        
        // Flutter -> IOS 호출
        methodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            switch call.method {
            case "talk":
                result("call talk")
            default:
                result("not find method")
            }
        })
        
        
        // IOS -> Flutter 호출
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            self.count += 1
            methodChannel.invokeMethod("countMethod", arguments: self.count)
        }
        
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
}
