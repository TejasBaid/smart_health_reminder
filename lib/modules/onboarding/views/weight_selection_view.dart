import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:smart_health_reminder/core/const_imports.dart';

class WeightSelectionView extends StatefulWidget {
  final double initialWeight;
  final Function(double) onWeightSelected;
  final VoidCallback onContinue;
  final int currentPage;
  final int totalPages;

  const WeightSelectionView({
    Key? key,
    this.initialWeight = 65.0,
    required this.onWeightSelected,
    required this.onContinue,
    this.currentPage = 2,
    this.totalPages = 2,
  }) : super(key: key);

  @override
  State<WeightSelectionView> createState() => _WeightSelectionViewState();
}

class _WeightSelectionViewState extends State<WeightSelectionView> {
  late double selectedWeight;
  late ScrollController _scrollController;
  String selectedUnit = 'kg';

  // Define weight range
  final double minWeight = 40.0;
  final double maxWeight = 120.0;
  final double _itemWidth = 17.0; // Width for each kg unit

  @override
  void initState() {
    super.initState();
    selectedWeight = widget.initialWeight;

    final initialScrollOffset = (selectedWeight - minWeight) * _itemWidth;
    _scrollController = ScrollController(initialScrollOffset: initialScrollOffset);

    _scrollController.addListener(_updateSelectedWeight);
  }

  void _updateSelectedWeight() {
    if (!_scrollController.hasClients) return;

    final currentOffset = _scrollController.offset;
    final newWeight = minWeight + (currentOffset / _itemWidth);

    final roundedWeight = (newWeight * 2).round() / 2;
    final clampedWeight = math.max(minWeight, math.min(maxWeight, roundedWeight));

    if (clampedWeight != selectedWeight) {
      setState(() {
        selectedWeight = clampedWeight;
        widget.onWeightSelected(selectedWeight);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateSelectedWeight);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorConsts.tealPopAccent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                      onPressed: () => Navigator.of(context).pop(),
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                    ),
                  ),

                  const Text(
                    'Assessment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '${widget.currentPage} of ${widget.totalPages}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "What's your current weight right now?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedUnit = 'kg';
                      });
                    },
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selectedUnit == 'kg' ? Colors.white : Colors.white.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'kg',
                          style: TextStyle(
                            color: selectedUnit == 'kg' ?  ColorConsts.tealPopAccent : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedUnit = 'lbs';
                      });
                    },
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selectedUnit == 'lbs' ? Colors.white : Colors.white.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'lbs',
                          style: TextStyle(
                            color: selectedUnit == 'lbs' ? ColorConsts.tealPopAccent : Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(
                    '${selectedWeight.toInt()}',
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    ' ${selectedUnit}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: ColorConsts.whiteCl.withOpacity(0.7),
                    ),
                  ),
                ],
              )
            ),


            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification) {
                        final targetOffset = (selectedWeight.round() - minWeight) * _itemWidth;
                        _scrollController.animateTo(
                          targetOffset,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                        );
                      }
                      return true;
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        width: (maxWeight - minWeight) * _itemWidth + screenWidth,
                        height: 250,
                        padding: EdgeInsets.symmetric(horizontal: screenWidth / 2),
                        child: CustomPaint(
                          painter: WeightScalePainter(
                            min: minWeight.toInt(),
                            max: maxWeight.toInt(),
                            itemWidth:_itemWidth,
                          ),
                          size: Size((maxWeight - minWeight) * _itemWidth, 100),
                        ),
                      ),
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(

                          border: Border.all(color: Colors.white.withOpacity(0.4)),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 10,
                          decoration: BoxDecoration(
                            color: Colors.white,

                            border: Border.all(color: Colors.white.withOpacity(0.4)),
                          ),
                          height: 150,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: widget.onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor:  ColorConsts.tealPopAccent,
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
                        color: ColorConsts.tealPopAccent,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      size: 18,
                      color: ColorConsts.tealPopAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class WeightScalePainter extends CustomPainter {
  final int min;
  final int max;
  final double itemWidth;

  WeightScalePainter({
    required this.min,
    required this.max,
    required this.itemWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint majorTickPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..strokeWidth = 2.0;

    final Paint minorTickPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..strokeWidth = 1.5;

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

 
    for (int i = min; i <= max; i++) {
      double x = (i - min) * itemWidth;

      if (i % 5 == 0) {
        
        canvas.drawLine(
          Offset(x, size.height / 2 - 30),
          Offset(x, size.height / 2 + 30),
          majorTickPaint,
        );


        textPainter.text = TextSpan(
          text: '$i',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: i % 5 == 0 ? 14 : 14,
            fontWeight: FontWeight.bold,
          ),
        );

        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(x - textPainter.width / 2, size.height / 2 + 40),
        );
      } else {
        canvas.drawLine(
          Offset(x, size.height / 2 - 20),
          Offset(x, size.height / 2 + 20),
          minorTickPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}




