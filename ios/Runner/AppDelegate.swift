import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var originalBrightness: CGFloat?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let messenger = engineBridge.pluginRegistry.registrar(forPlugin: "ScreenBrightness")!.messenger()
    let channel = FlutterMethodChannel(
      name: "vehicle_mate/screen_brightness",
      binaryMessenger: messenger
    )
    channel.setMethodCallHandler { [weak self] call, result in
      switch call.method {
      case "setMaxBrightness":
        self?.originalBrightness = self?.originalBrightness ?? UIScreen.main.brightness
        UIScreen.main.brightness = 1.0
        result(nil)
      case "restoreBrightness":
        if let original = self?.originalBrightness {
          UIScreen.main.brightness = original
          self?.originalBrightness = nil
        }
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
