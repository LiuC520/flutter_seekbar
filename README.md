# flutter_seekbar

flutter 插件

flutter seekbar

A beautiful flutter custom seekbar, which has a bubble view with progress appearing upon when seeking. 自定义SeekBar，进度变化更以可视化气泡样式呈现



### 效果图
![flutter_seekbar](/screenshot.gif)

#### 引入:
```
dependencies:
  flutter:
    sdk: flutter
  flutter_seekbar:
    git: https://github.com/LiuC520/flutter_seekbar.git
```
#### 属性

| Attribute 属性          | 默认值|Description 描述 |
|:---				     |:---                |:---|
| min         | 0.0  |最小值|
| max         | 100.0 |最大值|
| value         |0 |默认进度值，最大值默认是100，指定了max，最大值是max|
| backgroundColor         | 页面配置的backgroundColor  |进度条背景颜色|
| progressColor         | accentColor | 当前进度的颜色|
| progresseight         | 5 |进度条的高度|
| sectionCount         | 1 |进度条分为几段|
| sectionColor         | 当前进度的颜色 |进度条每一个间隔的圆圈的颜色|
| sectionUnSelecteColor        | 进度条的背景颜色 |间隔未选中的颜色|
| sectionRadius        | 0.0 |间隔圆的半径
| showSectionText        | false |是否显示刻度值|
| sectionTexts        | 空数组 |自定义刻度值，是个数组，数组必须是SectionTextModel的实体|
| sectionTextSize        |14| 刻度值字体的大小|
| afterDragShowSectionText        | false|是否在拖拽结束后显示刻度值|
| sectionTextColor        | 黑色 | 刻度值字体的颜色|
| sectionSelectTextColor        | 透明（Colors.transparent） | 选中的刻度值字体的颜色|
| sectionDecimal        | 0|刻度值的小数点位数|
| sectionTextMarginTop        | 4.0 |刻度值距离进度条的间距|
| indicatorRadius        | 进度条的高度 + 2 |中间指示器圆圈的半径|
| indicatorColor        |进度条当前进度的颜色 |中间指示器圆圈的颜色|
| semanticsLabel        | |这个是给盲人用的，屏幕阅读器的要读出来的标签
| semanticsValue        | |这个是给盲人用的，屏幕阅读器的要读出的进度条的值
| onValueChanged        | 默认是空方法 | 进度改变的回调，是ProgressValue的实体，里面包含了进度，0-1，还包含了当前的进度值 |
| isRound        | true ( 圆角 ) |圆角还是直角，圆角的默认半径是进度条高度的一半
| hideBubble        | true|是否显示气泡，默认是隐藏
| alwaysShowBubble        |false |是否一致显示气泡，默认是false，也就是只有在拖拽的时间才显示气泡，拖拽结束不显示
| bubbleRadius        | 20|气泡的半径
| bubbleHeight        | 60 |气泡的总高度，包含顶部圆形的半径，默认是气泡半径的3倍
| bubbleColor        | 当前进度条的颜色 | 气泡的背景颜色 |
| bubbleTextColor        |白色 |气泡中当前进度值的字体颜色，默认是白色
| bubbleTextSize        |14 |气泡中当前进度值的字体大小，默认是14
| bubbleMargin        | 4|气泡底部距离进度条的高度，默认是4
| bubbleInCenter        |  false |气泡是否在进度条的中间显示，默认是
| isCanTouch        |  true |是否响应触摸事件，默认是响应的，也就是可以拖拽显示进度的




# Example

1、首先在pubspec.yaml中添加依赖
```
dependencies:
  flutter:
    sdk: flutter
  flutter_seekbar:
    git: https://github.com/LiuC520/flutter_seekbar.git

```

2、示例
```
import 'package:flutter_seekbar/flutter_seekbar.dart' show ProgressValue, SectionTextModel, SeekBar;



class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<SectionTextModel> sectionTexts = [];

  @override
  void initState() {
    super.initState();
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

```

# License

```
   Copyright 2018 LiucCheng

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
```

# contact me
qq: 674668211
wechat ：674668211 加微信进flutter微信群
掘金： https://juejin.im/user/581206302f301e005c60cd2f
简书：https://www.jianshu.com/u/4a5dce56807b
csdn：https://me.csdn.net/liu__520
github : https://github.com/LiuC520/