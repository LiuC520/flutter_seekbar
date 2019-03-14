// Copyright 2018 LiuCheng .All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import './progress_value.dart';
import './get_text_width.dart';
import './section_text_model.dart';

///要显示的刻度值
///如果要自定义刻度值，数组中需要包含这个实体类
///   List<SectionTextModel> sectionTexts = [];
///   sectionTexts.add(SectionTextModel(position: 0, text: 'bad', progressColor: Colors.red));
///   sectionTexts.add(SectionTextModel(position: 2, text: 'good', progressColor: Colors.yellow));
///   sectionTexts.add(SectionTextModel( position: 4, text: 'great', progressColor: Colors.green));
/// Padding(
///                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
///                  child: Column(
///                    children: <Widget>[
///                      Container(
///                          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
///                          width: 200,
///                          child: SeekBar(
///                            progresseight: 10,
///                            value: 75,
///                            sectionCount: 4,
///                            sectionRadius: 6,
///                            showSectionText: true,
///                            sectionTexts: sectionTexts,
///                            sectionTextMarginTop: 2,
///                            sectionDecimal: 0,
///                            sectionTextColor: Colors.black,
///                            sectionSelectTextColor: Colors.red,
///                            sectionTextSize: 14,
///                            hideBubble: false,
///                            bubbleRadius: 14,
///                            bubbleColor: Colors.purple,
///                            bubbleTextColor: Colors.white,
///                            bubbleTextSize: 14,
///                            bubbleMargin: 4,
///                            afterDragShowSectionText: true,
///                          )),
///                      Text(
///                        "自定义刻度值显示，带带刻度的指示器,可设置刻度的样式和选中的刻度的样式，拖拽结束显示刻度值，拖拽开始显示气泡",
///                        style: TextStyle(fontSize: 10),
///                      )
///                    ],
///                  ),
///                ),
///

abstract class BasicSeekbar extends StatefulWidget {
  ///最小值
  final double min;

  ///最大值
  final double max;

  ///进度值
  final double value;

  /// 高度
  final double progresseight;

  /// 总共分几份
  final int sectionCount;

  ///间隔圆圈的颜色
  final Color sectionColor;

  ///间隔圆圈未选中的颜色
  final Color sectionUnSelecteColor;

  ///间隔圆圈的半径
  final double sectionRadius;

  ///显示间隔刻度值与否，默认是不显示
  final bool showSectionText;

  /// 刻度值的数组
  final List<SectionTextModel> sectionTexts;

  ///刻度值的字体大小
  final double sectionTextSize;

  /// 是否在拖拽结束显示值
  final bool afterDragShowSectionText;

  ///刻度值的字体颜色
  final Color sectionTextColor;

  ///刻度值的字体颜色
  final Color sectionSelectTextColor;

  ///刻度值的小数点的位数，默认是0位
  final int sectionDecimal;

  ///刻度值距离进度条的间距
  final double sectionTextMarginTop;

  /// 指示器的半径
  final double indicatorRadius;

  ///指示器的颜色
  final Color indicatorColor;

  ///进度条背景的颜色
  final Color backgroundColor;

  /// 进度条当前进度的颜色
  final Color progressColor;

  ///这个是给盲人用的，屏幕阅读器的要读出来的标签
  final String semanticsLabel;

  ///这个是给盲人用的，屏幕阅读器的要读出的进度条的值
  final String semanticsValue;

  ///进度改变的回调
  final ValueChanged<ProgressValue> onValueChanged;
  // final void Function(double) onValueChanged;

  ///进度条是否是圆角的，还是方形的，默认是圆角的
  final bool isRound;

  const BasicSeekbar(
      {Key key,
      this.min,
      this.max,
      this.value,
      this.progresseight,
      this.sectionCount,
      this.sectionColor,
      this.sectionUnSelecteColor,
      this.sectionRadius,
      this.showSectionText,
      this.sectionTexts,
      this.sectionTextSize,
      this.afterDragShowSectionText,
      this.sectionTextColor,
      this.sectionSelectTextColor,
      this.sectionDecimal,
      this.sectionTextMarginTop,
      this.backgroundColor,
      this.progressColor,
      this.semanticsLabel,
      this.semanticsValue,
      this.indicatorRadius,
      this.indicatorColor,
      this.onValueChanged,
      this.isRound})
      : super(key: key);

