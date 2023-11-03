package com.example.reminder
import android.content.Intent
import android.net.Uri
import android.telephony.SmsManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private val smsChannel = "com.example.reminder"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, smsChannel).setMethodCallHandler { call, result ->
            if (call.method == "sendSMS") {
                val phoneNumbers = call.argument<List<String>>("phoneNumbers")
                val message = call.argument<String>("message")

                if (phoneNumbers != null && message != null) {
                    sendSMS(phoneNumbers, message)
                    result.success("SMS sent successfully.")
                } else {
                    result.error("INVALID_ARGUMENTS", "Phone numbers or message is missing.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun sendSMS(phoneNumbers: List<String>, message: String) {
        try {
            val smsManager = SmsManager.getDefault()
            for (phoneNumber in phoneNumbers) {
                smsManager.sendTextMessage(phoneNumber, null, message, null, null)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
