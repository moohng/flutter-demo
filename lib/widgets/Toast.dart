import 'package:flutter/material.dart';

class Toast {
  static Future show(
    BuildContext context,
    String message, {
    int duration = 2,
    ToastPositions position = ToastPositions.bottom,
  }) async {
    bool _show = true;
    OverlayEntry _entry = OverlayEntry(builder: (BuildContext context) {
      Size _size = MediaQuery.of(context).size;
      Map<ToastPositions, double> positions = {
        ToastPositions.top: 0.2,
        ToastPositions.center: 0.5,
        ToastPositions.bottom: 0.8,
      };

      return Positioned(
        top: _size.height * positions[position],
        child: Container(
          alignment: Alignment.center,
          width: _size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0),
            child: AnimatedOpacity(
              opacity: _show ? 1.0 : 0.0,
              duration: Duration(milliseconds: _show ? 100 : 400),
              child: _buildToastWidget(message),
            ),
          ),
        ),
      );
    });

    Overlay.of(context).insert(_entry);

    await Future.delayed(Duration(seconds: duration));
    _show = false;
    _entry.markNeedsBuild();
    await Future.delayed(Duration(milliseconds: 400));
    _entry.remove();
    _entry = null;
  }

  static Widget _buildToastWidget(message) {
    return Center(
      child: Card(
        color: Colors.black45,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),
      ),
    );
  }
}

enum ToastPositions {
  top,
  center,
  bottom,
}
