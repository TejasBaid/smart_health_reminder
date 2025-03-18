import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/color_consts.dart';

class WaterTrackerCard extends StatelessWidget {
  final int waterIntake;
  final Function()? onAddGoal;
  final Function()? onAddWater;

  const WaterTrackerCard({
    Key? key,
    required this.waterIntake,
    this.onAddGoal,
    this.onAddWater,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Color(0xFFD9E8EE),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Wave animation in background
          _buildWaveAnimation(),

          // Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row with time and water amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_getCurrentTime()}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${waterIntake * 100}ml water (${waterIntake} Glass)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),

                    // Add water button
                    InkWell(
                      onTap: onAddWater,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorConsts.whiteCl,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.water_drop,
                          color: Color(0xFF4FACF1),
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),

                Spacer(),

                // Add goal button
                InkWell(
                  onTap: onAddGoal,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: ColorConsts.whiteCl,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Add Your Goal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Water droplet decoration on top right
          Positioned(
            top: 10,
            right: 10,
            child: Icon(
              Icons.water_drop,
              color: Colors.blue.withOpacity(0.3),
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaveAnimation() {
    // Calculate wave height starting from bottom (1.0) and decreasing as water intake increases
    // This makes the wave fill from bottom to top
    double emptySpace = 1.0 - (waterIntake * 0.08).clamp(0.0, 0.9);

    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [Color(0xFF81C7F5), Color(0xFF61B7F1)],
          [Color(0xFF4FACF1), Color(0xFF2F8ED0)],
          [Color(0xFF3D9EEA), Color(0xFF2389C8)],
        ],
        durations: [35000, 19440, 10800],
        heightPercentages: [emptySpace, emptySpace - 0.05, emptySpace - 0.02],
        gradientBegin: Alignment.bottomLeft,
        gradientEnd: Alignment.topRight,
      ),
      backgroundColor: Color(0xFFD9E8EE),
      size: Size(double.infinity, double.infinity),
      waveAmplitude: 20,
    );
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '${hour == 0 ? 12 : hour}:00 $period';
  }
}
