package package_name.read_shadow;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.platform.PlatformViewRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        //GeneratedPluginRegistrant.registerWith(flutterEngine);
        PlatformViewRegistry registry = flutterEngine.getPlatformViewsController().getRegistry();
        registry.registerViewFactory("CZVideoPlayerViewFactory", new CZVideoPlayerViewFactory());
    }
}
