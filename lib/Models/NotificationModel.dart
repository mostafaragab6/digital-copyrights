class NotificationData{

  List<NData> nData=[];
  NotificationData.fromJson(List<dynamic> json){
    json.forEach((element){
      nData.add(NData.fromJson(element));
    });
  }

}

class NData{
  int? id;
  int? user;
  String? created_at;
  int? post;

  NData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    user = json['user'];
    created_at = json['created_at'];
    post = json['post'];
  }
}