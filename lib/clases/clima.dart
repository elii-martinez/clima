class ClimaInfo {
  final String city;
  final double temperature;
  final String description;
  final String icon;

  ClimaInfo({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory ClimaInfo.fromJson(String city, Map<String, dynamic> json) {
    return ClimaInfo(
      city: city,
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
