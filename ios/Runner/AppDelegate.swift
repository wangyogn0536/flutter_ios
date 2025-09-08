import UIKit
import Flutter
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      // 配置后台任务
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
