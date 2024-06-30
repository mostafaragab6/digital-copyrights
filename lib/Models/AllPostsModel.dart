class PostsAllData{

  String? message;
  List<PostsAllContent> content=[];

  PostsAllData.fromJson(Map<String,dynamic> json){
    message = json['message'];
    json['posts'].forEach((element){
      content.insert(0,PostsAllContent.fromJson(element));
    });
  }

}

class PostsAllContent{
  int? id;
  String? created_at;
  String? description;
  String? title;
  String? image_url;


  PostsAllContent.fromJson(Map<String,dynamic>json){
    description = json['description'];
    title = json['title'];
    image_url = json['image_url'];
    id = json['id'];
    created_at = json['created_at'];
  }
}