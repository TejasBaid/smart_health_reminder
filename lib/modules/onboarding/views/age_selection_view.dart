import 'package:flutter/material.dart';
import 'package:smart_health_reminder/modules/leaderboard/views/leaderboard_view.dart';
import 'package:smart_health_reminder/modules/posture_tracking/widgets/ripple_background.dart';
import '../../../core/const_imports.dart';
class AgeSelectionView extends StatefulWidget {
  final int initialAge;
  final Function(int) onAgeSelected;
  final VoidCallback onContinue;
  final int currentPage;
  final int totalPages;

  const AgeSelectionView({
    Key? key,
    this.initialAge = 19,
    required this.onAgeSelected,
    required this.onContinue,
    this.currentPage = 3,
    this.totalPages = 11,
  }) : super(key: key);

  @override
  State<AgeSelectionView> createState() => _AgeSelectionViewState();
}

class _AgeSelectionViewState extends State<AgeSelectionView> {
  late int selectedAge;
  late FixedExtentScrollController _scrollController;

  // Define age range - adjusted to match the image (starting from lower age)
  final int minAge = 15;
  final int maxAge = 120;

  @override
  void initState() {
    super.initState();
    selectedAge = widget.initialAge;
    _scrollController = FixedExtentScrollController(
        initialItem: selectedAge - minAge
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          const StaticRippleBackground(),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                          onPressed: () => Navigator.of(context).pop(),
                          color: Colors.black,
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                      SizedBox(width: 20,),
                      // Title
                      const Text(
                        'Assessment',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: ColorConsts.whiteCl,
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 10),

                 Center(
                  child: Text(
                    "What's your Age?",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: ColorConsts.whiteCl,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                const SizedBox(height: 40),

                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    controller: _scrollController,
                    itemExtent: 100, // Decreased for closer spacing
                    diameterRatio: 2.0, // Less curved
                    perspective: 0.002, // Subtle 3D effect
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedAge = index + minAge;
                        widget.onAgeSelected(selectedAge);
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: maxAge - minAge + 1,
                      builder: (context, index) {
                        final age = index + minAge;
                        final isSelected = age == selectedAge;

                        double opacity = 1.0;
                        int distance = (age - selectedAge).abs();
                        if (distance == 1) opacity = 0.8;
                        else if (distance == 2) opacity = 0.5;
                        else if (distance > 2) opacity = 0.3;

                        return Center(
                          child: AnimatedContainer(
                            padding: const EdgeInsets.all(5),
                            duration: const Duration(milliseconds: 150),
                            width: isSelected ? 200 : 110, // Increased width
                            height: isSelected ? 200 : 50, // Increased height
                            decoration: BoxDecoration(
                              color: isSelected ? ColorConsts.greenAccent.withOpacity(0.2) : Colors.transparent,
                              borderRadius: BorderRadius.circular(45),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected ? ColorConsts.greenAccent : Colors.transparent,
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Center(
                                child: Text(
                                  '$age',
                                  style: TextStyle(
                                    fontSize: isSelected ? 64 : 24,
                                    fontWeight: FontWeight.w800,
                                    color: isSelected ? Colors.white : Colors.white.withOpacity(opacity),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: widget.onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConsts.whiteCl,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorConsts.blackText
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          size: 18,
                        ),
                      ],
                    ),
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
