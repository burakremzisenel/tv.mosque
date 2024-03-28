package de.mosque.tv

import io.flutter.embedding.android.FlutterActivity

import android.content.Context
import android.os.PowerManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class MainActivity: FlutterActivity() {
    private lateinit var channel : MethodChannel
    private lateinit var powerManager: PowerManager
    private lateinit var wakeLock: PowerManager.WakeLock

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "mosque.tv/flutter_hdmi_cec")
        channel.setMethodCallHandler{
                call, result ->
            when (call.method) {
                "getPlatformVersion" -> {
                    result.success("Android ${android.os.Build.VERSION.RELEASE}")
                }
                "wakeUp" -> {
                    wakeUp()
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
        powerManager = context.getSystemService(Context.POWER_SERVICE) as PowerManager
    }

    private fun wakeUp() {
        // Hier können Sie den TV aus dem Standby-Modus aufwecken
        wakeLock = powerManager.newWakeLock(PowerManager.SCREEN_BRIGHT_WAKE_LOCK or PowerManager.ACQUIRE_CAUSES_WAKEUP, "HdmiCecPlugin:WakeLock")
        wakeLock.acquire()
        wakeLock.release()
    }

/*    private val bootReceiver = BootReceiver()

    override fun onStart() {
        super.onStart()
        registerBootReceiver()
    }

    override fun onStop() {
        super.onStop()
        unregisterBootReceiver()
    }

    private fun registerBootReceiver() {
        val filter = IntentFilter(Intent.ACTION_BOOT_COMPLETED)
        registerReceiver(bootReceiver, filter)
    }

    private fun unregisterBootReceiver() {
        unregisterReceiver(bootReceiver)
    }*/
}
