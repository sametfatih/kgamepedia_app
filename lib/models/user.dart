class KgameUser {
  String id;
  final String userName;
  final String userSurname;
  final int userAge;
  final String userEmail;
  final String userPassword;
  final String userCountry;
  final String userCity;
  final List userLikes;
  final List userLibrary;

  KgameUser({
    this.id = '',
    required this.userName,
    required this.userSurname,
    required this.userAge,
    required this.userEmail,
    required this.userPassword,
    required this.userCountry,
    required this.userCity,
    required this.userLikes,
    required this.userLibrary,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'userSurname': userSurname,
        'userAge': userAge,
        'userEmail': userEmail,
        'userPassword': userPassword,
        'userCountry': userCountry,
        'userCity': userCity,
        'userLikes': userLikes,
        'userLibrary': userLibrary,
      };
  static KgameUser fromJson(Map<String, dynamic> json) => KgameUser(
        id: json['id'],
        userName: json['userName'],
        userSurname: json['userSurname'],
        userAge: json['userAge'],
        userEmail: json['userEmail'],
        userPassword: json['userPassword'],
        userCountry: json['userCountry'],
        userCity: json['userCity'],
        userLikes: json['userLikes'],
        userLibrary: json['userLibrary'],
      );
}
