class SmartisanTopic {
  String id;
  String site_id;
  String title;
  String headpic;
  String author_id;
  String author_name;
  String brief;
  String read_num;
  String collect_num;
  String origin_url;
  String url;
  String status;
  String create_time;
  String update_time;
  String pub_date;
  String md5;
  String is_recommend;
  String prepic1;
  SmartisanTopicInfo site_info;

  static List<SmartisanTopic> fromJson(List data) {
    push(json) {
      var t = new SmartisanTopic();
      t.id = json["id"];
      t.site_id = json["site_id"];
      t.title = json["title"];
      t.headpic = json["headpic"];
      t.author_id = json["author_id"];
      t.author_name = json["author_name"];
      t.brief = json["brief"];
      t.read_num = json["read_num"];
      t.collect_num = json["collect_num"];
      t.origin_url = json["origin_url"];
      t.url = json["url"];
      t.status = json["status"];
      t.create_time = json["create_time"];
      t.update_time = json["update_time"];
      t.pub_date = json["pub_date"];
      t.md5 = json["md5"];
      t.is_recommend = json["is_recommend"];
      t.prepic1=json["prepic1"];
      return t;
    }

    return data.map(push).toList();
  }
}

class SmartisanTopicInfo {
  String id;
  String name;
  String pic;
  String brief;
  String article_num;
  String cid;
}
