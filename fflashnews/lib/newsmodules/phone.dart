import 'package:fflashnews/constmodules/appextend.dart';
import 'package:fflashnews/httpunit/dio_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PhonePage extends StatefulWidget {
  @override
  _PhonePage createState() => _PhonePage();
}

class _PhonePage extends State<PhonePage> {
  // 数据列表
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
    var url = "/nc/article/list/T1348649654285/$page-20.html";
    DioUnit.instance.getRequest(url, (response) {
      List list = response["T1348649654285"];
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
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              _buildCell,
              childCount: _dataList.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCell(BuildContext context, int index) {
    Map _map = _dataList[index];
    return FlowCell(_map);
  }
}

class FlowCell extends StatelessWidget {
  final Map map;
  const FlowCell(this.map, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: FadeInImage.assetNetwork(
              placeholder: PathHandle.imagePath("publics/list_img_seat.png"),
              image: map["imgsrc"] ?? "",
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            child: Text(
              map["title"] ?? "",
            ),
          ),
        ],
      ),
    );
  }
}
