class ZhuanLiveDetailEntity {
  final String avatarUrl;
  final String subject;
  final String speakerName;
  final String speakerDescription;
  final String badgeName;

  ZhuanLiveDetailEntity(
      {this.avatarUrl,
      this.subject,
      this.speakerName,
      this.speakerDescription,
      this.badgeName});

  static ZhuanLiveDetailEntity fromJson(Map<String, dynamic> json) {
    return new ZhuanLiveDetailEntity(
        avatarUrl: json['speaker']['member']['avatar_url'],
        subject: json['subject'],
        speakerName: json['speaker']['member']['name'],
        badgeName: json['badge']['name'],
        speakerDescription: json['speaker']['description']);
  }
}
