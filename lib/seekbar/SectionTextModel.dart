// Copyright 2018 LiuCheng .All rights reserved.
// Use of this source code is governed by a Apache license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart' show Color, Colors;

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
///                            value: 0.75,
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

class SectionTextModel {
  /// 文字要显示的位置,from 0,从0开始
  final int position;

  /// 要显示的文字
  final String text;

  /// 进度条的这个值之前的颜色
  final Color progressColor;

  const SectionTextModel(
      {this.position = -1,
      this.text = '',
      this.progressColor = Colors.transparent});

  @override
  String toString() {
    return 'SectionTextModel{position:$position, text: $text, progressColor: $progressColor}';
  }
}