  Color _getBackgroundColor(BuildContext context) =>
      backgroundColor ?? Theme.of(context).backgroundColor;
  Color _getProgressColor(BuildContext context) =>
      progressColor ?? Theme.of(context).accentColor;

  Widget _buildSemanticsWrapper({
    @required BuildContext context,
    @required Widget child,
  }) {
    String expandedSemanticsValue = semanticsValue;
    if (value != null) {
      expandedSemanticsValue ??= '${(value * 100).round()}%';
    }
    return Semantics(
      label: semanticsLabel,
      value: expandedSemanticsValue,
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(PercentProperty('value', value,
        showName: false, ifNull: '<indeterminate>'));
  }
}

@immutable
class _SeekBarPainter extends CustomPainter {
  ///背景颜色
  final Color backgroundColor;

  ///进度条的颜色
  final Color progressColor;

  ///进度值
  final double value;

  ///最大值
  final double min;

  ///最小值
  final double max;

  ///指示器的半径，进度条右侧的原点
  double indicatorRadius;

  ///最外层的圆角
  double radius;

  ///间隔数量
  int sectionCount;

  ///间隔圆圈的颜色
  Color sectionColor;

  ///间隔圆圈未选中的颜色
  final Color sectionUnSelecteColor;

  ///间隔圆圈的半径
  double sectionRadius;

  ///显示间隔刻度值与否，默认是不显示
  final bool showSectionText;

  /// 刻度值的数组
  final List<SectionTextModel> sectionTexts;

  ///刻度值的字体大小
  final double sectionTextSize;
  final bool afterDragShowSectionText;

  ///刻度值的字体颜色
  final Color sectionTextColor;

  ///刻度值的字体颜色
  final Color sectionSelectTextColor;

  ///刻度值的小数点的位数，默认是0位
  final int sectionDecimal;

  ///刻度值距离进度条的间距
  final double sectionTextMarginTop;

  ///进度条的高度
  double progresseight;

  ///指示器的颜色
  Color indicatorColor;

  ///气泡隐藏与否，默认是true,隐藏
  bool hideBubble;

  ///是否是一直显示气泡，默认是false，
  bool alwaysShowBubble;

  ///气泡的半径
  double bubbleRadius;

  ///气泡的总高度
  double bubbleHeight;

  /// 气泡背景颜色
  Color bubbleColor;

  /// 气泡中文字的颜色
  Color bubbleTextColor;

  /// 气泡中文字的大小
  double bubbleTextSize;

  /// 气泡距离底部的高度
  double bubbleMargin;

  /// 气泡在进度条的中间显示，而不是在进度条的上方展示，默认是false，在上方显示
  bool bubbleInCenter;
  _SeekBarPainter(
      {this.backgroundColor,
      this.progressColor,
      this.value,
      this.min,
      this.max,
      this.indicatorRadius,
      this.indicatorColor,
      this.radius,
      this.sectionCount,
      this.sectionColor,
      this.sectionUnSelecteColor,
      this.sectionRadius,
      this.showSectionText,
      this.sectionTexts,
      this.sectionTextSize,
      this.afterDragShowSectionText,
      this.sectionTextColor,
      this.sectionSelectTextColor,
      this.sectionDecimal,
      this.sectionTextMarginTop,
      this.progresseight,
      this.hideBubble,
      this.alwaysShowBubble,
      this.bubbleRadius,
      this.bubbleHeight,
      this.bubbleColor,
      this.bubbleTextColor,
      this.bubbleTextSize,
      this.bubbleMargin,
      this.bubbleInCenter});

