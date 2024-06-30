
class loginModel
{
  late bool status;
  late String token;
  loginModel.fromJson(Map<String,dynamic>json)
  {
    status=json['success'];
    token=json['token']!=null? json['token']:null;
  }
}
