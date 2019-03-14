import 'package:flutter/material.dart';

import 'package:flutter_seekbar/flutter_seekbar.dart'
    show SectionTextModel, SeekBar;

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<SectionTextModel> sectionTexts = [];
  double v;
  @override
  void initState() {
    super.initState();
    v = 80;
    sectionTexts.add(
        SectionTextModel(position: 0, text: 'bad', progressColor: Colors.red));
    sectionTexts.add(SectionTextModel(
        position: 2, text: 'good', progressColor: Colors.yellow));
    sectionTexts.add(SectionTextModel(
        position: 4, text: 'great', progressColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      width: 200,
                      child: SeekBar(
                        progresseight: 10,
                        indicatorRadius: 0.0,
                        value: v,
                        isRound: false,
                        progressColor: Colors.red,
                      )),
                  GestureDetector(
                      onTap: () => {
                            this.setState(() {
                              v = 60;
                            })
                          },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        width: 50,
                        height: 50,
                        color: Colors.blue,
                        child: Text(
                          "直角",
                          textDirection: TextDirection.ltr,
                          maxLines: 1,
                          style: TextStyle(fontSize: 10),
                        ),
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 200,
                        child: SeekBar(
                            isCanTouch: false,
                            indicatorRadius: 0.0,
                            progresseight: 5,
                            value: 50,
                            hideBubble: false,
                            alwaysShowBubble: true,
                            bubbleRadius: 14,
                            bubbleColor: Colors.purple,
                            bubbleTextColor: Colors.white,
                            bubbleTextSize: 14,
                            bubbleMargin: 4,
                            bubbleInCenter: true)),
                    Text(
                      "圆角，气泡居中，始终显示气泡",
                      textDirection: TextDirection.ltr,
                      maxLines: 1,
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                        width: 200,
                        child: SeekBar(
                          progresseight: 5,
                          value: 20,
                        )),
                    Text(
                      "圆角带指示器",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                        width: 200,
                        child: SeekBar(
                          progresseight: 5,
                          value: 50,
                          sectionCount: 5,
                        )),
                    Text(
                      "带间隔带指示器",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                        width: 200,
                        child: SeekBar(
                          progresseight: 5,
                          value: 50,
                          sectionCount: 4,
                          sectionRadius: 6,
                          sectionColor: Colors.red,
                        )),
                    Text(
                      "带间隔画间隔的指示器",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        Text(
                          '-10',
                          textDirection: TextDirection.ltr,
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 4),
                            width: 200,
                            child: SeekBar(
                                progresseight: 5,
                                value: 58,
                                min: -10,
                                max: 80,
                                sectionCount: 4,
                                sectionRadius: 6,
                                sectionColor: Colors.red,
                                hideBubble: false,
                                alwaysShowBubble: true,
                                bubbleRadius: 14,
                                bubbleColor: Colors.purple,
                                bubbleTextColor: Colors.white,
                                bubbleTextSize: 14,
                                bubbleMargin: 4,
                                onValueChanged: (v) {
                                  print('当前进度：${v.progress} ，当前的取值：${v.value}');
                                })),
                        Text(
                          '80',
                          textDirection: TextDirection.ltr,
                        )
                      ],
                    ),
                    Text(
                      "带间隔带气泡的指示器，气泡",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                        width: 200,
                        child: SeekBar(
                          progresseight: 10,
                          value: 50,
                          sectionCount: 4,
                          sectionRadius: 5,
                          sectionColor: Colors.red,
                          sectionUnSelecteColor: Colors.red[100],
                          showSectionText: true,
                          sectionTextMarginTop: 2,
                          sectionDecimal: 0,
                          sectionTextColor: Colors.black,
                          sectionSelectTextColor: Colors.red,
                          sectionTextSize: 14,
                        )),
                    Text(
                      "带带刻度的指示器,可设置刻度的样式和选中的刻度的样式",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                        width: 200,
                        child: SeekBar(
                          progresseight: 10,
                          value: 50,
                          sectionCount: 4,
                          sectionRadius: 5,
                          sectionColor: Colors.red,
                          sectionUnSelecteColor: Colors.red[100],
                          showSectionText: true,
                          sectionTextMarginTop: 2,
                          sectionDecimal: 0,
                          sectionTextColor: Colors.black,
                          sectionSelectTextColor: Colors.red,
                          sectionTextSize: 14,
                          hideBubble: false,
                          bubbleRadius: 14,
                          bubbleColor: Colors.purple,
                          bubbleTextColor: Colors.white,
                          bubbleTextSize: 14,
                          bubbleMargin: 4,
                          afterDragShowSectionText: true,
                        )),
                    Text(
                      "带带刻度的指示器,可设置刻度的样式和选中的刻度的样式，拖拽结束显示刻度值，拖拽开始显示气泡",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                        width: 200,
                        child: SeekBar(
                          min: -100,
                          max: 200,
                          progresseight: 10,
                          value: 50,
                          sectionCount: 4,
                          sectionRadius: 6,
                          showSectionText: true,
                          sectionTexts: [],
                          sectionTextMarginTop: 2,
                          sectionDecimal: 0,
                          sectionTextColor: Colors.black,
                          sectionSelectTextColor: Colors.red,
                          sectionTextSize: 14,
                          hideBubble: false,
                          bubbleRadius: 14,
                          bubbleColor: Colors.purple,
                          bubbleTextColor: Colors.white,
                          bubbleTextSize: 14,
                          bubbleMargin: 4,
                          afterDragShowSectionText: true,
                        )),
                    Text(
                      "自定义刻度值显示，带带刻度的指示器,可设置刻度的样式和选中的刻度的样式，拖拽结束显示刻度值，拖拽开始显示气泡",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                        width: 200,
                        child: SeekBar(
                          progresseight: 10,
                          value: 75,
                          sectionCount: 4,
                          sectionRadius: 6,
                          showSectionText: true,
                          sectionTexts: sectionTexts,
                          sectionTextMarginTop: 2,
                          sectionDecimal: 0,
                          sectionTextColor: Colors.black,
                          sectionSelectTextColor: Colors.red,
                          sectionTextSize: 14,
                          hideBubble: false,
                          bubbleRadius: 14,
                          bubbleColor: Colors.purple,
                          bubbleTextColor: Colors.white,
                          bubbleTextSize: 14,
                          bubbleMargin: 4,
                          afterDragShowSectionText: true,
                        )),
                    Text(
                      "自定义刻度值显示，带带刻度的指示器,可设置刻度的样式和选中的刻度的样式，拖拽结束显示刻度值，拖拽开始显示气泡",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
