import 'package:flutter/material.dart';

class PostureAssessmentView extends StatefulWidget {
  const PostureAssessmentView({Key? key}) : super(key: key);

  @override
  _PostureAssessmentViewState createState() => _PostureAssessmentViewState();
}

class _PostureAssessmentViewState extends State<PostureAssessmentView> {
  // Slider value (for demonstration, let's keep it from 0 - 4)
  double _backPainFrequency = 2;

  // Helper function to return a textual description based on the slider value
  String _frequencyLabel(double value) {
    switch (value.toInt()) {
      case 0:
        return 'Never';
      case 1:
        return 'Rarely';
      case 2:
        return 'Sometimes';
      case 3:
        return 'Often';
      case 4:
        return 'Very Often';
      default:
        return 'Sometimes';
    }
  }

  @override
  Widget build(BuildContext context) {
    // You can adjust these theme colors to match your design
    final Color primaryColor = Colors.green.shade400;
    final Color backgroundColor = Colors.grey.shade100;

    return Scaffold(
      backgroundColor: backgroundColor,
      // Top bar with "Assessment" and step count
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Assessment',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          // Use a column to structure the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step indicator (6 of 11)
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: Text(
                  '6 of 11',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),

              // Main Title
              const Text(
                'How Frequently Do You Experience Back Pain?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // Subheading / prompt
              const Text(
                'Use the slider below to indicate how often you feel back pain.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),

              const SizedBox(height: 24),

              // Illustrative Row (replace with your own images or icons)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Example icon: Kettlebell or some posture/bone icon
                  Icon(Icons.fitness_center, size: 40, color: Colors.grey),
                  // Example icon: Treadmill or back-related icon
                  Icon(Icons.run_circle, size: 60, color: Colors.grey),
                  // Example icon: Dumbbell or posture icon
                  Icon(Icons.sports_gymnastics, size: 40, color: Colors.grey),
                ],
              ),

              const SizedBox(height: 32),

              // The slider
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: primaryColor,
                  inactiveTrackColor: primaryColor.withOpacity(0.3),
                  thumbColor: primaryColor,
                  overlayColor: primaryColor.withOpacity(0.2),
                  valueIndicatorColor: primaryColor,
                ),
                child: Slider(
                  value: _backPainFrequency,
                  min: 0,
                  max: 4,
                  divisions: 4,
                  label: _frequencyLabel(_backPainFrequency),
                  onChanged: (value) {
                    setState(() {
                      _backPainFrequency = value;
                    });
                  },
                ),
              ),

              // Display the current frequency in a nice label
              Center(
                child: Text(
                  _frequencyLabel(_backPainFrequency),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Spacer to push button to bottom
              const Spacer(),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    // TODO: Handle navigation to the next step
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
