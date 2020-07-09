import 'package:dio/dio.dart';

// 成功回调
typedef SuccessBlock(dynamic response);
// 失败回调
typedef FailBlock(dynamic err);

class DioUnit {
  factory DioUnit() => _getInstance();
  static DioUnit _instance;
  static DioUnit get instance => _getInstance();
  static DioUnit _getInstance() {
    if (_instance == null) {
      _instance = new DioUnit._init();
    }
    return _instance;
  }

  // 执行任务容器
  List _taskList;

  // 请求基础设置
  BaseOptions _baseOptions;

  /// 初始化
  DioUnit._init() {
    _taskList = [];
    _baseOptions = BaseOptions(
      baseUrl: "http://c.m.163.com",
      responseType: ResponseType.json,
    );
  }

  /// get
  void getRequest(String url, SuccessBlock successBlock,
      {FailBlock failBlock}) {
    var _dio = Dio(_baseOptions);
    _taskList.add(_dio);
    _dio.get(url).then((value) {
      successBlock(value.data);
    }).catchError((err) {
      _taskList.remove(_dio);
      _dio.clear();
      failBlock(err);
    });
  }

  Future<dynamic> getFutureRequest(String url) {
    var _dio = Dio(_baseOptions);
    _taskList.add(_dio);
    return _dio.get(url);
  }
}
