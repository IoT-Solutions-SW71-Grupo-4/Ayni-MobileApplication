import 'package:ayni_mobile_app/shared/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../models/farmer_model.dart';
import '../services/farmer_service.dart';
import '../../shared/widgets/errors/error_message.dart';
import '../../shared/widgets/errors/loader.dart';

class FarmerScreen extends StatefulWidget {
  final int farmerId;

  const FarmerScreen({required this.farmerId});

  @override
  State<FarmerScreen> createState() => _FarmerScreenState();
}

class _FarmerScreenState extends State<FarmerScreen> {
  final FarmerService _farmerService = FarmerService();
  late Future<Farmer> _farmerFuture;

  @override
  void initState() {
    super.initState();
    _farmerFuture = _farmerService.getFarmerById(widget.farmerId);
  }

  Future<void> _pickAndUploadImage(Farmer farmer) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        // Llama al servicio para subir la imagen
        await _farmerService.updateProfilePicture(farmer.id, pickedFile.path);

        // Mostrar confirmación al usuario
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile picture updated successfully!')),
        );

        // Refresca la vista para cargar la nueva imagen
        setState(() {
          _farmerFuture = _farmerService.getFarmerById(farmer.id);
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile picture: $error')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colors["color-light-green"],
          toolbarHeight: 70,
          title: Text(
            "Profile",
            style: TextStyle(
              color: colors["color-text-black"],
              fontSize: 22,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: colors["color-text-black"],
            ),
            onPressed: () {
              context.goNamed("home_view"); // Regresa al HomeView
            },
          ),
        ),
        body: FutureBuilder<Farmer>(
          future: _farmerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader(); // Mostrar un loader mientras se cargan los datos
            } else if (snapshot.hasError) {
              return ErrorMessage(message: snapshot.error.toString());
            } else if (snapshot.hasData) {
              final farmer = snapshot.data!;
              return _buildProfileView(farmer);
            } else {
              return const ErrorMessage(message: 'No data available');
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileView(Farmer farmer) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Imagen de perfil
                Container(
                  height: 160,
                  width: 160,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: farmer.imageUrl != null
                      ? ClipOval(
                    child: Image.network(
                      farmer.imageUrl!,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  )
                      : const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
                // Botón para subir imagen
                Positioned(
                  right: 0,
                  bottom: 10,
                  child: GestureDetector(
                    onTap: () => _pickAndUploadImage(farmer),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50), // Verde
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                // Botón para eliminar imagen
                Positioned(
                  left: 0,
                  bottom: 10,
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        await _farmerService.deleteProfilePicture(farmer.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Profile picture deleted successfully!'),
                          ),
                        );
                        setState(() {
                          _farmerFuture = _farmerService.getFarmerById(farmer.id);
                        });
                      } catch (error) {
                        String errorMessage = 'Failed to delete profile picture.';
                        if (error.toString().contains('Farmer with id')) {
                          errorMessage = 'No profile picture to delete.';
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMessage),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Colors.red, // Rojo
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              farmer.username,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              farmer.email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Farmer",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                context.goNamed("login_view"); // Cerrar sesión y navegar al login
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0XFFFFD9D9),
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(
                Icons.logout,
                color: Color(0XFFFF1B1F),
              ),
              label: const Text(
                "Logout",
                style: TextStyle(
                  color: Color(0XFFFF1B1F),
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}