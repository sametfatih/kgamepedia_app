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

  KgameUser(
      {this.id = '',
      required this.userName,
      required this.userSurname,
      required this.userAge,
      required this.userEmail,
      required this.userPassword,
      required this.userCountry,
      required this.userCity,
      required this.userLikes});

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
      );
}
