import 'package:ayni_mobile_app/home/models/crop.dart';
import 'package:ayni_mobile_app/home/services/weather_api_service.dart';
import 'package:ayni_mobile_app/home/widgets/crops_list_widget.dart';
import 'package:ayni_mobile_app/home/widgets/weather_widget.dart';
import 'package:ayni_mobile_app/profile/models/farmer_model.dart';
import 'package:ayni_mobile_app/profile/services/farmer_service.dart';
import 'package:ayni_mobile_app/shared/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final WeatherApiService _weatherApiService = WeatherApiService();
  final FarmerService _farmerService = FarmerService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? token;

  Future<dynamic> getData() async {
    // Recupera el token almacenado
    final token = await _storage.read(key: 'token');
    // Recupera el ID del Farmer almacenado
    final farmerId = await _storage.read(key: 'id');

    if (token == null || farmerId == null) {
      throw Exception("Token or Farmer ID is missing. Please log in again.");
    }

    // Solicita los datos del Farmer usando el ID y el token
    final farmer = await _farmerService.getFarmerById(int.parse(farmerId)); // ID dinámico
    final weatherData = await _weatherApiService.getWeather();
    final cropsData = await fetchCrops();

    return [farmer, weatherData, cropsData];
  }


  Future<List<Crop>> fetchCrops() async {
    // Simula una llamada a la API de cultivos
    final response = await Future.delayed(const Duration(seconds: 1), () {
      return [
        {"id": 1, "name": "Wheat"},
        {"id": 2, "name": "Corn"},
      ];
    });

    return response.map<Crop>((json) => Crop.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data found.'));
            }

            // Obtiene los datos recuperados
            final farmer = snapshot.data![0] as Farmer;
            final weather = snapshot.data![1];
            final crops = snapshot.data![2] as List<Crop>;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD9D9D9),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.settings,
                              color: colors["color-50-black"],
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          height: 48,
                          width: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD9D9D9),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.person,
                              color: colors["color-50-black"],
                            ),
                            onPressed: () async {
                              final farmerId = await _storage.read(key: 'id');

                              if (farmerId != null) {
                                context.goNamed(
                                  "profile_view",
                                  pathParameters: {"id": farmerId},
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Error: Farmer ID is missing.')),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Welcome, ${farmer.username}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: colors["color-black"],
                    ),
                  ),
                  const SizedBox(height: 24),
                  WeatherWidget(
                    weatherDescription: weather,
                  ),
                  const SizedBox(height: 24),
                  CropsListWidget(cropsList: crops),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
