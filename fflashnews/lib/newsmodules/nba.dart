import 'package:fflashnews/constmodules/appextend.dart';
import 'package:fflashnews/httpunit/dio_unit.dart';
import 'package:flutter/material.dart';

class NBAPage extends StatefulWidget {
  _NBAPage createState() => _NBAPage();
}

class _NBAPage extends State<NBAPage> {
  // 列表数据
  List _dataList;
  // 当前页
  int _page;

  @override
  void initState() {
    super.initState();
    _page = 0;
    _dataList = [];
    _getNetWorkListData(_page);
  }

  /// 获取数据
  void _getNetWorkListData(int page) async {
    var url = "/nc/article/list/T1348649145984/$page-20.html";
    DioUnit.instance.getRequest(url, (response) {
      List list = response["T1348649145984"];
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
          SliverList(
              delegate: SliverChildBuilderDelegate(
            _buildCell,
            childCount: _dataList.length,
          ))
        ],
      ),
    );
  }

  Widget _buildCell(BuildContext context, int index) {
    Map _map = _dataList[index];
    return AutoCell(_map);
  }
}

class AutoCell extends StatelessWidget {
  final Map map;
  const AutoCell(this.map, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 15,
        right: 15,
        bottom: 10,
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: 10,
            ),
            width: double.infinity,
            child: Text(
              map["title"] ?? "",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Text(
              map["digest"] ?? "",
            ),
            margin: EdgeInsets.only(
              bottom: 10,
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              "${map["votecount"] ?? 0} 评论",
              textAlign: TextAlign.right,
            ),
            margin: EdgeInsets.only(
              bottom: 10,
            ),
          ),
          FadeInImage.assetNetwork(
            placeholder: PathHandle.imagePath("publics/list_img_seat.png"),
            image: map["imgsrc"] ?? "",
          )
        ],
      ),
    );
  }
}
