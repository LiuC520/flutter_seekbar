// Copyright 2018 LiuCheng .All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart'
    show TextPainter, TextSpan, TextStyle, TextDirection, Size, Color;
import 'dart:ui' as ui;

///获取字体的宽高，放在size中
Size getTextWidth({String text, double fontsize}) {
  //此���主要是拿到text的宽高，然后给个约束，同时把text准确的放到某个位置上
  final textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    text: TextSpan(
      text: text,
      style: TextStyle(fontSize: fontsize),
    ),
  );
  textPainter.layout();
  return Size(textPainter.width, textPainter.height);
}

///生成一个字体的形状，来画出来
ui.Paragraph getParagraph(
    {String text, double fontsize, Color textColor, Size textSize}) {
  //此处��须用ui���������中的，否则会找不到相关的路径
  ui.TextStyle ts = ui.TextStyle(color: textColor, fontSize: fontsize);

  //下面的代码是画text
  ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
    textDirection: TextDirection.ltr,
  ))
    ..pushStyle(ts)
    ..addText(text);
  ui.Paragraph paragraph = paragraphBuilder.build()
    ..layout(ui.ParagraphConstraints(width: textSize.width));
  return paragraph;
}
