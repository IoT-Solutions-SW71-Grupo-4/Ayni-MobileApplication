import '../../shared/api/base_service.dart';
import '../models/farmer_model.dart';

class FarmerService {
  final BaseService _apiService = BaseService();

  Future<Farmer> getFarmerById(int id) async {
    final response = await _apiService.get('farmers/$id');
    return Farmer.fromJson(response);
  }

  Future<void> updateProfilePicture(int farmerId, String imagePath) async {
    // Usamos un PUT para el endpoint especificado
    await _apiService.uploadFile(
      'farmers/$farmerId/farmerImage', // Endpoint del backend
      'file', // Nombre del campo en el backend
      imagePath, // Ruta local del archivo
      method: 'PUT', // Usamos PUT
    );
  }

  Future<void> deleteProfilePicture(int farmerId) async {
    await _apiService.delete('farmers/$farmerId/farmerImage');
  }
}

