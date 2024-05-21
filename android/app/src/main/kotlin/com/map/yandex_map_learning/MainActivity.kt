package com.map.yandex_map_learning


import android.app.Application
import com.yandex.mapkit.MapKitFactory;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant



class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("ed5d8a07-e42b-4489-9ee5-2ffcaf400ac2")
        super.configureFlutterEngine(flutterEngine)
    }
}
