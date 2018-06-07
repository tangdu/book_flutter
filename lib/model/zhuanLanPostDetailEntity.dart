class ZhuanLanPostDetailEntity {
  final String title;
  final String titleImage;
  final String content;

  ZhuanLanPostDetailEntity({this.title, this.titleImage, this.content});

  static ZhuanLanPostDetailEntity fromJson(Map<String, dynamic> json) {
    return new ZhuanLanPostDetailEntity(
        title: json['title'],
        titleImage: json['titleImage'],
        content: json['content']);
  }
}