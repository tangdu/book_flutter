class ZhuanLanPostEntity {
  final String titleImage;
  final String summary;
  final String publishedTime;
  final String title;
  final String authorName;
  final String authorDescription;
  final String authorAvatar;
  final int commentsCount;
  final int likesCount;
  final String url;
  final int id;
  final String content;

  ZhuanLanPostEntity({
    this.titleImage,
    this.summary,
    this.publishedTime,
    this.title,
    this.authorName,
    this.authorDescription,
    this.authorAvatar,
    this.commentsCount,
    this.likesCount,
    this.url,
    this.content,
    this.id,
  });

  static List<ZhuanLanPostEntity> fromJson(List data) {
    return data
        .map((json) => new ZhuanLanPostEntity(
              titleImage: json['image_url'],
              summary: json['summary'],
              publishedTime: json['publishedTime'],
              title: json['title'],
              authorName: json['author']['name'],
              authorDescription: json['author']['description'],
              authorAvatar: json['author']['avatar']['template']
                  .toString()
                  .replaceAll("\{id\}", json['author']['avatar']['id'])
                  .replaceAll("\{size\}", "xl"),
              commentsCount: json['commentsCount'],
              likesCount: json['likesCount'],
              url: "https://zhuanlan.zhihu.com" + json['url'],
              content: json['content'],
              id: json['slug'],
            ))
        .toList();
  }
}
