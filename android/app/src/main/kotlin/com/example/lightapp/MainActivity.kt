package com.example.lightapp

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val METHOD_CHANNEL_NAME = "com.lightapp.light/method"
    private val INTENSITY_CHANNEL_NAME = "com.lightapp.light/intensity"

    private var methodChannel: MethodChannel? = null
    private lateinit var sensorManager: SensorManager
    private var intensityChannel: EventChannel? = null
    private var intensityStreamHandler:StreamHandler? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //Setup Channels
        setupChannels(this,flutterEngine.dartExecutor.binaryMessenger)

    }

    override fun onDestroy() {
        teardownChannels()
        super.onDestroy()
    }

    private fun setupChannels(context:Context, messenger:BinaryMessenger){
        sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager

        methodChannel = MethodChannel(messenger, METHOD_CHANNEL_NAME)
        methodChannel!!.setMethodCallHandler{
                call,result ->
            if (call.method == "isSensorAvailable") {
                result.success(sensorManager!!.getSensorList(Sensor.TYPE_LIGHT).isNotEmpty())
            } else {
                result.notImplemented()
            }
        }

        intensityChannel = EventChannel(messenger, INTENSITY_CHANNEL_NAME)
        intensityStreamHandler = StreamHandler(sensorManager!!, Sensor.TYPE_LIGHT)
        intensityChannel!!.setStreamHandler(intensityStreamHandler)
    }

    private fun teardownChannels(){
        methodChannel!!.setMethodCallHandler(null)
        intensityChannel!!.setStreamHandler(null)
    }

}