  // 画path
  Path drawPath(double progresseight, double x, double totalHeight, double r) {
    Path path = new Path();
    //如果间隔存在，而且半径大于0，而且如果进度条的高度大于间隔的直径，半径就取高度的，否则进度条会变形
    double R = r;
    if (sectionCount > 1 && sectionRadius > 0.0) {
      if (progresseight > r * 2) {
        R = progresseight;
      } else {
        R = 0.0;
      }
    }
    double startY = 0.0;
    double endY = progresseight;
    startY = (-progresseight + totalHeight) / 2;
    endY = (progresseight + totalHeight) / 2;
    // if (progresseight <= indicatorRadius) {
    //   startY = indicatorRadius - progresseight / 2;
    //   endY = indicatorRadius + progresseight / 2;
    // }
    if (r == null || r == 0.0) {
      path
        ..moveTo(0.0, startY)
        ..lineTo(x, startY)
        ..lineTo(x, endY)
        ..lineTo(0.0, endY);
    } else {
      path
        ..moveTo(R, startY)
        ..lineTo(x - R, startY)
        ..arcToPoint(Offset(x - R, endY),
            radius: Radius.circular(R), clockwise: true, largeArc: false)
        ..lineTo(R, endY)
        ..arcToPoint(Offset(R, startY),
            radius: Radius.circular(R), clockwise: true, largeArc: true);
    }
    path..close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    ///1、画刻度值
    void drawSectionText() {
      if (!showSectionText) return;
      double yPosition = sectionTextMarginTop; //sectionTextMarginTop
      if (progresseight > 2 * indicatorRadius) {
        yPosition += (progresseight + size.height) / 2;
      } else {
        yPosition += indicatorRadius + size.height / 2;
      }
      double e = (max - min) / sectionCount;

      for (var i = 0; i < sectionCount + 1; i++) {
        String point = (e * i + min).toStringAsFixed(sectionDecimal);

        if (sectionTexts.length > 0) {
          Iterable<SectionTextModel> match = sectionTexts.where((item) {
            return item.position == i;
          });

          if (match.length > 0) {
            SectionTextModel matchModel = match.first;
            point = matchModel.text;
          } else if (i == value * sectionCount &&
              afterDragShowSectionText != null &&
              afterDragShowSectionText) {
          } else {
            point = '';
          }
        }

        Size textSize = getTextWidth(text: point, fontsize: sectionTextSize);
        Color textColor = sectionTextColor;
        if (sectionSelectTextColor != Colors.transparent &&
            i == value * sectionCount) {
          textColor = sectionSelectTextColor;
        }
        //为了计算文字和size的偏差
        double th = 0;
        if (textSize.height > size.height) {
          th = -(textSize.height - size.height) / 2;
        }
        canvas.drawParagraph(
            getParagraph(
                text: point,
                fontsize: sectionTextSize,
                textColor: textColor,
                textSize: textSize),
            Offset(i * size.width / sectionCount - textSize.width / 2,
                yPosition + th));
      }
    }

    canvas.drawPath(
        drawPath(progresseight, size.width, size.height, radius), paint); //画背景
    //下面是画矩形
    // Size newSize = new Size(size.width - indicatorRadius, size.height);
    // canvas.drawRect(Offset.zero & newSize, paint);

    paint.color = progressColor;

    // 画进度条
    void drawBar(double x, double progress) {
      if (x <= 0.0) return;
      //如果是分段，而且有自定义的刻度值
      if (sectionCount > 1 && sectionTexts.length > 1) {
        sectionTexts.forEach((item) {
          if (progress * sectionCount >= item.position) {
            if (item.progressColor != null) {
              paint.color = indicatorColor = sectionColor = item.progressColor;
            }
          }
        });
      }

      canvas.drawPath(drawPath(progresseight, x, size.height, radius), paint);
      // canvas.drawRect(Offset(x, 0.0) & Size(width, size.height), paint);
    }

    //画间隔
    void drawInterval() {
      if (sectionCount <= 1) return;
      for (var i = 0; i < sectionCount + 1; i++) {
        paint.color =
            i > value * sectionCount ? sectionUnSelecteColor : sectionColor;

        canvas.drawCircle(
            Offset(i * size.width / sectionCount, size.height / 2),
            sectionRadius,
            paint);
      }
    }

    // 画当前显示的值的指示器
    void drawIndicator() {
      if (indicatorRadius <= 0.0) return;
      if (indicatorColor == null) {
        indicatorColor = progressColor;
      }
      Paint indicatorPaint = new Paint()
        ..style = PaintingStyle.fill
        ..color = indicatorColor;
      canvas.drawCircle(Offset(value * size.width, size.height / 2),
          indicatorRadius, indicatorPaint);
    }

    //画顶部的指示器
    void drawTopBubble() {
      if (hideBubble || !alwaysShowBubble) return;
      paint.color = bubbleColor;
      double bubbleInCenterY = 0.0;
      double newBubbleHeight;
      if (bubbleInCenter) {
        bubbleMargin = 0.0;
        bubbleInCenterY = bubbleHeight - bubbleRadius;
        newBubbleHeight = bubbleHeight;
      } else {
        bubbleInCenterY = indicatorRadius - size.height / 2 + bubbleMargin;
        newBubbleHeight = bubbleHeight + bubbleInCenterY;
      }
      //计算bubble的坐标值，画出bubble，
      double x = bubbleRadius /
          (newBubbleHeight - bubbleRadius) *
          math.sqrt((math.pow(newBubbleHeight - bubbleRadius, 2) -
              math.pow(bubbleRadius, 2)));
      double y = math.sqrt(math.pow(bubbleRadius, 2) - x * x);
      Path bubblePath = new Path()
        ..moveTo(value * size.width,
            bubbleInCenter ? bubbleInCenterY : -bubbleInCenterY)
        ..lineTo(
            value * size.width + x,
            bubbleInCenter
                ? -newBubbleHeight + bubbleRadius + y + bubbleInCenterY
                : -newBubbleHeight + bubbleRadius + y)
        ..arcToPoint(
            Offset(
                value * size.width - x,
                bubbleInCenter
                    ? -newBubbleHeight + bubbleRadius + y + bubbleInCenterY
                    : -newBubbleHeight + bubbleRadius + y),
            radius: Radius.circular(bubbleRadius),
            clockwise: false,
            largeArc: true)
        ..close();
      canvas.drawPath(bubblePath, paint);

      double realValue = (max - min) * value + min;
      int rv = realValue.ceil();
      String text = '$rv';
      double fontsize = bubbleTextSize;

      //此���主要是拿到text的宽高，然后给个约束，同时把text准确的放到某个位置上
      Size textSize = getTextWidth(text: text, fontsize: fontsize);

      canvas.drawParagraph(
          getParagraph(
              text: text,
              fontsize: fontsize,
              textColor: bubbleTextColor,
              textSize: textSize),
          Offset(
              value * size.width - textSize.width / 2,
              bubbleInCenter
                  ? -newBubbleHeight +
                      bubbleRadius -
                      textSize.height / 2 +
                      bubbleInCenterY
                  : -newBubbleHeight + bubbleRadius - textSize.height / 2));
    }

    drawSectionText(); // draw section text 画刻度值

    drawBar(value.clamp(0.0, 1.0) * size.width, value); //画进度
    drawInterval(); //画间隔

    drawIndicator(); //draw indicator
    drawTopBubble(); //draw top bubble
  }

