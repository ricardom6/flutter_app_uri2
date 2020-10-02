package brstartupnamer.com.m6.flutter_app_uri2;

import io.flutter.embedding.android.FlutterActivity;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "codigo.nativo/Android";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            System.out.println("primeiro1");
                            // Note: this method is invoked on the main thread.
                            if (call.method.equals("getIncremento")) {
                                int _incremento = getIncremento();
                                result.success(_incremento);
                            }
                            if (call.method.equals("getSoma")){
                                System.out.println("entrou");
                                //final int intA = call.argument("intA");
                                //final int intB = call.argument("intB");
                                //int _soma = (intA + intB + 1000);
                                int _soma = (1000);
                                result.success(_soma);
                        }


                            else {
                                result.notImplemented();
                            }

                        }
                );
    }

    private int getIncremento() {
        int _incremento = 0;
        _incremento+=10;
        return _incremento;
    }



}
