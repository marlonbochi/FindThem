class User {

  int id;
  String name;
  String photo;
  String password;

  User(
      this.id,
      this.name,
      this.photo,
      this.password
      );

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"].toString(),
        photo = json["photo"].toString(),
        password = json["password"].toString();
}