
class ZhiHuHotEntity {
  
  String sno_text;
  String image;
  bool vedio;
  String title;
  String subTitle;
  String url;
  String id;

  static List<ZhiHuHotEntity> fromJson(List data) {
    push(json) {
      var t = new ZhiHuHotEntity();
      t.sno_text = json["target"]["metrics_area"]["text"];
      t.title = json["target"]["title_area"]["text"];
      t.subTitle = json["target"]["excerpt_area"]["text"];
      t.vedio = json["target"]["image_area"]["with_video_tag"];
      t.image = json["target"]["image_area"]["url"];
      t.url = json["target"]["link"]["url"];
      t.id = t.url.substring(t.url.lastIndexOf("/")+1);
      return t;
    }

    return data.map(push).toList();
  }
}

class ZhiHuQuetionEntity {
  
  String thumbnail;
  int voteupCount;
  int createdTime;
  int updatedTime;
  String title;
  String excerpt;
  String url;
  int answerId;
  String authorName;
  String authorAvatar;
  int questionId;
  bool collapsed;

  static List<ZhiHuQuetionEntity> fromJson(List data) {
    push(json) {
      var t = new ZhiHuQuetionEntity();
      t.thumbnail = json["thumbnail"];
      t.voteupCount = json["voteup_count"];
      t.createdTime = json["created_time"];
      t.updatedTime = json["updated_time"];
      t.title = json["question"]["title"];
      t.excerpt = json["excerpt"];
      t.url = json["url"];
      t.answerId = json["id"];
      t.authorName = json["author"]["name"];
      t.questionId =  json["question"]["id"];
      t.collapsed=  json["is_collapsed"];
      t.authorAvatar=json["author"]["avatar_url"];
      return t;
    }

    return data.map(push).toList();
  }
}


class ZhiHuAnswerEntity {
  
  String thumbnail;
  int voteupCount;
  int createdTime;
  int updatedTime;
  String title;
  String excerpt;
  String url;
  int answerId;
  String authorName;
  String authorAvatar;
  int questionId;
  String content;

  static ZhiHuAnswerEntity fromJson(Map data) {
    push(json) {
      var t = new ZhiHuAnswerEntity();
      t.thumbnail = json["thumbnail"];
      t.createdTime = json["created_time"];
      t.excerpt = json["excerpt"];
      t.url = json["url"];
      t.answerId = json["id"];
      t.authorName = json["author"]["name"];
      t.questionId =  json["question"]["id"];
      t.authorAvatar=json["author"]["avatar_url"];
      t.content=json["content"];
      return t;
    }
    return push(data);
  }
}