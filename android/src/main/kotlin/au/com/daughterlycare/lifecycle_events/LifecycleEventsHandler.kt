package au.com.daughterlycare.lifecycle_events

import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.OnLifecycleEvent
import androidx.lifecycle.ProcessLifecycleOwner
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel

class LifecycleEventsHandler: ActivityAware, LifecycleObserver, EventChannel.StreamHandler{

    private var lifecycleSink: EventChannel.EventSink? = null
    var eventChannel: EventChannel? = null


    companion object Factory {
        fun create(flutterPluginBinding: FlutterPluginBinding): LifecycleEventsHandler {
            val instance = LifecycleEventsHandler()
            instance.eventChannel = EventChannel(
              flutterPluginBinding.binaryMessenger,
              "au.com.daughterlycare/flutter_lifecycle_events"
            )

            instance.eventChannel?.setStreamHandler(instance)
            return instance
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        ProcessLifecycleOwner.get().lifecycle.addObserver(this)
    }

    fun dispose() {
        ProcessLifecycleOwner.get().lifecycle.removeObserver(this)
        eventChannel = null
        onCancel(null)
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_CREATE)
    fun onAppCreated() {
        lifecycleSink?.success("ON_CREATE")
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_START)
    fun onAppStarted() {
      lifecycleSink?.success("ON_START")
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_RESUME)
    fun onAppResumed() {
      lifecycleSink?.success("ON_RESUME")
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_PAUSE)
    fun onAppPaused() {
      lifecycleSink?.success("ON_PAUSE")
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_STOP)
    fun onAppStopped() {
      lifecycleSink?.success("ON_STOP")
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_DESTROY)
    fun onAppDestroy() {
      lifecycleSink?.success("ON_DESTROY")
    }

    override fun onDetachedFromActivityForConfigChanges() {
        // Nothing needs to happen
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        // Nothing needs to happen

    }

    override fun onDetachedFromActivity() {
        // Nothing needs to happen
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        lifecycleSink = events
    }

    override fun onCancel(arguments: Any?) {
        lifecycleSink = null
    }
}