import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/const_imports.dart';
import '../widgets/step_history_list.dart';

class StepsHistoryView extends StatefulWidget {
  const StepsHistoryView({Key? key}) : super(key: key);

  @override
  State<StepsHistoryView> createState() => _StepsHistoryViewState();
}

class _StepsHistoryViewState extends State<StepsHistoryView> {
  String selectedPeriod = '(112)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F8F3), // Light green background
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorConsts.greyOpacity02,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.arrow_back, size: 18),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Steps History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Filter selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [Text("All History", style: TextStyle(color: ColorConsts.blackText, fontWeight: FontWeight.bold),),
                      SizedBox(width: 10),
                      Text(
                        selectedPeriod,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(HugeIcons.strokeRoundedCalendar02, size: 15,),
                        SizedBox(width: 10,),
                        Text(
                          'January 2026',
                          style: TextStyle(
                            color: ColorConsts.blackText,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: ColorConsts.blackText,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Step History List
            Expanded(
                child: StepHistoryList(
                  items: [
                    StepHistoryItem(
                      date: 'Jan 23, 2025',
                      time: '10:22 AM',
                      steps: 858,
                      intensity: StepIntensity.normal,
                      progressValues: [75, 0, 0],
                    ),
                    StepHistoryItem(
                      date: 'Jan 22, 2025',
                      time: '11:22 AM',
                      steps: 3211,
                      intensity: StepIntensity.intense,
                      progressValues: [100, 85, 65],
                    ),
                    StepHistoryItem(
                      date: 'Jan 21, 2025',
                      time: '12:22 AM',
                      steps: 2158,
                      intensity: StepIntensity.hard,
                      progressValues: [90, 60, 0],
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
