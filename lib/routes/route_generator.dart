import 'package:flutter/material.dart';
import 'package:smart_health_reminder/modules/auth/views/signin_view.dart';
import 'package:smart_health_reminder/modules/auth/views/signup_view.dart';
import 'package:smart_health_reminder/modules/dashboard/views/dashboard_view.dart';
import 'package:smart_health_reminder/modules/leaderboard/views/leaderboard_view.dart';
import 'package:smart_health_reminder/modules/onboarding/views/age_selection_view.dart';
import 'package:smart_health_reminder/modules/onboarding/views/posture_asessment_view.dart';
import 'package:smart_health_reminder/modules/posture_tracking/views/posture_tracking_view.dart';
import 'package:smart_health_reminder/modules/step_tracking/views/step_tracking_history.dart';
import 'package:smart_health_reminder/modules/step_tracking/views/step_tracking_view.dart';
import 'package:smart_health_reminder/modules/water_tracking/views/water_tracking_view.dart';
import 'package:smart_health_reminder/routes/routes.dart';

import '../modules/onboarding/views/weight_selection_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    Widget page;
    switch (settings.name) {
      case Routes.dashboard:
        page = DashboardView();
        break;
      case Routes.stepTracking:
        page = StepTrackingView();
        break;
      case Routes.postureTracking:
        page = PostureTrackingView();
        break;
      case Routes.stepHistoryList:
        page = StepsHistoryView();
        break;
      case Routes.waterTracking:
        page = WaterTrackingView();
        break;
      case Routes.leaderboard:
        page = LeaderboardView();
        break;
      case Routes.signIn:
        page = SignInView();
        break;
      case Routes.postureAsessment:
        page = PostureAssessmentView();
        break;
      case Routes.signUp:
        page = SignUpView();
        break;
      case Routes.weightSelection:
        page = WeightSelectionView(
    initialWeight: 65.0,
    onWeightSelected: (weight) {
    print('Selected weight: $weight');
    },
    onContinue: () {
    print('Continue button pressed');
    // Navigate to next screen
    },
    );
        break;
      case Routes.ageSelection:
        page =AgeSelectionView(
        onAgeSelected: (weight) {
          print('Selected weight: $weight kg');
          },
          onContinue: () {
          print('Continue button pressed');
        },
    );
        break;
      default:
        page = StepTrackingView();
        break;
    }

    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500), // Faster transition
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0.0, 0.0), // Start from right
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn, // Snappy effect
          )),
          child: child,
        );
      },
    );

  }
}
