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
                        (input, output) -> {
                            switch (input.method) {
                                case "getSoma":
                                    int va = input.argument("valor_A");
                                    int vb = input.argument("valor_B");

                                    int resultadoSoma = va + vb;
                                    int resultadoSubtracao = va - vb;

                                    String retorno = String.format("{\"soma\": %d, \"subtracao\": %d}", resultadoSoma, resultadoSubtracao);


                                    output.success(retorno);
                                    break;
                            }
                        });
    }


    private int getIncremento() {
        int _incremento = 0;
        _incremento+=10;
        return _incremento;
    }



}
