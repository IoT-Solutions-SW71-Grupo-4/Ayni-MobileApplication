import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraWidget extends StatelessWidget {
  final Future<void> Function(String imagePath) onImagePicked;
  final Future<void> Function()? onImageDeleted;

  const CameraWidget({
    Key? key,
    required this.onImagePicked,
    this.onImageDeleted,
  }) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        await onImagePicked(pickedFile.path);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile picture updated successfully!')),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile picture: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _pickImage(context),
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF4CAF50),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        if (onImageDeleted != null) // Mostrar el ícono de eliminar solo si es necesario
          const SizedBox(height: 8),
        if (onImageDeleted != null)
          GestureDetector(
            onTap: () async {
              try {
                await onImageDeleted!();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile picture deleted successfully!')),
                );
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to delete profile picture: $error')),
                );
              }
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
      ],
    );
  }
}
