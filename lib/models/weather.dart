class Weather {
  final double currentTemp;
  final String currentDescription;
  final int currentDescId;

  Weather({required this.currentTemp, required this.currentDescription, required this.currentDescId});

  static Weather fromJson(Map<String, dynamic> json) => Weather(
        currentTemp: json['main']['temp'],
        currentDescription: json['weather'][0]['description'],
        currentDescId: json['weather'][0]['id'],
      );
}
