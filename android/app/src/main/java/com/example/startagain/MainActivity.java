package com.example.startagain;

import android.os.Bundle;
// import io.flutter.app.FlutterActivity;
import androidx.annotation.Nullable; // <- AndroidX nullable annotation

import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.app.FlutterFragmentActivity;

public class MainActivity extends FlutterFragmentActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
  }
}
