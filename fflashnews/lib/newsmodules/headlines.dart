import 'package:fflashnews/constmodules/appextend.dart';
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

  // 头部数据源
  Map _headerMap;

  /// 初始化
  @override
  void initState() {
    super.initState();
    _dataList = [];
    _headerMap = Map();
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
        _headerMap = list.first;
        list.remove(_headerMap);
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
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: FadeInImage.assetNetwork(
                      placeholder:
                          PathHandle.imagePath("publics/list_img_seat.png"),
                      image: _headerMap["imgsrc"] ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _headerMap["title"] ?? "",
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
              height: 300,
              color: Colors.white,
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(_buildListItem,
                childCount: _dataList.length),
            itemExtent: 150,
          )
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Map map = _dataList[index];
    String title = map["title"];
    String imgsrc = map["imgsrc"];
    String content = map["digest"];
    var votecount = map["votecount"];
    String time = map["mtime"];
    return Cell(imgsrc, title, content, votecount, time);
  }
}

// Cell
// ignore: non_constant_identifier_names
Widget Cell(String imgurl, String title, String content, dynamic commentNumber,
    String time) {
  return Container(
    padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
    child: Column(
      children: [
        Expanded(
          child: Row(
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: PathHandle.imagePath("publics/list_img_seat.png"),
                image: imgurl,
                width: 94,
                height: 74,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: Text(
                          content,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            child: Text(time),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                "$commentNumber 评论",
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          height: 1,
        ),
      ],
    ),
  );
}
