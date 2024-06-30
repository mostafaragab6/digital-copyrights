class NotifiedPostData{

  String? title;
  String? image_url;
  String? created_at;

  NotifiedPostData.fromJson(Map<String,dynamic> json){
    title = json['title'];
    image_url = json['image_url'];
    created_at = json['created_at'];
  }
}