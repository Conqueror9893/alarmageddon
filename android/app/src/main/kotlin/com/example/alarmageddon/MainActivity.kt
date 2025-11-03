package com.example.alarmageddon

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import android.speech.RecognizerIntent
import java.util.Locale

class MainActivity: FlutterActivity() {
    private val CHANNEL = "alarmageddon/speech"
    private val SPEECH_REQUEST_CODE = 1001
    private var resultPending: MethodChannel.Result? = null
    private var currentLanguage: String = "de-DE"  // default to German

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startListening" -> {
                    resultPending = result
                    // Optionally: get the desired language from Dart side
                    val args = call.arguments as? Map<*, *>
                    currentLanguage = args?.get("language") as? String ?: "de-DE"
                    displaySpeechRecognizer()
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun displaySpeechRecognizer() {
        val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
            putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
            putExtra(RecognizerIntent.EXTRA_PROMPT, "Speak now (Language: $currentLanguage)")
            putExtra(RecognizerIntent.EXTRA_LANGUAGE, currentLanguage)
            putExtra(RecognizerIntent.EXTRA_LANGUAGE_PREFERENCE, currentLanguage)
            putExtra(RecognizerIntent.EXTRA_ONLY_RETURN_LANGUAGE_PREFERENCE, currentLanguage)
        }
        startActivityForResult(intent, SPEECH_REQUEST_CODE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == SPEECH_REQUEST_CODE && resultCode == Activity.RESULT_OK) {
            val results = data?.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS)
            val spokenText = results?.firstOrNull() ?: ""
            resultPending?.success(spokenText)
        } else {
            resultPending?.success("")
        }
        super.onActivityResult(requestCode, resultCode, data)
    }
}
