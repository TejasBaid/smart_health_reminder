import 'dart:ui';
import '../../../core/const_imports.dart';

class StepTrackerCard extends StatelessWidget {
  final int steps;
  final int goalSteps;
  final int xpGained;

  const StepTrackerCard({
    Key? key,
    required this.steps,
    this.goalSteps = 10000,
    this.xpGained = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progressPercentage = (steps / goalSteps) * 100;
    final double progressBarWidth = (steps / goalSteps).clamp(0.0, 1.0);

    return Container(
      height: 190,
      decoration: BoxDecoration(
        color: ColorConsts.tealPopAccent,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Static ripple background
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: const StaticRippleBackgroundCard(),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row with step count and icon
                Row(
                  children: [
                    // Step count with subscript goal
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Steps with subscript
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: steps.toString(),
                                style: const TextStyle(
                                  color: ColorConsts.whiteCl,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '/${goalSteps}',
                                style: TextStyle(
                                  color: ColorConsts.whiteCl.withOpacity(0.7),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  fontFeatures: [const FontFeature.subscripts()],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Steps',
                          style: TextStyle(
                            color: ColorConsts.whiteCl.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Icon
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: ColorConsts.greenAccent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.directions_walk,
                        color: ColorConsts.tealPopAccent,
                        size: 28,
                      ),
                    ),
                  ],
                ),

                // XP gained info
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: ColorConsts.greenAccent,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+${xpGained} XP gained from walking',
                      style: TextStyle(
                        color: ColorConsts.whiteCl.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Progress row
                Row(
                  children: [
                    // Progress bar
                    Expanded(
                      child: Stack(
                        children: [
                          // Background track
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: ColorConsts.whiteCl.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),

                          // Progress fill
                          FractionallySizedBox(
                            widthFactor: progressBarWidth,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ColorConsts.greenAccent,
                                    ColorConsts.greenAccent.withGreen(220),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Percentage text
                    Text(
                      '${progressPercentage.toInt()}%',
                      style: const TextStyle(
                        color: ColorConsts.whiteCl,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Text(
                  'Complete your goal to earn more rewards!',
                  style: TextStyle(
                    color: ColorConsts.whiteCl.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Static ripple effect - keep this unchanged
class StaticRippleBackgroundCard extends StatelessWidget {
  const StaticRippleBackgroundCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StaticRipplePainter(),
      size: Size.infinite,
    );
  }
}

class StaticRipplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Origin point in the top left area
    final origin = Offset(size.width * 0.2, size.height * -0.5);

    // Create multiple static ripple circles
    for (int i = 0; i < 8; i++) {
      final radius = size.width * (0.2 + i * 0.18);

      final paint = Paint()
        ..color = Colors.white.withOpacity(0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      canvas.drawCircle(origin, radius, paint);
    }
  }

  @override
  bool shouldRepaint(StaticRipplePainter oldDelegate) => false;
}
