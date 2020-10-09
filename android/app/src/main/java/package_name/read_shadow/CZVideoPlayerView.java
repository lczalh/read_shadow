package package_name.read_shadow;

import android.content.Context;
import android.graphics.Color;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;


import androidx.annotation.NonNull;

import com.tencent.liteav.demo.play.SuperPlayerModel;
import com.tencent.liteav.demo.play.SuperPlayerView;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class CZVideoPlayerView implements PlatformView, MethodChannel.MethodCallHandler, EventChannel.StreamHandler, SuperPlayerView.OnSuperPlayerViewCallback {

    TextView textView;

    View testView;

    private FrameLayout containerView;
    private SuperPlayerView superPlayerView;

    LinearLayout mLl;

    CZVideoPlayerView(Context context, int viewId, Object args) {
        textView = new TextView(context);
        textView.setText("我是Android View");
        textView.setTextColor(Color.parseColor("#FFB6C1"));

//        tXCloudVideoView = new TXCloudVideoView(context);
        //创建 player 对象
//        TXVodPlayer mVodPlayer = new TXVodPlayer(context);
////关键 player 对象与界面 view
//        mVodPlayer.setPlayerView(tXCloudVideoView);
//        String url = "http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f10.mp4";
//        mVodPlayer.startPlay(url);

        testView = new View(context);
//
//        FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(
//                FrameLayout.LayoutParams.MATCH_PARENT,
//                FrameLayout.LayoutParams.MATCH_PARENT,
//                Gravity.CENTER_HORIZONTAL | Gravity.CENTER_VERTICAL
//        );
//        containerView = new FrameLayout(context);
//        containerView.setLayoutParams(layoutParams);
//
//        superPlayerView = new SuperPlayerView(context);
//        superPlayerView.setPlayerViewCallback(this);
//        containerView.addView(superPlayerView);

        superPlayerView = new SuperPlayerView(context);
        SuperPlayerModel model2 = new SuperPlayerModel();
        model2.url = "http://1252463788.vod2.myqcloud.com/95576ef5vodtransgzp1252463788/e1ab85305285890781763144364/v.f10.mp4";
        superPlayerView.playWithModel(model2);

//        mLl =new LinearLayout(context);
//        LinearLayout.LayoutParams  params=new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
//        mLl.setLayoutParams(params);
//        TextView tv = new TextView(context);
//        tv.setText("111111111111111111111111111111");
//        tv.setTextColor(Color.parseColor("#FFB6C1"));
//        LinearLayout.LayoutParams  lp1=new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
//        tv.setLayoutParams(lp1);
//        mLl.addView(tv);

    }

    @Override
    public View getView() {
        return superPlayerView;
    }

    @Override
    public void dispose() {

    }

    @Override
    public void onStartFullScreenPlay() {

    }

    @Override
    public void onStopFullScreenPlay() {

    }

    @Override
    public void onClickFloatCloseBtn() {

    }

    @Override
    public void onClickSmallReturnBtn() {

    }

    @Override
    public void onStartFloatWindowPlay() {

    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {

    }

    @Override
    public void onCancel(Object arguments) {

    }
}
