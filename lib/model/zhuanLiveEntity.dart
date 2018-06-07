class ZhuanLiveEntity {
  final String id;
  final String title;
  final String subject;
  final List<dynamic> tags;
  final String speakerName;
  final String avatarUrl;
  final int seatTaken;
  final double score;

  ZhuanLiveEntity(
      {this.id,
      this.title,
      this.subject,
      this.tags,
      this.speakerName,
      this.avatarUrl,
      this.score,
      this.seatTaken});

  static List<ZhuanLiveEntity> fromJson(List<dynamic> data) {
    return data
        .map((json) => new ZhuanLiveEntity(
            id: json['live']['id'],
            title: json['live']['title'],
            subject: json['live']['subject'],
            tags: json['live']['tags'],
            score: json['live']['review']['score'],
            speakerName: json['live']['speaker']['member']['name'],
            avatarUrl: json['live']['speaker']['member']['avatar_url']
                .toString()
                .replaceAll('_s', '_xl'),
            seatTaken: json['live']['seats']['taken']))
        .toList();
  }
}