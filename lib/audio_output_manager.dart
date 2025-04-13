import 'package:flutter/services.dart';

class AudioOutputManager {
  static const MethodChannel _channel = MethodChannel('audio_output_manager');

  static Future<void> switchToSpeaker() async {
    await _channel.invokeMethod('switchToSpeaker');
  }

  static Future<void> switchToBluetooth() async {
    await _channel.invokeMethod('switchToBluetooth');
  }
}
