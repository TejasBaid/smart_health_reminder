import '../../../core/const_imports.dart' ;
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';


class MetricsRow extends StatelessWidget {
  final ValueNotifier<double> valueNotifier;

  const MetricsRow({Key? key, required this.valueNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // First metric card: Calories (kcal)
        MetricCard(
          progress: 70,
          valueNotifier: valueNotifier,
          foregroundColor: ColorConsts.greenAccent,
          icon: const FaIcon(FontAwesomeIcons.bolt, color: ColorConsts.greenAccent),
          valueText: "715+",
          unit: "kcal",
        ),
        // Second metric card: Distance (km)
        MetricCard(
          progress: 28,
          valueNotifier: valueNotifier,
          foregroundColor: ColorConsts.orangeAccent,
          icon: FaIcon(FontAwesomeIcons.locationDot, color: ColorConsts.orangeAccent),
          valueText: "1.2",
          unit: "km",
        ),
        // Third metric card: Heart rate (avg bpm)
        MetricCard(
          progress: ((121 / 150) * 100),
          valueNotifier: valueNotifier,
          foregroundColor: ColorConsts.redAccent,
          icon: FaIcon(FontAwesomeIcons.heartCircleBolt, color: ColorConsts.redAccent),
          valueText: "121",
          unit: "avg bpm",
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
  final String valueText;
  final String unit;

  const MetricCard({
    Key? key,
    required this.progress,
    required this.valueNotifier,
    required this.icon,
    required this.foregroundColor,
    required this.valueText,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DashedCircularProgressBar.square(
          dimensions: 80,
          valueNotifier: valueNotifier,
          progress: progress,
          startAngle: 0,
          sweepAngle: 360,
          foregroundColor: foregroundColor,
          backgroundColor: ColorConsts.lightGrey,
          foregroundStrokeWidth: 10,
          backgroundStrokeWidth: 10,
          animation: true,
          seekSize: 5,
          seekColor: foregroundColor,
          child: Center(child: icon),
        ),
        const SizedBox(height: 5),
        Text(
          valueText,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        Text(unit),
      ],
    );
  }
}
