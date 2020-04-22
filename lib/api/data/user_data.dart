class UserData {
  String username;
  String password;
  String schoolUrl;

  UserData({
    this.username,
    this.password,
    this.schoolUrl,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return new UserData(
      username: json['username'],
      password: json['password'],
      schoolUrl: json['schoolUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "schoolUrl": schoolUrl,
      };
}
