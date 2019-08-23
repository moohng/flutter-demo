import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BottomDragWidget extends StatelessWidget {
  final Widget body;
  final Widget dragContainer;

  BottomDragWidget({Key key, @required this.body, @required this.dragContainer})
      : assert(body != null),
        assert(dragContainer != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        body,
        Align(
          alignment: Alignment.bottomCenter,
          child: dragContainer,
        ),
      ],
    );
  }
}


enum ScrollNotificationListener {
  ///滑动开始
  start,
  ///滑动结束
  end,
  ///滑动时，控件在边缘（最上面显示或者最下面显示）位置
  edge
}

//typedef DragListener = void Function(
//    double dragDistance, ScrollNotificationListener isDragEnd);

//class DragController {
//  DragListener _dragListener;
//
//  setDrag(DragListener l) {
//    _dragListener = l;
//  }
//
//  void updateDragDistance(
//      double dragDistance, ScrollNotificationListener isDragEnd) {
//    if (_dragListener != null) {
//      _dragListener(dragDistance, isDragEnd);
//    }
//  }
//}


//DragController _controller;

class DragContainer extends StatefulWidget {
  final Widget drawer;
  final double defaultShowHeight;
  final double height;

  DragContainer(
      {Key key,
      @required this.drawer,
      @required this.defaultShowHeight,
      @required this.height})
      : assert(drawer != null),
        assert(defaultShowHeight != null),
        assert(height != null),
        super(key: key) {
//    _controller = DragController();
  }

  @override
  State<StatefulWidget> createState() => _DragContainerState();
}

class _DragContainerState extends State<DragContainer> with TickerProviderStateMixin {
  AnimationController _animationController;

  double offsetDistance;  // 偏移值
  bool _isFling = false;
  bool _onResetControllerValue = false;
  Animation<double> animation;

  double get defaultOffsetDistance => widget.height - widget.defaultShowHeight;
  double get maxOffsetDistance => (widget.height + widget.defaultShowHeight) * 0.5;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds:  250),
      vsync: this,
    );

