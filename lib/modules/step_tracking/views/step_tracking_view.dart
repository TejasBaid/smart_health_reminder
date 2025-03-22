import 'package:smart_health_reminder/modules/step_tracking/widgets/metrics_row.dart';

import '../../../core/const_imports.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/widgets/custom_navbar.dart';
import '../../../routes/routes.dart';
import '../widgets/ripple_background.dart';
import '../widgets/step_counter_card.dart';


class StepTrackingView extends StatefulWidget {
  const StepTrackingView({Key? key}) : super(key: key);

  @override
  State<StepTrackingView> createState() => _StepTrackingViewState();
}

class _StepTrackingViewState extends State<StepTrackingView> {
  int _currentIndex = 1;
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [

          Expanded(
            flex: 3,
            child: Stack(
              children: [
                const StaticRippleBackground(),
                SafeArea(
                  child: Padding(padding: EdgeInsets.symmetric(horizontal:20),
                  child: Column(
                    children: [

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Steps Tracker',
                                style: TextStyle(
                                  color: ColorConsts.whiteCl,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                    '+125 XP today',
                                    style: TextStyle(
                                      color: ColorConsts.whiteCl.withOpacity(0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Goal value
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    HugeIcons.strokeRoundedRunningShoes,
                                    color: ColorConsts.whiteCl,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    '9041',
                                    style: TextStyle(
                                      color: ColorConsts.whiteCl,
                                      fontSize: 38,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      'Unit: Steps',
                                      style: TextStyle(
                                        color: ColorConsts.whiteCl,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: ColorConsts.whiteCl,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),)
                ),
              ],
            ),
          ),

          Expanded(
            flex: 7,
            child: Container(
              color: ColorConsts.bluePrimary,
              child: Material(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: ColorConsts.whiteCl,
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Today's Progress",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: ColorConsts.blackText,
                            ),
                          ),
                          Row(
                            children:  [
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, Routes.stepHistoryList);
                                },
                                child:Text(

                                  "See all",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConsts.bluePrimary,
                                  ),

                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: ColorConsts.bluePrimary,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Subtitle
                      const Text(
                        'You are more active than usual today',
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorConsts.greySubtitle,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            MetricsRow(valueNotifier: _valueNotifier),
                            const SizedBox(height: 10),
                            // Step counter card
                            const StepTrackerCard(
                              steps: 9041,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
