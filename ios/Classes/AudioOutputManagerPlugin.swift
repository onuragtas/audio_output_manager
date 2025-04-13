import Flutter
import UIKit
import AVFoundation

public class AudioOutputManagerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "audio_output_manager", binaryMessenger: registrar.messenger())
    let instance = AudioOutputManagerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let session = AVAudioSession.sharedInstance()

    do {
      try session.setCategory(.playAndRecord, mode: .default, options: [.allowBluetooth, .defaultToSpeaker])
      try session.setActive(true)

      if call.method == "switchToSpeaker" {
        try session.overrideOutputAudioPort(.speaker)
        result(nil)
      } else if call.method == "switchToBluetooth" {
        try session.overrideOutputAudioPort(.none)
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    } catch {
      result(FlutterError(code: "AUDIO_ERROR", message: error.localizedDescription, details: nil))
    }
  }
}