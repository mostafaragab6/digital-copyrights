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
  UserPostInfo? userPostInfo;

  PostsAllContent.fromJson(Map<String,dynamic>json){
    description = json['description'];
    title = json['title'];
    image_url = json['image_url'];
    id = json['id'];
    created_at = json['created_at'];
    userPostInfo = UserPostInfo.fromJson(json['user']);
  }
}

class UserPostInfo{
  String? first_name;
  String? last_name;
  String? image_url;

  UserPostInfo.fromJson(Map<String,dynamic> json){
    first_name = json['first_name'];
    last_name = json['last_name'];
    image_url = json['image_url'];
  }

}