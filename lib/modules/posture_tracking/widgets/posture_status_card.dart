import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/const_imports.dart';
import '../../step_tracking/widgets/ripple_background.dart';

class PostureStatusCard extends StatelessWidget {
  final bool isGoodPosture;
  final double quality;
  final int duration;

  const PostureStatusCard({
    Key? key,
    required this.isGoodPosture,
    required this.quality,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                // Top row with status and icon
                Row(
                  children: [
                    // Status text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: quality.toInt().toString(),
                                style: const TextStyle(
                                  color: ColorConsts.whiteCl,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '/100',
                                style: TextStyle(
                                  color: ColorConsts.whiteCl.withOpacity(0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFeatures: [const FontFeature.subscripts()],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Posture Quality',
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
                        color: isGoodPosture
                            ? ColorConsts.greenAccent
                            : Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isGoodPosture
                            ? Icons.sentiment_satisfied_alt
                            : Icons.sentiment_dissatisfied,
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
                      '+${(quality / 2).toInt()} XP gained from good posture',
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
                            widthFactor: quality / 100,
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
                      '${quality.toInt()}%',
                      style: const TextStyle(
                        color: ColorConsts.whiteCl,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                Text(
                  'Duration: $duration minutes of good posture',
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

// Static ripple effect for card
class StaticRippleBackgroundCard extends StatelessWidget {
  const StaticRippleBackgroundCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StaticRipplePainterCard(),
      size: Size.infinite,
    );
  }
}

class StaticRipplePainterCard extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Origin point in the top left area
    final origin = Offset(size.width * 0.2, size.height * -0.5);

    // Create multiple static ripple circles
    for (int i = 0; i < 8; i++) {
      final radius = size.width * (0.2 + i * 0.18);

      final paint = Paint()
        ..color = ColorConsts.whiteCl.withOpacity(0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      canvas.drawCircle(origin, radius, paint);
    }
  }

  @override
  bool shouldRepaint(StaticRipplePainterCard oldDelegate) => false;
}
