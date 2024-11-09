// Altın verisi almak için model sınıfı
class Gold {
  final String name;
  final double buying;
  final double selling;

  Gold({
    required this.name,
    required this.buying,
    required this.selling,
  });

  factory Gold.fromJson(Map<String, dynamic> json) {
    return Gold(
      name: json['name'] ?? '',
      buying: json['buying']?.toDouble() ?? 0.0,
      selling: json['selling']?.toDouble() ?? 0.0,
    );
  }
}
