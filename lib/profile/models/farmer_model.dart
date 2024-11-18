class Farmer {
  final int id;
  final String username;
  final String email;
  final String phoneNumber;
  final String? imageUrl;

  Farmer({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    this.imageUrl,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }
}
