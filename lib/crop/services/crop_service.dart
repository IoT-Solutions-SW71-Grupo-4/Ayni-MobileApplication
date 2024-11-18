import '../../home/models/crop.dart';
import '../../shared/api/base_service.dart';

class CropService {
  final BaseService _apiService = BaseService();

  Future<List<Crop>> getCropsByFarmerId(int farmerId) async {
    final response = await _apiService.get('crops/farmer/$farmerId/crops');



    return (response as List).map((json) => Crop.fromJson(json)).toList();
  }

  Future<void> createCrop({
    required String cropName,
    required String irrigationType,
    required int area,
    required String plantingDate,
    required int farmerId,
    String? imagePath,
  }) async {
    final fields = {
      'cropName': cropName,
      'irrigationType': irrigationType,
      'area': area.toString(),
      'plantingDate': plantingDate,
      'farmerId': farmerId.toString(),
    };

    await _apiService.postMultipart('crops', fields, imagePath);
  }
}