import 'package:fflashnews/httpunit/dio_unit.dart';
import 'package:fflashnews/newsmodules/headlines.dart';
import 'package:flutter/material.dart';

class NewsRouter extends StatefulWidget {
  @override
  _NewsRouter createState() => _NewsRouter();
}

class _NewsRouter extends State<NewsRouter>
    with SingleTickerProviderStateMixin {
  /// 模块初始化
  List _tabbarList;

  /// TabBar 的监控
  TabController _tabController;

  /// 初始化
  @override
  void initState() {
    super.initState();
    _tabbarList = ["头条", "NBA", "手机", "移动互联", "娱乐", "时尚", "电影", "科技"];
    _tabController = TabController(length: _tabbarList.length, vsync: this);
    _tabController.addListener(() {});

    DioUnit.instance.getRequest(
        "/nc/article/headline/T1348647853363/0-20.html", (response) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新闻"),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabbarList
              .map((text) => Tab(
                    text: text,
                  ))
              .toList(),
          isScrollable: true,
          indicatorColor: Colors.transparent,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabbarList.map((e) {
          return HeaderLines();
        }).toList(),
      ),
    );
  }
}
