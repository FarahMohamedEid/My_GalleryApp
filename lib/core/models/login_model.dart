class LoginModel {

  late User? user;
  late String token;

  LoginModel.fromJson(Map<String, dynamic> json) {
    user = (json['user'] != null) ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

}

class User{
  late int id;
  late String name;
  late String email;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }
}