  @override
  bool shouldRepaint(_SeekBarPainter oldPainter) {
    return oldPainter != this;
  }
}

@immutable
class SeekBar extends BasicSeekbar {
  ///显示气泡 ,默认是隐藏的，true
  bool hideBubble;

  ///是否是一直显示气泡，默认是false，
  bool alwaysShowBubble;

  ///气泡半径
  double bubbleRadius;

  ///气泡总高度，包含气泡半径
  double bubbleHeight;

  /// 气泡背景颜色
  Color bubbleColor;

  /// 气泡中文字的颜色
  Color bubbleTextColor;

  /// 气泡中文字的大小
  double bubbleTextSize;

  /// 气泡距离底部的高度
  double bubbleMargin;
  bool bubbleInCenter;

  /// 是否可以触摸响应触摸事件
  bool isCanTouch;
  SeekBar({
    Key key,
    ValueChanged<ProgressValue> onValueChanged,
    double min = 0.0,
    double max = 100.0,
    double progresseight,
    double value = 0.0,
    Color backgroundColor,
    Color progressColor,
    String semanticsLabel,
    String semanticsValue,
    double indicatorRadius,
    Color indicatorColor,
    int sectionCount,
    Color sectionColor,

    ///间隔圆圈未选中的颜色
    final Color sectionUnSelecteColor,
    double sectionRadius,
    bool showSectionText,

    /// 刻度值的数组
    final List<SectionTextModel> sectionTexts,

    ///刻度值的字体大小
    final double sectionTextSize = 14.0,
    bool afterDragShowSectionText,

    ///刻度值的字体颜色
    final Color sectionTextColor,

    ///刻度值的字体颜色
    final Color sectionSelectTextColor,

    ///刻度值的小数点的位数，默认是0位
    final int sectionDecimal = 0,

    ///刻度值距离进度条的间距
    final double sectionTextMarginTop = 4.0,
    bool isRound = true,
    bool hideBubble,
    double bubbleRadius,
    this.bubbleHeight,
    this.bubbleColor,
    this.bubbleTextColor = Colors.white,
    this.bubbleTextSize = 14.0,
    this.bubbleMargin = 4.0,
    this.bubbleInCenter = false,
    this.alwaysShowBubble,
    this.isCanTouch = true,
  })  : this.hideBubble = hideBubble ?? true,
        this.bubbleRadius = bubbleRadius ?? 20,
        super(
          key: key,
          onValueChanged: onValueChanged,
          min: min,
          max: max,
          progresseight: progresseight,
          value: value,
          backgroundColor: backgroundColor,
          progressColor: progressColor,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
          indicatorRadius: indicatorRadius,
          indicatorColor: indicatorColor,
          isRound: isRound,
          sectionCount: sectionCount,
          sectionColor: sectionColor,
          sectionUnSelecteColor: sectionUnSelecteColor,
          sectionRadius: sectionRadius,
          showSectionText: showSectionText,
          sectionTexts: sectionTexts,
          sectionTextSize: sectionTextSize,
          afterDragShowSectionText: afterDragShowSectionText,
          sectionTextColor: sectionTextColor,
          sectionSelectTextColor: sectionSelectTextColor,
          sectionDecimal: sectionDecimal,
          sectionTextMarginTop: sectionTextMarginTop,
        );

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  ///进度值
  double _value;
  bool _afterDragShowSectionText;

