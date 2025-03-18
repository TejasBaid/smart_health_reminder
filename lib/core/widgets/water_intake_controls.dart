import '../../modules/water_tracking/model/water_option_model.dart';
import '../const_imports.dart';

class WaterIntakeControls extends StatelessWidget {
  final ValueNotifier<double> waterIntakeNotifier;
  final String selectedAmount;
  final VoidCallback onShowModal;
  final VoidCallback onAddWater;
  final VoidCallback onRemoveWater;

  const WaterIntakeControls({
    super.key,
    required this.waterIntakeNotifier,
    required this.selectedAmount,
    required this.onShowModal,
    required this.onAddWater,
    required this.onRemoveWater,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WaterControlButton(
                icon: HugeIcons.strokeRoundedMinusSign,
                onTap: onRemoveWater,
              ),
              const SizedBox(width: 16),
              ValueListenableBuilder<double>(
                valueListenable: waterIntakeNotifier,
                builder: (context, value, _) => Text(
                  '${value.toInt()} ml',
                  style: const TextStyle(
                    color: ColorConsts.whiteCl,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              WaterControlButton(
                icon: HugeIcons.strokeRoundedPlusSign,
                onTap: onAddWater,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WaterControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const WaterControlButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorConsts.whiteCl.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, color: ColorConsts.whiteCl, size: 20),
      ),
    );
  }
}

class WaterAmountSelector extends StatelessWidget {
  final String selectedAmount;
  final VoidCallback onTap;
  final List<WaterOption> options;

  const WaterAmountSelector({
    super.key,
    required this.selectedAmount,
    required this.onTap,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: ColorConsts.whiteCl.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getSelectedIcon(),
              color: ColorConsts.whiteCl,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              selectedAmount,
              style: const TextStyle(
                color: ColorConsts.whiteCl,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.keyboard_arrow_down,
              color: ColorConsts.whiteCl,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getSelectedIcon() {
    final option = options.firstWhere(
          (o) => o.label == selectedAmount,
      orElse: () => options.first,
    );
    return option.icon;
  }
}


