package package_name.read_shadow;

import android.content.Context;

import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class CZVideoPlayerViewFactory extends PlatformViewFactory {
    public CZVideoPlayerViewFactory() {
        super(StandardMessageCodec.INSTANCE);
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
        return new CZVideoPlayerView(context, viewId, args);
    }

}
