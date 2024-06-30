class FollowUserData{
  bool? success;
  String? message;

  FollowUserData.fromJson(Map<String,dynamic> json){
    success = json["success"];
    message = json["message"];
  }
}