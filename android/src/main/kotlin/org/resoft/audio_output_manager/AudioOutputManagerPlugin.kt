package org.resoft.audio_output_manager

import android.content.Context
import android.media.AudioManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class AudioOutputManagerPlugin: FlutterPlugin, MethodChannel.MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context : Context

  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    channel = MethodChannel(binding.binaryMessenger, "audio_output_manager")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
    val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager

    when (call.method) {
      "switchToSpeaker" -> {
        audioManager.isSpeakerphoneOn = true
        result.success(null)
      }
      "switchToBluetooth" -> {
        audioManager.isSpeakerphoneOn = false
        audioManager.startBluetoothSco()
        audioManager.isBluetoothScoOn = true
        result.success(null)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}