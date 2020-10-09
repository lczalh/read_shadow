package package_name.read_shadow;

import android.os.Bundle;
import android.os.PersistableBundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.tencent.liteav.demo.play.SuperPlayerModel;
import com.tencent.liteav.demo.play.SuperPlayerView;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.platform.PlatformViewRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

//    @Override
//    protected void onCreate(@Nullable Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//
//        SuperPlayerView superPlayerView = new SuperPlayerView(this);
//        SuperPlayerModel model2 = new SuperPlayerModel();
//        model2.url = "http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f10.mp4";
//        superPlayerView.playWithModel(model2);
//        //setContentView(superPlayerView);
//    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        //GeneratedPluginRegistrant.registerWith(flutterEngine);
        PlatformViewRegistry registry = flutterEngine.getPlatformViewsController().getRegistry();
        registry.registerViewFactory("CZVideoPlayerViewFactory", new CZVideoPlayerViewFactory(this));
    }
}
