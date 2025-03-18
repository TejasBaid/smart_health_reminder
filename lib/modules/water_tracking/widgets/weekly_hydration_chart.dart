import 'package:fl_chart/fl_chart.dart';

import '../../../core/const_imports.dart';
class WeeklyHydrationChart extends StatelessWidget {
  const WeeklyHydrationChart();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text(
                  ['M', 'T', 'W', 'T', 'F', 'S', 'S'][value.toInt()],
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(7, (index) => BarChartGroupData(
            x: index,
            barRods: [BarChartRodData(
              toY: [1800, 2000, 1700, 2200, 2100, 1900, 2000][index].toDouble(),
              width: 16,
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: [ColorConsts.tealPopAccent, ColorConsts.tealPopAccent.withOpacity(0.7)],
              ),
            )],
          )),
        ),
      ),
    );
  }
}
