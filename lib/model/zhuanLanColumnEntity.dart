class ZhuanLanColumnEntity {
  final String title;
  final String url;
  final String titleImage;
  final int commentsCount;
  final int likesCount;
  final int slug;
  final int id;
  final String content;
  final String authorName;
  final String publishedTime;

  ZhuanLanColumnEntity(
      {this.title,
      this.url,
      this.titleImage,
      this.publishedTime,
      this.slug,
      this.id,
      this.content,
      this.commentsCount,
      this.likesCount,
      this.authorName});
  // 评论路径
  //https://zhuanlan.zhihu.com/api/posts/35654642/comments

  static List<ZhuanLanColumnEntity> fromJson(List data) {
    return data
        .map((json) => new ZhuanLanColumnEntity(
              title: json['title'],
              url: json['url'],
              publishedTime: json['publishedTime'],
              titleImage: json['titleImage']=='' ? 'https://pic2.zhimg.com/v2-c5293304a8df4f255f64b49b4a1b1c58_b.jpg':json['titleImage'],
              slug: json['slug'],
              id: json['slug'],
              likesCount: json['likesCount'],
              commentsCount: json['commentsCount'],
              authorName: json['author']['name'],
              content: json['content'],
            ))
        .toList();
  }
}
