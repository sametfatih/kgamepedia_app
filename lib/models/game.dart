class Game {
  final String gameId;
  final String gameName;
  final String gameDescription;
  final String gameCategory;
  final String gameMakerId;
  final String gameMakerName;
  final String gameMakerDesc;
  final String gameLink;
  final List platforms;
  final List ratings;

  Game({
    this.gameId = '',
    required this.gameName,
    required this.gameDescription,
    required this.gameCategory,
    required this.gameMakerId,
    required this.gameMakerName,
    required this.gameMakerDesc,
    required this.gameLink,
    required this.platforms,
    required this.ratings,
  });

  Map<String, dynamic> toJson() => {
        'gameId': gameId,
        'gameName': gameName,
        'gameDescription': gameDescription,
        'gameCategory': gameCategory,
        'gameMakerId': gameMakerId,
        'gameMakerName': gameMakerName,
        'gameMakerDesc': gameMakerDesc,
        'gameLink': gameLink,
        'platforms': platforms,
        'ratings': ratings,
      };
  static Game fromJson(Map<String, dynamic> json) => Game(
        gameId: json['gameId'],
        gameName: json['gameName'],
        gameDescription: json['gameDescription'],
        gameCategory: json['gameCategory'],
        gameMakerId: json['gameMakerId'],
        gameMakerName: json['gameMakerName'],
        gameMakerDesc: json['gameMakerDesc'],
        gameLink: json['gameLink'],
        platforms: json['platforms'],
        ratings: json['ratings'],
      );
}
