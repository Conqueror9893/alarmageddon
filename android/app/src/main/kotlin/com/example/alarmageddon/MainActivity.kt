package com.example.alarmageddon  // make sure this matches your app's package

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "alarmageddon/speech"
    private val SPEECH_REQUEST_CODE = 1001
    private var resultPending: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startListening") {
                resultPending = result
                displaySpeechRecognizer()
            } else {
                result.notImplemented()
            }
        }
    }

    private fun displaySpeechRecognizer() {
        val intent = Intent(android.speech.RecognizerIntent.ACTION_RECOGNIZE_SPEECH)
        intent.putExtra(
            android.speech.RecognizerIntent.EXTRA_LANGUAGE_MODEL,
            android.speech.RecognizerIntent.LANGUAGE_MODEL_FREE_FORM
        )
        intent.putExtra(android.speech.RecognizerIntent.EXTRA_PROMPT, "Speak now")
        startActivityForResult(intent, SPEECH_REQUEST_CODE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == SPEECH_REQUEST_CODE && resultCode == Activity.RESULT_OK) {
            val results = data?.getStringArrayListExtra(android.speech.RecognizerIntent.EXTRA_RESULTS)
            val spokenText = results?.firstOrNull() ?: ""
            resultPending?.success(spokenText)
        } else {
            resultPending?.success("")  // ✅ empty string instead of invalid char
        }
        super.onActivityResult(requestCode, resultCode, data)
    }
}
