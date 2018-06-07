class ZhuanLanEntity {
  final String name;
  final String url;
  final int followersCount;
  final int postsCount;
  final String description;
  final String avatar;

  ZhuanLanEntity(
      {this.name,
      this.url,
      this.followersCount,
      this.postsCount,
      this.description,
      this.avatar});

  static List<ZhuanLanEntity> fromJson(List data) {
    return data
        .map((json) => new ZhuanLanEntity(
              name: json['name'],
              url: json['url'],
              followersCount: json['followersCount'],
              postsCount: json['postsCount'],
              description: json['description'],
              avatar: json['avatar']['template']
                  .toString()
                  .replaceAll("\{id\}", json['avatar']['id'])
                  .replaceAll("\{size\}", "xl")
                  .replaceAll("https", "http"),
            ))
        .toList();
  }
}
