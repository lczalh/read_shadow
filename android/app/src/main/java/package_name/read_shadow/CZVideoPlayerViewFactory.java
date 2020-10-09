package package_name.read_shadow;

import android.app.Activity;
import android.content.Context;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class CZVideoPlayerViewFactory extends PlatformViewFactory {

    private final Activity activity;
   // private final BinaryMessenger messenger;

    public CZVideoPlayerViewFactory(Activity activity) {
        super(StandardMessageCodec.INSTANCE);
        this.activity = activity;
    }

    /**
     * 创建PlatformView
     * @param context 上下文
     * @param viewId 视图的id
     * @param args flutter端传回的参数
     * @return 返回一个PlatformView的实现类
     */
    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new CZVideoPlayerView(this.activity, viewId, args);
    }

}
