import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CZLoadingToast {

  CZLoadingToast._();

  static OverlayState overlayState;
  static OverlayEntry _overlayEntry;
  static bool _isVisible = false;

  static void show(
    String msg,
    BuildContext context,
  ) async {
    overlayState = Overlay.of(context);
    _overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitFadingCube(
                color: Theme.of(context).accentColor,
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                child: Text(msg, style: TextStyle(
                  fontSize: ScreenUtil().setSp(30)
                ),),
              )
            ],
          )
        ),
      ),
    );
    _isVisible = true;
    overlayState.insert(_overlayEntry);
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