  ///高度
  double progresseight;

  ///��高度
  double totalHeight;

  ///中间的指示器的圆角
  double indicatorRadius;

  ///左右两侧的圆角
  bool isRound;

  ///间�����
  int sectionCount;

  ///间隔圆圈的颜色
  Color sectionColor;

  ///间隔圆圈未选中的颜色
  Color sectionUnSelecteColor;

  ///间隔圆圈的半径
  double sectionRadius;

  ///气泡的总高度
  double bubbleHeight;
  bool _alwaysShowBubble;

  double length;
  double e;
  double start;
  double end;
  Offset touchPoint = Offset.zero;
  ProgressValue v;

  @override
  void initState() {
    super.initState();
    _value = (widget.value - widget.min) / (widget.max - widget.min);
    progresseight = widget.progresseight ?? 5.0;
    indicatorRadius = widget.indicatorRadius ?? progresseight + 2;
    sectionCount = widget.sectionCount ?? 1;
    sectionRadius = widget.sectionRadius ?? 0.0;
    bubbleHeight = widget.bubbleHeight ?? widget.bubbleRadius * 3;
    _alwaysShowBubble = widget.alwaysShowBubble ?? false;
    _afterDragShowSectionText = false;
    if (sectionCount > 1) {
      e = 1 / sectionCount; //每一份的值
      start = 0.0;
      end = 0.0;
    }

    if (indicatorRadius >= progresseight) {
      totalHeight = indicatorRadius * 2;
    } else {
      totalHeight = progresseight;
    }
    length = (widget.max - widget.min); //总���小
  }

  Widget _buildSeekBar(
      BuildContext context, double value, double min, double max) {
    return widget._buildSemanticsWrapper(
      context: context,
      child: Container(
        // height: totalHeight,
        //下面的可以设置约束
        constraints: const BoxConstraints(
          minWidth: double.infinity,
          minHeight: 10,
        ),
        child: CustomPaint(
          painter: _SeekBarPainter(
            backgroundColor: widget._getBackgroundColor(context),
            progressColor: widget._getProgressColor(context),
            value: value,
            min: min,
            max: max,
            indicatorRadius: indicatorRadius,
            progresseight: progresseight,
            radius: widget.isRound ? progresseight / 2 : 0.0,
            indicatorColor:
                widget.indicatorColor ?? widget._getProgressColor(context),
            sectionCount: sectionCount,
            sectionColor:
                widget.sectionColor ?? widget._getProgressColor(context),
            sectionUnSelecteColor: widget.sectionUnSelecteColor ??
                widget._getBackgroundColor(context),
            sectionRadius: sectionRadius,
            showSectionText: widget.showSectionText ?? false,
            sectionTexts: widget.sectionTexts ?? [],
            sectionTextSize: widget.sectionTextSize,
            afterDragShowSectionText: _afterDragShowSectionText,
            sectionTextColor:
                widget.sectionTextColor ?? widget._getProgressColor(context),
            sectionSelectTextColor:
                widget.sectionSelectTextColor ?? Colors.transparent,
            sectionDecimal: widget.sectionDecimal,
            sectionTextMarginTop: widget.sectionTextMarginTop,
            hideBubble: widget.hideBubble,
            alwaysShowBubble: _alwaysShowBubble,
            bubbleRadius: widget.bubbleRadius,
            bubbleHeight: bubbleHeight,
            bubbleColor:
                widget.bubbleColor ?? widget._getProgressColor(context),
            bubbleTextColor: widget.bubbleTextColor,
            bubbleTextSize: widget.bubbleTextSize,
            bubbleMargin: widget.bubbleMargin,
            bubbleInCenter: widget.bubbleInCenter,
          ),
        ),
      ),
    );
  }

