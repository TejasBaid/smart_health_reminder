import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/const_imports.dart';

class PostureBarGraph extends StatelessWidget {
  const PostureBarGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Posture Quality',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text(
                      'This Week',
                      style: TextStyle(
                        color: ColorConsts.tealPopAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: ColorConsts.tealPopAccent,
                      size: 18,
                    )
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Text(
                '80.1%',
                style: TextStyle(
                  color: ColorConsts.tealPopAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),

          Text(
            'Weekly Average',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 20),

          // The bar chart
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(

                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String weekDay = _getWeekdayName(group.x.toDouble());
                      return BarTooltipItem(
                        '$weekDay\n${rod.toY.round().toDouble()}%',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          meta:meta,
                          child: Text(
                            _getWeekdayShort(value),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.shade200,
                    strokeWidth: 1,
                  ),
                ),
                barGroups: _getBarGroups(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    // Sample data for the week
    final List<double> barValues = [75, 82, 67, 93, 85, 71, 88];

    return List.generate(7, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: barValues[index],
            width: 16,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            gradient: LinearGradient(
              colors: [
                ColorConsts.tealPopAccent,
                ColorConsts.tealPopAccent.withOpacity(0.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 100,
              color: Colors.grey.shade100,
            ),
          ),
        ],
      );
    });
  }

  String _getWeekdayName(double value) {
    switch (value.toInt()) {
      case 0: return 'Monday';
      case 1: return 'Tuesday';
      case 2: return 'Wednesday';
      case 3: return 'Thursday';
      case 4: return 'Friday';
      case 5: return 'Saturday';
      case 6: return 'Sunday';
      default: return '';
    }
  }

  String _getWeekdayShort(double value) {
    switch (value.toInt()) {
      case 0: return 'M';
      case 1: return 'T';
      case 2: return 'W';
      case 3: return 'T';
      case 4: return 'F';
      case 5: return 'S';
      case 6: return 'S';
      default: return '';
    }
  }
}