//    _controller.setDrag((double value, ScrollNotificationListener notification) {
//      if (notification != ScrollNotificationListener.edge) {
//        _handleDragEnd(null);
//      } else {
//        setState(() {
//          offsetDistance = offsetDistance + value;
//        });
//      }
//    });

    super.initState();
  }

  GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer> getRecognizer() {
    return GestureRecognizerFactoryWithHandlers<MyVerticalDragGestureRecognizer>(() => MyVerticalDragGestureRecognizer(flingListener: (bool isFling) {
      _isFling = isFling;
    }), (MyVerticalDragGestureRecognizer instance) {
      instance
        ..onStart = _handleDragStart
        ..onUpdate = _handleDragUpdate
        ..onEnd = _handleDragEnd;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (offsetDistance == null || _onResetControllerValue) {
      offsetDistance = defaultOffsetDistance;
    }
    // 设置偏移值的范围
    offsetDistance = offsetDistance.clamp(0.0, defaultOffsetDistance);
    bool offstage = offsetDistance < maxOffsetDistance;

    return Transform.translate(
      offset: Offset(0.0, offsetDistance),
      child: RawGestureDetector(
        gestures: { MyVerticalDragGestureRecognizer: getRecognizer() },
        child: Stack(
          children: <Widget>[
            Container(
              child: widget.drawer,
              height: widget.height,
            ),
            Offstage(
              child: Container(
                color: Colors.transparent,
                height: widget.height,
              ),
              offstage: offstage,
            ),
          ],
        ),
      ),
    );
  }

  void _handleDragEnd(DragEndDetails details) {
    _onResetControllerValue = true;

    ///很重要！！！动画完毕后，controller.value = 1.0， 这里要将value的值重置为0.0，才会再次运行动画
    ///重置value的值时，会刷新UI，故这里使用[onResetControllerValue]来进行过滤。
    _animationController.value = 0.0;
    _onResetControllerValue = false;
    double start;
    double end;
    if (offsetDistance <= maxOffsetDistance) {
      ///这个判断通过，说明已经child位置超过警戒线了，需要滚动到顶部了
      start = offsetDistance;
      end = 0.0;
    } else {
      start = offsetDistance;
      end = defaultOffsetDistance;
    }

    if (_isFling &&
        details != null &&
        details.velocity != null &&
        details.velocity.pixelsPerSecond != null &&
        details.velocity.pixelsPerSecond.dy < 0) {
      ///这个判断通过，说明是快速向上滑动，此时需要滚动到顶部了
      start = offsetDistance;
      end = 0.0;
    }

    ///easeOut 先快后慢
    final CurvedAnimation curve = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    animation = Tween(begin: start, end: end).animate(curve)
      ..addListener(() {
        if (!_onResetControllerValue) {
          offsetDistance = animation.value;
          setState(() {});
        }
      });
    ///自己滚动
    _animationController.forward();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    offsetDistance = offsetDistance + details.delta.dy;
    setState(() {});
  }

  void _handleDragStart(DragStartDetails details) {
    _isFling = false;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}


typedef FlingListener = void Function(bool isFling);

class MyVerticalDragGestureRecognizer extends VerticalDragGestureRecognizer {
  final FlingListener flingListener;

  MyVerticalDragGestureRecognizer({Object debugOwner, this.flingListener}) : super(debugOwner: debugOwner);

  final Map<int, VelocityTracker> _velocityTrackers = <int, VelocityTracker>{};

  @override
  void handleEvent(PointerEvent event) {
    super.handleEvent(event);
    if (!event.synthesized &&
        (event is PointerDownEvent || event is PointerMoveEvent)) {
      final VelocityTracker tracker = _velocityTrackers[event.pointer];
      assert(tracker != null);
      tracker.addPosition(event.timeStamp, event.position);
    }
  }

  @override
  void addPointer(PointerEvent event) {
    super.addPointer(event);
    _velocityTrackers[event.pointer] = VelocityTracker();
  }

  ///来检测是否是fling
  @override
  void didStopTrackingLastPointer(int pointer) {
    final double minVelocity = minFlingVelocity ?? kMinFlingVelocity;
    final double minDistance = minFlingDistance ?? kTouchSlop;
    final VelocityTracker tracker = _velocityTrackers[pointer];

    ///VelocityEstimate 计算二维速度的
    final VelocityEstimate estimate = tracker.getVelocityEstimate();
    bool isFling = false;
    if (estimate != null && estimate.pixelsPerSecond != null) {
      isFling = estimate.pixelsPerSecond.dy.abs() > minVelocity &&
          estimate.offset.dy.abs() > minDistance;
    }
    _velocityTrackers.clear();
    if (flingListener != null) {
      flingListener(isFling);
    }

    ///super.didStopTrackingLastPointer(pointer) 会调用[_handleDragEnd]
    ///所以将[lingListener(isFling);]放在前一步调用
    super.didStopTrackingLastPointer(pointer);
  }

  @override
  void dispose() {
    _velocityTrackers.clear();
    super.dispose();
  }
}


//class OverscrollNotificationWidget extends StatefulWidget {
//  const OverscrollNotificationWidget({
//    Key key,
//    @required this.child,
////    this.scrollListener,
//  })  : assert(child != null),
//        super(key: key);
//
//  final Widget child;
////  final ScrollListener scrollListener;
//
//  @override
//  State createState() => _OverscrollNotificationWidgetState();
//}
//
///// Contains the state for a [OverscrollNotificationWidget]. This class can be used to
///// programmatically show the refresh indicator, see the [show] method.
//class _OverscrollNotificationWidgetState
//    extends State<OverscrollNotificationWidget>
//    with TickerProviderStateMixin<OverscrollNotificationWidget> {
//  final GlobalKey _key = GlobalKey();
//
//  ///[ScrollStartNotification] 部件开始滑动
//  ///[ScrollUpdateNotification] 部件位置发生改变
//  ///[OverscrollNotification] 表示窗口小部件未更改它的滚动位置，因为更改会导致滚动位置超出其滚动范围
//  ///[ScrollEndNotification] 部件停止滚动
//  ///之所以不能使用这个来build或者layout，是因为这个通知的回调是会有延迟的。
//  ///Any attempt to adjust the build or layout based on a scroll notification would
//  ///result in a layout that lagged one frame behind, which is a poor user experience.
//
//  @override
//  Widget build(BuildContext context) {
//    print('NotificationListener build');
//    final Widget child = NotificationListener<ScrollStartNotification>(
//      key: _key,
//      child: NotificationListener<ScrollUpdateNotification>(
//        child: NotificationListener<OverscrollNotification>(
//          child: NotificationListener<ScrollEndNotification>(
//            child: widget.child,
//            onNotification: (ScrollEndNotification notification) {
//              _controller.updateDragDistance(
//                  0.0, ScrollNotificationListener.end);
//              return false;
//            },
//          ),
//          onNotification: (OverscrollNotification notification) {
//            if (notification.dragDetails != null &&
//                notification.dragDetails.delta != null) {
//              _controller.updateDragDistance(notification.dragDetails.delta.dy,
//                  ScrollNotificationListener.edge);
//            }
//            return false;
//          },
//        ),
//        onNotification: (ScrollUpdateNotification notification) {
//          return false;
//        },
//      ),
//      onNotification: (ScrollStartNotification scrollUpdateNotification) {
//        _controller.updateDragDistance(0.0, ScrollNotificationListener.start);
//        return false;
//      },
//    );
//
//    return child;
//  }
//}
