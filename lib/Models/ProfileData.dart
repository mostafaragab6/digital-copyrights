class ProfileData {
  int? id;
  String? email;
  String? first_name;
  String? last_name;
  String? username;
  String? image_url;

  ProfileData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    email = json['email'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    username = json['username'];
    image_url = json['image_url'];

  }
}