import '../../../core/const_imports.dart';

class WaterStatusCard extends StatelessWidget {
  final double currentIntake;
  final double dailyGoal;
  final int xpGained;

  const WaterStatusCard({
    required this.currentIntake,
    required this.dailyGoal,
    this.xpGained = 20,
  });

  @override
  Widget build(BuildContext context) {
    final double progressPercentage = (currentIntake / dailyGoal) * 100;
    final double progressBarWidth = (currentIntake / dailyGoal).clamp(0.0, 1.0);
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
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: currentIntake.toString(),
                                style: const TextStyle(
                                  color: ColorConsts.whiteCl,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '/${dailyGoal}',
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
                          'ml water',
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
                        Icons.water_drop_outlined,
                        color: ColorConsts.tealPopAccent,
                        size: 28,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: ColorConsts.greenAccent,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+${xpGained} XP gained from drinking water',
                      style: TextStyle(
                        color: ColorConsts.whiteCl.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: ColorConsts.whiteCl.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),

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