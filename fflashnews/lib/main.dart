import 'package:fflashnews/basemodules/roottabbarcontroller.dart';
import 'package:flutter/material.dart';

void main() => runApp(FFlashNews());

class FFlashNews extends StatefulWidget {
  _FFlashNews createState() => _FFlashNews();
}

class _FFlashNews extends State<FFlashNews> {
  /// 是否使用安全配置
  bool isSafeArea;

  /// 主体
  Color _primaryColor;

  /// 初始化
  @override
  void initState() {
    super.initState();
    isSafeArea = false;
    _primaryColor = Color(0xffF45059);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 隐藏导航右上角的 debug 标记
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        // 导航背景色
        primaryColor: _primaryColor,
      ),
      home: isSafeArea == false
          ? RootTabBarController()
          : SafeArea(
              child: RootTabBarController(),
            ),
    );
  }
}
