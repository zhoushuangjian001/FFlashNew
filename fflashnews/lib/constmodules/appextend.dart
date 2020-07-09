class PathHandle {
  static String imagePath(String imageName) {
    assert(imageName != null, "图片名字不能为空");
    String rootPath = "assets/images/";
    return rootPath + imageName;
  }
}
