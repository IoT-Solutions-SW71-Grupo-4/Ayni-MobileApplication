import '../../shared/api/base_service.dart';
import '../models/farmer_model.dart';

class FarmerService {
  final BaseService _apiService = BaseService();

  Future<Farmer> getFarmerById(int id) async {
    final response = await _apiService.get('farmers/$id');
    return Farmer.fromJson(response);
  }
}

