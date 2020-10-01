package package_name.read_shadow;

import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.tencent.liteav.demo.play.SuperPlayerModel;
import com.tencent.liteav.demo.play.SuperPlayerView;
import io.flutter.plugin.platform.PlatformView;

public class CZVideoPlayerView implements PlatformView {

    TextView textView;

    SuperPlayerView superPlayerView;

    CZVideoPlayerView(Context context, int viewId, Object args) {
        textView = new TextView(context);
        textView.setText("我是Android View");
        textView.setTextColor(Color.parseColor("#FFB6C1"));

//        LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
//                LinearLayout.LayoutParams.FILL_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);  //LayoutInflater inflater1=(LayoutInflater)mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
////  LayoutInflater inflater2 = getLayoutInflater();
//        LayoutInflater inflater3 = LayoutInflater.from(context);
//        superPlayerView = (SuperPlayerView) inflater3.inflate(R.layout.activity_main, null);
//        superPlayerView.setLayoutParams(lp);
//       // superPlayerView = superPlayerView.findViewById(R.id.main_super_player_view);
       // superPlayerView = new SuperPlayerView(context);
        //superPlayerView.setBackgroundColor(Color.parseColor("#FFB6C1"));
//        SuperPlayerModel model = new SuperPlayerModel();
//        model.url = "http://200024424.vod.myqcloud.com/200024424_709ae516bdf811e6ad39991f76a4df69.f20.mp4";
//        superPlayerView.playWithModel(model);
    }

    @Override
    public View getView() {
        return textView;
    }

    @Override
    public void dispose() {

    }
}
