// water_tracking_view.dart
import 'package:flutter/material.dart';
import 'package:smart_health_reminder/core/const_imports.dart';
import '../../../core/widgets/custom_navbar.dart';
import '../../posture_tracking/widgets/ripple_background.dart';
import '../widgets/water_status_card.dart';
import '../widgets/weekly_hydration_chart.dart';

class WaterTrackingView extends StatefulWidget {
  const WaterTrackingView({Key? key}) : super(key: key);

  @override
  _WaterTrackingViewState createState() => _WaterTrackingViewState();
}

class _WaterTrackingViewState extends State<WaterTrackingView> {
  int _currentIndex = 3;

  final ValueNotifier<double> _waterIntakeNotifier = ValueNotifier(1200);
  final double _dailyGoal = 2000; // Default goal in ml
  final List<DateTime> _intakeTimes = [];

  String _selectedAmount = '100 ml';


  final List<WaterOption> _waterOptions = [
    WaterOption(amount: 100, label: '100 ml', icon: HugeIcons.strokeRoundedDroplet, color: ColorConsts.bluePrimary),
    WaterOption(amount: 250, label: '1 Glass', icon: FontAwesomeIcons.wineGlass, color: ColorConsts.bluePrimary),
    WaterOption(amount: 500, label: '1 Bottle', icon: HugeIcons.strokeRoundedMilkBottle, color: ColorConsts.bluePrimary),
    WaterOption(amount: 1000, label: '1 Liter', icon: HugeIcons.strokeRoundedWaterPump, color: ColorConsts.bluePrimary),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                const StaticRippleBackground(),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // Keep your existing header
                        Row(
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
                                    Icon(
                                      Icons.opacity,
                                      color: ColorConsts.greenAccent,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    ValueListenableBuilder<double>(
                                      valueListenable: _waterIntakeNotifier,
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
                        ),
                        const Spacer(),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildWaterControlButton(
                                    icon: HugeIcons.strokeRoundedMinusSign,
                                    onTap: () {
                                      final selectedOption = _getSelectedOption();
                                      if (_waterIntakeNotifier.value >= selectedOption.amount) {
                                        _waterIntakeNotifier.value -= selectedOption.amount;
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  ValueListenableBuilder<double>(
                                    valueListenable: _waterIntakeNotifier,
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
                                  _buildWaterControlButton(
                                    icon: HugeIcons.strokeRoundedPlusSign,
                                    onTap: () {
                                      final selectedOption = _getSelectedOption();
                                      _addWater(selectedOption.amount.toDouble());
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              GestureDetector(
                                onTap: () => _showWaterOptionsModal(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),

                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        _getSelectedOption().icon,
                                        color: ColorConsts.whiteCl,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _selectedAmount,
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
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              color: ColorConsts.bluePrimary,
              child: Material(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Hydration",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      WaterStatusCard(
                        currentIntake: _waterIntakeNotifier.value,
                        dailyGoal: _dailyGoal,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterControlButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15),

        ),
        child: Icon(
          icon,
          color: ColorConsts.whiteCl,
          size: 20,
        ),
      ),
    );
  }

  WaterOption _getSelectedOption() {
    return _waterOptions.firstWhere(
          (option) => option.label == _selectedAmount,
      orElse: () => _waterOptions.first,
    );
  }



  void _showWaterOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle indicator at top
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                // Header
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Select Water Amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Options list
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: _waterOptions.length,
                    itemBuilder: (context, index) {
                      final option = _waterOptions[index];
                      final isSelected = _selectedAmount == option.label;

                      return Container(
                        margin: EdgeInsets.only(
                          bottom: index < _waterOptions.length - 1 ? 6 : 0,
                          left: 4,
                          right: 4,
                        ),
                        child: InkWell(
                          onTap: () {
                            setModalState(() {
                              _selectedAmount = option.label;
                            });
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                            decoration: BoxDecoration(
                              color: isSelected ? ColorConsts.tealPopAccent : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: isSelected ? [
                                BoxShadow(
                                  color: ColorConsts.tealPopAccent.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ] : null,
                              border: Border.all(
                                color: isSelected ? ColorConsts.tealPopAccent : Colors.grey.shade200,
                                width: 1.0,
                              ),
                            ),
                            child: Stack(
                              children: [
                                if (isSelected)
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: const StaticRippleBackgroundCard(),
                                    ),
                                  ),
                                Row(
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? ColorConsts.greenAccent
                                            : option.color.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          option.icon,
                                          color: isSelected
                                              ? ColorConsts.tealPopAccent
                                              : option.color,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            option.label,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: isSelected ? Colors.white : Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            '${option.amount} milliliters',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isSelected
                                                  ? Colors.white.withOpacity(0.8)
                                                  : Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isSelected)
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: ColorConsts.greenAccent,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: ColorConsts.tealPopAccent,
                                          size: 14,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConsts.tealPopAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }



  void _addWater(double amount) {
    _waterIntakeNotifier.value += amount;
    _intakeTimes.add(DateTime.now());
  }
}

class WaterOption {
  final int amount;
  final String label;
  final IconData icon;
  final Color color;

  WaterOption({
    required this.amount,
    required this.label,
    required this.icon,
    required this.color,
  });
}



