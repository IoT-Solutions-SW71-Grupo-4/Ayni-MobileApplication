import 'package:ayni_mobile_app/home/widgets/crops_list_widget.dart';
import 'package:ayni_mobile_app/home/widgets/weather_widget.dart';
import 'package:ayni_mobile_app/shared/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      decoration: BoxDecoration(
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
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.person,
                          color: colors["color-50-black"],
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Text(
                  "Welcome, Aaron",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: colors["color-black"],
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              WeatherWidget(),
              SizedBox(
                height: 24,
              ),
              CropsListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
