import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import '../../../core/const_imports.dart';

enum StepIntensity {
  normal,
  hard,
  intense
}

class StepHistoryItem {
  final String date;
  final String time;
  final int steps;
  final StepIntensity intensity;
  final List<double> progressValues; // Values for the three progress circles (0-100)

  StepHistoryItem({
    required this.date,
    required this.time,
    required this.steps,
    required this.intensity,
    required this.progressValues,
  });
}

class StepHistoryList extends StatelessWidget {
  final List<StepHistoryItem> items;

  const StepHistoryList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemBuilder: (context, index) {
        return StepHistoryListItem(item: items[index]);
      },
    );
  }
}

class StepHistoryListItem extends StatelessWidget {
  final StepHistoryItem item;

  const StepHistoryListItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: ColorConsts.whiteCl,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.date,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: ColorConsts.blackText,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${item.steps}",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: ColorConsts.blackText,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        "steps",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                _buildIntensityIndicator(item.intensity)
              ],
            ),

            // Right side with time and metrics
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      item.time,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 16,
                      color: Colors.grey.shade400,
                    )
                  ],
                ),
                const SizedBox(height: 25),
                MetricsRow(
                  valueNotifier: _valueNotifier,
                  intensityValues: item.progressValues,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntensityIndicator(StepIntensity intensity) {
    late List<Widget> indicators;

    switch (intensity) {
      case StepIntensity.normal:
        indicators = [
          FaIcon(FontAwesomeIcons.boltLightning, color: ColorConsts.yellowAccent, size: 14),
          const SizedBox(width: 6),
          const Text(
            "Normal",
            style: TextStyle(
                color: ColorConsts.blackText,
                fontSize: 10,
                fontWeight: FontWeight.w600
            ),
          ),
        ];
        break;
      case StepIntensity.hard:
        indicators = [
          FaIcon(FontAwesomeIcons.boltLightning, color: ColorConsts.orangeCl, size: 14),
          const SizedBox(width: 2),
          FaIcon(FontAwesomeIcons.boltLightning, color: ColorConsts.orangeCl, size: 14),
          const SizedBox(width: 6),
          const Text(
            "Hard",
            style: TextStyle(
                color: ColorConsts.blackText,
                fontSize: 10,
                fontWeight: FontWeight.w600
            ),
          ),
        ];
        break;
      case StepIntensity.intense:
        indicators = [
          FaIcon(FontAwesomeIcons.boltLightning, color: ColorConsts.redAccent, size: 14),
          const SizedBox(width: 2),
          FaIcon(FontAwesomeIcons.boltLightning, color: ColorConsts.redAccent, size: 14),
          const SizedBox(width: 2),
          FaIcon(FontAwesomeIcons.boltLightning, color: ColorConsts.redAccent, size: 14),
          const SizedBox(width: 6),
          const Text(
            "Intense",
            style: TextStyle(
                color: ColorConsts.blackText,
                fontSize: 10,
                fontWeight: FontWeight.w600
            ),
          ),
        ];
        break;
    }

    return Row(children: indicators);
  }
}

class MetricsRow extends StatelessWidget {
  final ValueNotifier<double> valueNotifier;
  final List<double> intensityValues;

  const MetricsRow({
    Key? key,
    required this.valueNotifier,
    required this.intensityValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // First metric card (yellow)
        MetricCard(
          progress: intensityValues[0],
          valueNotifier: valueNotifier,
          foregroundColor: ColorConsts.greenAccent,
          icon: const FaIcon(FontAwesomeIcons.bolt, color: ColorConsts.greenAccent, size: 14,),
        ),
        const SizedBox(width: 8),
        // Second metric card (green)
        MetricCard(
          progress: intensityValues[1],
          valueNotifier: valueNotifier,
          foregroundColor: ColorConsts.orangeAccent,
          icon: const FaIcon(FontAwesomeIcons.locationDot, color: ColorConsts.orangeAccent, size: 14,),
        ),
        const SizedBox(width: 8),
        // Third metric card (blue)
        MetricCard(
          progress: intensityValues[2],
          valueNotifier: valueNotifier,
          foregroundColor: ColorConsts.redAccent,
          icon: const FaIcon(FontAwesomeIcons.heartCircleBolt, color: ColorConsts.redAccent, size: 14,),
        ),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  final double progress;
  final ValueNotifier<double> valueNotifier;
  final Widget icon;
  final Color foregroundColor;

  const MetricCard({
    Key? key,
    required this.progress,
    required this.valueNotifier,
    required this.icon,
    required this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashedCircularProgressBar.square(
      dimensions: 40,
      valueNotifier: valueNotifier,
      progress: progress,
      startAngle: 0,
      sweepAngle: 360,
      foregroundColor: foregroundColor,
      backgroundColor: ColorConsts.lightGrey,
      foregroundStrokeWidth: 6,
      backgroundStrokeWidth: 6,
      animation: true,
      seekSize: 5,
      seekColor: foregroundColor,
      child: Center(child: icon),
    );
  }
}


