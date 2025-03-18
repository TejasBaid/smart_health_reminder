import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_health_reminder/core/color_consts.dart';
import 'package:smart_health_reminder/modules/dashboard/widgets/water_tracker_card.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _steps = 0;
  int _waterIntake = 0; // In glasses
  String _mood = "Happy";
  final Color mainBlue = Color(0xFFD9E8EE);
  int _currentIndex = 0;


  @override
  void initState() {
    super.initState();
  }


  void _showWaterGoalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set Water Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('How many glasses of water would you like to drink today?'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    setState(() {
                      if (_waterIntake > 0) _waterIntake--;
                    });
                    Navigator.pop(context);
                  },
                ),
                Text(
                  '$_waterIntake',
                  style: TextStyle(fontSize: 24),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    setState(() {
                      _waterIntake++;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('Save'),
            onPressed: () {
              // Save logic here if needed
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: ColorConsts.whiteCl,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorConsts.whiteCl,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black.withValues(alpha: 0.1)
                          )
                        ),
                        child: Icon(HugeIcons.strokeRoundedMenu02, color: Colors.black),

                      ),
                      Text(
                        'Med Plus',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: ColorConsts.whiteCl,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.black.withValues(alpha: 0.1)
                            )
                        ),
                        child: Icon(HugeIcons.strokeRoundedMessageNotification01, color: Colors.black),

                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                // Water Tracker Card
                WaterTrackerCard(
                  waterIntake: _waterIntake,
                  onAddGoal: () {
                    // Show dialog to set water goal
                    _showWaterGoalDialog();
                  },
                ),

                SizedBox(height: 16),
                Text(
                  'Measurement Tracker',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),


              ],
            ),
          ),
        ),
      ),
      floatingActionButton:Container(
              // Adjust width or margin to your liking
              margin: const EdgeInsets.symmetric(horizontal:60),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 1),
              decoration: BoxDecoration(
                // Semi-transparent background
                color: Color(0xffEEF2F3),
                borderRadius: BorderRadius.circular(50),

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavBarItem(HugeIcons.strokeRoundedHome01, 0),
                  _buildNavBarItem(HugeIcons.strokeRoundedMedicine02, 1),
                  _buildNavBarItem(HugeIcons.strokeRoundedChartBarLine, 2),
                  _buildNavBarItem(HugeIcons.strokeRoundedUser, 3),
                ],
              ),
            ),


    );
  }


  Widget _buildNavBarItem(IconData icon, int index) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff7199AA) : Color(0xffCADCE4),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? ColorConsts.whiteCl : Colors.black.withValues(alpha: 0.7),
          size: 25,
        ),
      ),
    );
  }
}
