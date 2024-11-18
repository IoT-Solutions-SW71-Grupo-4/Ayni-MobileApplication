class Crop {
  int id;
  String cropName;
  String irrigationType;
  int area;
  String plantingDate;
  int farmerId;
  String imageUrl;

  Crop({
    required this.id,
    required this.cropName,
    required this.irrigationType,
    required this.area,
    required this.plantingDate,
    required this.farmerId,
    required this.imageUrl,
  });

  factory Crop.fromJson(Map<String, dynamic> json) => Crop(
    id: json["id"],
    cropName: json["cropName"],
    irrigationType: json["irrigationType"],
    area: json["area"],
    plantingDate: json["plantingDate"],
    farmerId: json["farmerId"],
    imageUrl: json["imageUrl"],
  );

  // Método copyWith
  Crop copyWith({
    int? id,
    String? cropName,
    String? irrigationType,
    int? area,
    String? plantingDate,
    int? farmerId,
    String? imageUrl,
  }) {
    return Crop(
      id: id ?? this.id,
      cropName: cropName ?? this.cropName,
      irrigationType: irrigationType ?? this.irrigationType,
      area: area ?? this.area,
      plantingDate: plantingDate ?? this.plantingDate,
      farmerId: farmerId ?? this.farmerId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
