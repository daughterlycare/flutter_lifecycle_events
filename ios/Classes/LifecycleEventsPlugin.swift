import Flutter
import UIKit

public class LifecycleEventsPlugin: NSObject, FlutterPlugin {
  public static var notificationCenterHandler: NotificationCenterHandler?
  
  public static func register(with registrar: FlutterPluginRegistrar) {

    LifecycleEventsPlugin.notificationCenterHandler = NotificationCenterHandler.create(with: registrar)
    
  }

  public static func detachFromEngine(for registrar: FlutterPluginRegistrar) {
    LifecycleEventsPlugin.notificationCenterHandler?.onCancel(withArguments: nil)
    LifecycleEventsPlugin.notificationCenterHandler = nil
  }

}
