package au.com.daughterlycare.lifecycle_events

import io.flutter.embedding.engine.plugins.FlutterPlugin

/** LifecycleEventsPlugin */
class LifecycleEventsPlugin: FlutterPlugin {
  private var eventHandler: LifecycleEventsHandler? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    eventHandler = LifecycleEventsHandler.create(flutterPluginBinding)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    eventHandler?.dispose()
    eventHandler = null
  }

}
