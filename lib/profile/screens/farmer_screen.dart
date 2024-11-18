import 'package:flutter/material.dart';
import '../../shared/widgets/errors/error_message.dart';
import '../../shared/widgets/errors/loader.dart';
import '../models/farmer_model.dart';
import '../services/farmer_service.dart';


class FarmerScreen extends StatefulWidget {
  final int farmerId;

  const FarmerScreen({required this.farmerId});

  @override
  _FarmerScreenState createState() => _FarmerScreenState();
}

class _FarmerScreenState extends State<FarmerScreen> {
  final FarmerService _farmerService = FarmerService();
  late Future<Farmer> _farmerFuture;

  @override
  void initState() {
    super.initState();
    _farmerFuture = _farmerService.getFarmerById(widget.farmerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Farmer Profile')),
      body: FutureBuilder<Farmer>(
        future: _farmerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          } else if (snapshot.hasError) {
            return ErrorMessage(message: snapshot.error.toString());
          } else if (snapshot.hasData) {
            final farmer = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${farmer.id}', style: TextStyle(fontSize: 18)),
                  Text('Username: ${farmer.username}', style: TextStyle(fontSize: 18)),
                  Text('Email: ${farmer.email}', style: TextStyle(fontSize: 18)),
                  Text('Phone: ${farmer.phoneNumber}', style: TextStyle(fontSize: 18)),
                  farmer.imageUrl != null
                      ? Image.network(farmer.imageUrl!)
                      : Text('No Image', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          } else {
            return ErrorMessage(message: 'No data available');
          }
        },
      ),
    );
  }
}
