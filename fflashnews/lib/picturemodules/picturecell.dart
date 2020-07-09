import 'package:fflashnews/constmodules/appextend.dart';
import 'package:flutter/material.dart';

class PictureCell extends StatefulWidget {
  final Map infoMap;
  const PictureCell(this.infoMap, {Key key}) : super(key: key);
  @override
  _PictureCell createState() => _PictureCell();
}

class _PictureCell extends State<PictureCell> {
  // 中间量
  Map _map;
  @override
  void initState() {
    super.initState();
    _map = widget.infoMap;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Column(
        children: <Widget>[
          _headerTop(_map["profile_image"] ?? "", _map["name"] ?? "",
              _map["create_time"] ?? "", _map["text"] ?? ""),
          SizedBox(height: 5),
          FadeInImage.assetNetwork(
            placeholder: PathHandle.imagePath("publics/list_img_seat.png"),
            image: _map["image0"] ?? "",
          ),
          SizedBox(height: 5),
          _bottomArea(),
          Container(
            height: 10,
            color: Colors.grey[200],
          )
        ],
      ),
    );
  }

  // 顶部
  Widget _headerTop(String url, String name, String time, String content) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder:
                        PathHandle.imagePath("publics/list_img_seat.png"),
                    image: url ?? "",
                    width: 36,
                    height: 36,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(name),
                        ),
                        Container(
                          child: Text(time),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 50,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        PathHandle.imagePath(
                          "publics/fmore_menu.png",
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    _menuShow();
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(content),
            ),
          ),
        ],
      ),
    );
  }

  /// 举报弹框
  void _menuShow() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "收藏",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        endIndent: 10,
                        indent: 10,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "举报",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "取消",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 底部
  Widget _bottomArea() {
    return Container(
      child: Column(
        children: <Widget>[
          Divider(
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ItemButton(
                PathHandle.imagePath("publics/fpraise.png"),
                _map["ding"] ?? "0",
                selecdIcon: PathHandle.imagePath("publics/fspraise.png"),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.grey[200],
              ),
              ItemButton(
                PathHandle.imagePath("publics/tread.png"),
                _map["cai"] ?? "0",
                selecdIcon: PathHandle.imagePath("publics/stread.png"),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.grey[200],
              ),
              ItemButton(
                PathHandle.imagePath("publics/share.png"),
                _map["repost"] ?? "0",
                selecdIcon: PathHandle.imagePath("publics/sshare.png"),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.grey[200],
              ),
              ItemButton(
                PathHandle.imagePath("publics/msg.png"),
                _map["comment"] ?? "0",
                selecdIcon: PathHandle.imagePath("publics/smsg.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 按钮
class ItemButton extends StatefulWidget {
  final String icon;
  final String selecdIcon;
  final String number;
  const ItemButton(this.icon, this.number, {this.selecdIcon});
  @override
  _ItemButtonState createState() => _ItemButtonState();
}

class _ItemButtonState extends State<ItemButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool isSelecd;

  @override
  void initState() {
    super.initState();
    isSelecd = false;
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Image.asset(isSelecd == true ? widget.selecdIcon : widget.icon),
            SizedBox(
              width: 10,
            ),
            Text(
              "${widget.number}",
            ),
          ],
        ),
      ),
      onTap: () {
        if (mounted) {
          setState(() {
            isSelecd = !isSelecd;
          });
        }
      },
    );
  }
}
