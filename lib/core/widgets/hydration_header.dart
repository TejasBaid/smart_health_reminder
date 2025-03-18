import '../const_imports.dart';

class HydrationHeader extends StatelessWidget {
  final ValueNotifier<double> waterIntakeNotifier;

  const HydrationHeader({super.key, required this.waterIntakeNotifier});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Water Tracker',
              style: TextStyle(
                color: ColorConsts.whiteCl,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(Icons.opacity, color: ColorConsts.greenAccent, size: 16),
                const SizedBox(width: 4),
                ValueListenableBuilder<double>(
                  valueListenable: waterIntakeNotifier,
                  builder: (context, intake, _) => Text(
                    '+${(intake * 0.1).toInt()} XP today',
                    style: TextStyle(
                      color: ColorConsts.whiteCl.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
