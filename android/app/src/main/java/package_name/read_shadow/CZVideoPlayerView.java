package package_name.read_shadow;

import android.content.Context;
import android.graphics.Color;
import android.view.View;
import android.widget.TextView;

import com.tencent.liteav.demo.play.SuperPlayerModel;
import com.tencent.liteav.demo.play.SuperPlayerView;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;

public class CZVideoPlayerView implements PlatformView {

    TextView textView;

    SuperPlayerView superPlayerView;

    CZVideoPlayerView(Context context, int viewId, Object args) {
        textView = new TextView(context);
        textView.setText("我是Android View");
        superPlayerView = new SuperPlayerView(context);
        superPlayerView.setBackgroundColor(Color.parseColor("#FFB6C1"));
        SuperPlayerModel model = new SuperPlayerModel();
        model.url = "http://200024424.vod.myqcloud.com/200024424_709ae516bdf811e6ad39991f76a4df69.f20.mp4";
        superPlayerView.playWithModel(model);
    }

    @Override
    public View getView() {
        return superPlayerView;
    }

    @Override
    public void dispose() {

    }
}
