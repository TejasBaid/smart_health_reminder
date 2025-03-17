import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:hugeicons/hugeicons.dart';


class StepTrackingView extends StatelessWidget {
  const StepTrackingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          // Top blue section with ripple background
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                // Ripple background
                const StaticRippleBackground(),

                // Content
                SafeArea(
                  child: Column(
                    children: [
                      // Back button and title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [

                            const SizedBox(width: 16),
                            const Text(
                              'Water Intake',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Goal value
                              const Text(
                                '200',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 72,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Unit selector
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      'Unit: ml',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom white section with templates
          Expanded(
            flex: 6,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Template goal header
                    const Text(
                      'Template Goal',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Subtitle
                    const Text(
                      'We prepared a lot of goals for you!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Search field
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.search,
                            color: Colors.blue,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Search Template',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Template grid
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 1.4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          TemplateCard(
                            title: 'Summer time',
                            amount: '2000ml',
                            icon: '🌴',
                          ),
                          TemplateCard(
                            title: 'Sporty',
                            amount: '2500ml',
                            icon: '🏀',
                          ),
                          TemplateCard(
                            title: 'Snow day',
                            amount: '2200ml',
                            icon: '❄️',
                          ),
                          TemplateCard(
                            title: 'Child',
                            amount: '1500ml',
                            icon: '🌈',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
    // bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   _currentIndex = index;
        // });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xff7199AA),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}

class TemplateCard extends StatelessWidget {
  final String title;
  final String amount;
  final String icon;

  const TemplateCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                icon,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }
}

class StaticRippleBackground extends StatelessWidget {
  const StaticRippleBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF30BFC7), // Teal color matching your image
      child: CustomPaint(
        painter: StaticRipplePainter(),
        size: Size.infinite,
      ),
    );
  }
}

class StaticRipplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Origin point in the top left area (slightly off-screen)
    final origin = Offset(size.width * 0.2, size.height * 0.2);

    // Create multiple static ripple circles
    for (int i = 0; i < 8; i++) {
      final radius = size.width * (0.001 + i * 0.14);

      final paint = Paint()
        ..color = Colors.white.withOpacity(0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      canvas.drawCircle(origin, radius, paint);
    }
  }

  @override
  bool shouldRepaint(StaticRipplePainter oldDelegate) => false; // Static, no need to repaint
}
