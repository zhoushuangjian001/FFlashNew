import 'package:dio/dio.dart';
import 'package:fflashnews/picturemodules/picturecell.dart';
import 'package:flutter/material.dart';

class PictureRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片"),
      ),
      body: PicturePage(),
    );
  }
}

class PicturePage extends StatefulWidget {
  @override
  _PicturePage createState() => _PicturePage();
}

class _PicturePage extends State<PicturePage> {
  /// 数据列表
  List _dataList;

  /// 当前页
  int _curPage;

  // 初始化
  @override
  void initState() {
    super.initState();
    _curPage = 0;
    _dataList = [];
    _getListDataRequest();
  }

  // 网络请求 "maxtime"
  void _getListDataRequest() {
    Map<String, dynamic> pramMap = {
      "a": "list",
      "c": "data",
      "type": 10,
      "page": _curPage
    };
    // if (_dataList.length != 0) {
    //   var last = _dataList.last;
    //   var maxtime = last["maxtime"];
    //   if (maxtime) {
    //     pramMap.update("maxtime", (value) => maxtime);
    //   }
    // }
    Dio(BaseOptions(baseUrl: "http://api.budejie.com"))
        .get("/api/api_open.php", queryParameters: pramMap)
        .then(
      (value) {
        Map result = value.data;
        var dList = result["list"];
        _dataList = dList as List;
        if (mounted) {
          setState(() {});
        }
      },
    ).catchError(
      (err) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              _cellinit,
              childCount: _dataList.length,
            ),
          ),
        ],
      ),
    );
  }

  /// cell 创建
  Widget _cellinit(BuildContext context, int index) {
    var map = _dataList[index];
    return Container(
      child: PictureCell(map),
    );
  }
}
