import 'package:fflashnews/constmodules/appextend.dart';
import 'package:fflashnews/minemodules/mine.dart';
import 'package:fflashnews/newsmodules/news.dart';
import 'package:fflashnews/picturemodules/picture.dart';
import 'package:fflashnews/videomodules/video.dart';
import 'package:flutter/material.dart';

class RootTabBarController extends StatefulWidget {
  @override
  _RootTabBarController createState() => _RootTabBarController();
}

class _RootTabBarController extends State<RootTabBarController> {
  // 模块容器
  var _tabBarControllers;

  // 初始选择
  int _curIndex;

  /// 初始化加载模块
  @override
  void initState() {
    super.initState();
    _curIndex = 0;
    _tabBarControllers = [
      new NewsRouter(),
      new PictureRouter(),
      new VideoRouter(),
      new MineRouter(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabBarControllers[_curIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              PathHandle.imagePath("tabbar_news.png"),
              width: 26,
              height: 26,
            ),
            activeIcon: Image.asset(
              PathHandle.imagePath("tabbar_news_hl.png"),
              width: 26,
              height: 26,
            ),
            title: Text("首页"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PathHandle.imagePath("tabbar_picture.png"),
              width: 26,
              height: 26,
            ),
            activeIcon: Image.asset(
              PathHandle.imagePath("tabbar_picture_hl.png"),
              width: 26,
              height: 26,
            ),
            title: Text("图片"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PathHandle.imagePath("tabbar_video.png"),
              width: 26,
              height: 26,
            ),
            activeIcon: Image.asset(
              PathHandle.imagePath("tabbar_video_hl.png"),
              width: 26,
              height: 26,
            ),
            title: Text("视频"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              PathHandle.imagePath("tabbar_setting.png"),
              width: 26,
              height: 26,
            ),
            activeIcon: Image.asset(
              PathHandle.imagePath("tabbar_setting_hl.png"),
              width: 26,
              height: 26,
            ),
            title: Text("我的"),
          ),
        ],
        selectedItemColor: Color(0xffF45059),
        unselectedItemColor: Color(0xff939393),
        // 显示未选中的文字
        showUnselectedLabels: true,
        // 这是移除漂浮效果
        type: BottomNavigationBarType.fixed,
        // 这样可以移除点击放大效果
        selectedFontSize: 12,
        currentIndex: _curIndex,
        onTap: (index) {
          if (mounted) {
            setState(() {
              _curIndex = index;
            });
          }
        },
      ),
    );
  }
}
