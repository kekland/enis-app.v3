class UserData {
  String username;
  String password;
  String schoolUrl;

  UserData({
    this.username,
    this.password,
    this.schoolUrl,
  });

  factory UserData.fromJson(Map<String, String> json) {
    return new UserData(
      username: json['username'],
      password: json['password'],
      schoolUrl: json['schoolUrl'],
    );
  }

  Map<String, String> toJson() => {
        "username": username,
        "password": password,
        "schoolUrl": schoolUrl,
      };
}
