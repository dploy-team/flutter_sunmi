package com.example.flutter_sunmi;

import android.os.Bundle;

import com.sunmi.printerhelper.utils.AidlUtil;
import com.sunmi.printerhelper.utils.BitmapUtil;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {
  
  private static final String CHANNEL = "aidl";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    AidlUtil.getInstance().connectPrinterService(this);
    MethodChannel channel = new MethodChannel(getFlutterView(), CHANNEL);

    channel.setMethodCallHandler(
            (methodCall, result) -> {
              switch (methodCall.method) {
                case "print": {
                  AidlUtil.getInstance().print3Line();
                  break;
                }
                case "barcode": {
                  AidlUtil.getInstance().printBarCode("12389123760123", 7, 50, 10, 1);
                  break;
                }
                case "qr": {
                  AidlUtil.getInstance().printQr("Dploy", 10, 1);
                  break;
                }
                case "text": {
                  AidlUtil.getInstance().printText ("Dploy", 10, true, false);
                  break;
                }
                case "bitmap": {
                  AidlUtil.getInstance().printBitmap(BitmapUtil.generateBitmap("Blá",9 , 100, 100));
                  break;
                }
              }
            });

  }

}
