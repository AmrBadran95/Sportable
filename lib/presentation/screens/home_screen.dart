import 'package:sportable/Services/utils/globals.dart';
import 'package:sportable/data/models/sports_types.dart';
import 'package:sportable/presentation/screens/countries_screen.dart';
import 'package:sportable/presentation/widgets/layout_with_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutWithDrawer(
        showBackArrow: false,
        child: Container(
          color: Globals.primaryBackground,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: GridView.builder(
              itemCount: sports.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final sport = sports[index];
                return InkWell(
                  onTap: () {
                    if (sport["name"] != "Football") {
                      showDialog(
                        context: context,
                        builder:
                            (context) => Dialog(
                              backgroundColor: Globals.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Center(
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.info_outline,
                                            size: 48,
                                            color: Globals.secondaryColor,
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            "Coming Soon",
                                            style: TextStyle(
                                              fontSize: Globals.title,
                                              color: Globals.darkFont,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "This sport will be available in future updates.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: Globals.subtitle,
                                              color: Globals.darkFont,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => CountriesScreen(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Globals.secondaryBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: BoxBorder.all(
                        width: 2,
                        color: Globals.primaryBackground,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          sport["image"],
                          fit: BoxFit.cover,
                          height: 100,
                        ),
                        Text(
                          sport["name"],
                          style: TextStyle(
                            color: Globals.darkFont,
                            fontSize: Globals.title,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
