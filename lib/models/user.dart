class User {
  String name;
  String email;
  String created;

User({required this.name, required this.email, required this.created});

  User.fromJson(Map<String, dynamic> json)
  : name = json['name'],
    email = json['email'],
    created = json['created_at'];
}