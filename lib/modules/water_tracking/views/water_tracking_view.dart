import 'package:flutter/material.dart';
import 'package:smart_health_reminder/core/const_imports.dart';
import '../../../core/widgets/custom_navbar.dart';
import '../../../core/widgets/hydration_header.dart';
import '../../../core/widgets/water_intake_controls.dart';
import '../../../core/widgets/water_options_modal.dart';
import '../../posture_tracking/widgets/ripple_background.dart';
import '../model/water_option_model.dart';

import '../widgets/water_status_card.dart';


class WaterTrackingView extends StatefulWidget {
  const WaterTrackingView({Key? key}) : super(key: key);

  @override
  State<WaterTrackingView> createState() => _WaterTrackingViewState();
}

class _WaterTrackingViewState extends State<WaterTrackingView> {
  final ValueNotifier<double> _waterIntakeNotifier = ValueNotifier(1200);
  final double _dailyGoal = 2000;
  final List<WaterOption> _waterOptions = [
    WaterOption(amount: 100, label: '100 ml', icon: HugeIcons.strokeRoundedDroplet, color: ColorConsts.bluePrimary),
    WaterOption(amount: 250, label: '1 Glass', icon: FontAwesomeIcons.wineGlass, color: ColorConsts.bluePrimary),
    WaterOption(amount: 500, label: '1 Bottle', icon: HugeIcons.strokeRoundedMilkBottle, color: ColorConsts.bluePrimary),
    WaterOption(amount: 1000, label: '1 Liter', icon: HugeIcons.strokeRoundedWaterPump, color: ColorConsts.bluePrimary),
  ];

  String _selectedAmount = '100 ml';
  int _currentIndex = 3;

  void _handleAddWater() {
    final selectedOption = _waterOptions.firstWhere(
          (option) => option.label == _selectedAmount,
      orElse: () => _waterOptions.first,
    );
    _waterIntakeNotifier.value += selectedOption.amount.toDouble();
  }

  void _handleRemoveWater() {
    final selectedOption = _waterOptions.firstWhere(
          (option) => option.label == _selectedAmount,
      orElse: () => _waterOptions.first,
    );
    if (_waterIntakeNotifier.value >= selectedOption.amount) {
      _waterIntakeNotifier.value -= selectedOption.amount.toDouble();
    }
  }

  void _showWaterOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => WaterOptionsModal(
        options: _waterOptions,
        initialSelection: _selectedAmount,
        onSelectionChanged: (newValue) => setState(() => _selectedAmount = newValue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
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
                        HydrationHeader(waterIntakeNotifier: _waterIntakeNotifier),
                        const Spacer(),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  WaterControlButton(
                                    icon: HugeIcons.strokeRoundedMinusSign,
                                    onTap: _handleRemoveWater,
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
                                  WaterControlButton(
                                    icon: HugeIcons.strokeRoundedPlusSign,
                                    onTap: _handleAddWater,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              WaterAmountSelector(
                                selectedAmount: _selectedAmount,
                                onTap: () => _showWaterOptionsModal(context),
                                options: _waterOptions,
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
                  child: ValueListenableBuilder<double>(
                    valueListenable: _waterIntakeNotifier,
                    builder: (context, value, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Today's Hydration",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorConsts.blackText,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Status description
                        Text(

                              'You are well hydrated! Keep it Up!',
                          style: const TextStyle(
                            fontSize: 14,
                            color: ColorConsts.greySubtitle,
                          ),
                        ),
                        const SizedBox(height: 16),
                        WaterStatusCard(
                          currentIntake: value,
                          dailyGoal: _dailyGoal,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _waterIntakeNotifier.dispose();
    super.dispose();
  }
}
