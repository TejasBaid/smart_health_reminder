import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_health_reminder/modules/posture_tracking/widgets/posture_graph.dart';
import '../../../core/const_imports.dart';
import '../../../core/widgets/custom_navbar.dart';
import '../../../services/posture_detection_service.dart';
import '../../step_tracking/widgets/ripple_background.dart';
import '../widgets/posture_status_card.dart';

class PostureTrackingView extends StatefulWidget {
  const PostureTrackingView({Key? key}) : super(key: key);

  @override
  State<PostureTrackingView> createState() => _PostureTrackingViewState();
}

class _PostureTrackingViewState extends State<PostureTrackingView> {
  int _currentIndex = 2;
  final ValueNotifier<double> _postureQualityNotifier = ValueNotifier(82);
  bool _isGoodPosture = true;
  int _goodPostureMinutes = 342;
  int _badPostureMinutes = 78;

  Color _backgroundColor = const Color(0xFF30BFC7);

  late PostureDetectionService _postureService;

  @override
  void initState() {
    super.initState();

    _postureService = PostureDetectionService();
    _postureService.startDetection();

    _postureService.postureStatus.listen((isGood) {
      setState(() {
        _isGoodPosture = isGood;
      });
    });

    _postureService.postureQuality.listen((quality) {
      _postureQualityNotifier.value = quality;

      final metrics = _postureService.getPostureMetrics();
      setState(() {
        _goodPostureMinutes = metrics['goodPostureMinutes'];
        _badPostureMinutes = metrics['badPostureMinutes'];
      });
    });

    _postureService.backgroundColor.listen((color) {
      setState(() {
        _backgroundColor = color;
      });
    });
  }

  @override
  void dispose() {
    _postureService.dispose();
    super.dispose();
  }

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
                // Background with animated color
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  color: _backgroundColor,
                  child: const StaticRippleBackground(),
                ),

                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Posture Tracker',
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

                        const SizedBox(height: 12),

                        Center(
                          child: Column(
                            children: [


                              const SizedBox(height: 10),

                              Text(
                                _isGoodPosture ? 'Great Posture!' : 'Fix Your Posture',
                                style: const TextStyle(
                                  color: ColorConsts.whiteCl,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 2),

                              Text(
                                _isGoodPosture
                                    ? 'You\'re maintaining excellent form'
                                    : 'Straighten your back and adjust position',
                                style: TextStyle(
                                  color: ColorConsts.whiteCl.withOpacity(0.8),
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
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
                color: ColorConsts.whiteCl,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                clipBehavior: Clip.antiAlias,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: const [
                                Text(
                                  "See All",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: ColorConsts.greenAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16,
                                  color: ColorConsts.greenAccent,
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Text(
                          _isGoodPosture
                              ? 'Your posture is improving! Keep it up.'
                              : 'You had some posture issues today.',
                          style: const TextStyle(
                            fontSize: 14,
                            color: ColorConsts.greySubtitle,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Posture quality card
                        ValueListenableBuilder<double>(
                          valueListenable: _postureQualityNotifier,
                          builder: (context, quality, child) {
                            return PostureStatusCard(
                              isGoodPosture: _isGoodPosture,
                              quality: quality,
                              duration: _goodPostureMinutes,
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        PostureBarGraph(),

                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: ColorConsts.greenAccent.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Posture Tips',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: ColorConsts.greenAccent.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.lightbulb_outline,
                                      color: ColorConsts.greenAccent,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Text(
                                      'Keep your shoulders back and spine straight when sitting',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: ColorConsts.greenAccent.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.timer_outlined,
                                      color: ColorConsts.greenAccent,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Text(
                                      'Take a 5-minute break every 25 minutes to stretch',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 100,)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ),
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
