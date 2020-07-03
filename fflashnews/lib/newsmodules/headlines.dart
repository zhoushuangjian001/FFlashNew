import 'package:fflashnews/httpunit/dio_unit.dart';
import 'package:flutter/material.dart';

class HeaderLines extends StatefulWidget {
  @override
  _HeaderLinesState createState() => _HeaderLinesState();
}

class _HeaderLinesState extends State<HeaderLines> {
  // 当前 page
  int _page;

  // 数据源列表
  List _dataList;

  /// 初始化
  @override
  void initState() {
    super.initState();
    _dataList = [];
    _page = 0;
    loadData(_page);
  }

  /// 网络请求
  void loadData(int page) async {
    var url = "/nc/article/headline/T1348647853363/$page-20.html";
    DioUnit.instance.getRequest(url, (response) {
      List list = response["T1348647853363"];
      if (_dataList.length != 0) {
        _dataList.addAll(list);
      } else {
        _dataList = list;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              child: Text("我是头部"),
              height: 300,
              color: Colors.purple,
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(_buildListItem,
                childCount: _dataList.length),
            itemExtent: 120,
          )
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Map map = _dataList[index];
    String title = map["title"];
    return ListTile(title: Text(title));
  }
}
