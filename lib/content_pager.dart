import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/card_free.dart';
import 'package:flutter_app/card_recommend.dart';
import 'package:flutter_app/card_share.dart';
import 'package:flutter_app/card_special.dart';
import 'package:flutter_app/custom_appbar.dart';

class ContentPager extends StatefulWidget {
  final ValueChanged<int> onPageChanged;
  final ContentPagerController contentPagerController;
  // 构造方法，可选参数
  const ContentPager({Key key, this.onPageChanged, this.contentPagerController})
      // 初始化列表
      : super(key: key);

  @override
  _ContentPagerState createState() => _ContentPagerState();
}

class _ContentPagerState extends State<ContentPager> {
  PageController _pageController  = PageController(
    //视图实例
      viewportFraction:0.8
  );
  static List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.deepOrange,
    Colors.teal
  ];
  @override
  void initState() {
    if(widget.contentPagerController!=null){
      widget.contentPagerController._pageController = _pageController;
    }
    _statusBar();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // appBar
        CustomAppBar(),
        Expanded(
          // 高度撑开，否则在Column中没有高度会报错
            child: PageView(
              onPageChanged: widget.onPageChanged ,
              controller: _pageController,
              children: <Widget>[
                _wrapItem(CardRecommend()),
                _wrapItem(CardShare()),
                _wrapItem(CardFree()),
                _wrapItem(CardSpecial())
              ],
            ))
      ],
    );
  }
  Widget _wrapItem(Widget widget){
    return Padding(
      padding: EdgeInsets.all(10),
      child: widget
    );
  }
  // 状态栏样式-沉浸式状态栏
  _statusBar(){
    // 黑色沉浸式状态栏，基于SystemUiOverlayStyle.dark修改了statusBarColor
    SystemUiOverlayStyle uiOverlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF  ),
      systemNavigationBarDividerColor: null,
      statusBarColor: Colors.transparent ,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light
    );
    SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);
  }
}

// 内容区域的控制器
class ContentPagerController{
  PageController _pageController;
  void jumpToPage(int page){
    // dart 编程技巧：安全的调用
    _pageController?.jumpToPage(page);
  }
}