  // Updates height and value when user taps on the SeekBar.
  void _onTapUp(TapUpDetails tapDetails) {
    RenderBox renderBox = context.findRenderObject();
    setState(() {
      touchPoint = new Offset(
          renderBox.globalToLocal(tapDetails.globalPosition).dx, 0.0);
      _value = touchPoint.dx / context.size.width;
      _setValue();
      if (widget.alwaysShowBubble != null && widget.alwaysShowBubble
          ? false
          : true) {
        _alwaysShowBubble = false;
      }
      if (widget.afterDragShowSectionText ?? false) {
        _afterDragShowSectionText = true;
      }
    });
  }

  void _onPanDown(DragDownDetails details) {
    RenderBox box = context.findRenderObject();
    touchPoint = box.globalToLocal(details.globalPosition);
    //防止绘画越界
    if (touchPoint.dx <= 0) {
      touchPoint = new Offset(0, 0.0);
    }
    if (touchPoint.dx >= context.size.width) {
      touchPoint = new Offset(context.size.width, 0);
    }
    if (touchPoint.dy <= 0) {
      touchPoint = new Offset(touchPoint.dx, 0.0);
    }
    if (touchPoint.dy >= context.size.height) {
      touchPoint = new Offset(touchPoint.dx, context.size.height);
    }
    setState(() {
      _value = touchPoint.dx / context.size.width;
      _setValue();
      if (widget.alwaysShowBubble != null && widget.alwaysShowBubble
          ? false
          : true) {
        this._alwaysShowBubble = true;
      }
      if (widget.afterDragShowSectionText ?? false) {
        _afterDragShowSectionText = false;
      }
    });
  }

  // Updates height and value when user drags the SeekBar.
  void _onPanUpdate(DragUpdateDetails dragDetails) {
    RenderBox box = context.findRenderObject();
    touchPoint = box.globalToLocal(dragDetails.globalPosition);
    //防止绘画越界
    if (touchPoint.dx <= 0) {
      touchPoint = new Offset(0, 0.0);
    }
    if (touchPoint.dx >= context.size.width) {
      touchPoint = new Offset(context.size.width, 0);
    }
    if (touchPoint.dy <= 0) {
      touchPoint = new Offset(touchPoint.dx, 0.0);
    }
    if (touchPoint.dy >= context.size.height) {
      touchPoint = new Offset(touchPoint.dx, context.size.height);
    }
    setState(() {
      _value = touchPoint.dx / context.size.width;

      _setValue();
    });
  }

  void _onPanEnd(DragEndDetails dragDetails) {
    setState(() {
      if (widget.alwaysShowBubble != null && widget.alwaysShowBubble
          ? false
          : true) {
        this._alwaysShowBubble = false;
      }
      if (widget.afterDragShowSectionText ?? false) {
        _afterDragShowSectionText = true;
      }
    });
  }

  void _setValue() {
    //这个是当前的进度 从0-1
    //这个�����值��能在这个地方获取，如果没有指定，就是容器的��度
    if (sectionCount > 1) {
      for (var i = 0; i < sectionCount; i++) {
        if (_value >= i * e && _value <= (i + 1) * e) {
          start = i * e;
          if (i == sectionCount) {
            end = sectionCount * e;
          } else {
            end = (i + 1) * e;
          }
          break;
        }
      }
      if (_value >= start + e / 2) {
        _value = end;
      } else {
        _value = start;
      }
    }
    double realValue = length * _value + widget.min; //真实的值

    if (widget.onValueChanged != null) {
      ProgressValue v = ProgressValue(progress: _value, value: realValue);
      widget.onValueChanged(v);
    }
  }

  @override
  void didUpdateWidget(SeekBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _value = (widget.value - widget.min) / (widget.max - widget.min);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCanTouch) {
      return GestureDetector(
          onPanDown: _onPanDown,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          onTapUp: _onTapUp,
          child: _buildSeekBar(context, _value, widget.min, widget.max));
    } else {
      return _buildSeekBar(context, _value, widget.min, widget.max);
    }
  }
}
