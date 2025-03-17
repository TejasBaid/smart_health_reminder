import '../../routes/routes.dart';
import '../const_imports.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 1),
      decoration: BoxDecoration(
        color: const Color(0xffEEF2F3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavBarItem(HugeIcons.strokeRoundedHome01, 0, context),
          _buildNavBarItem(HugeIcons.strokeRoundedRunningShoes, 1, context),
          _buildNavBarItem(HugeIcons.strokeRoundedWorkoutSquats, 2, context),
          _buildNavBarItem(HugeIcons.strokeRoundedDroplet, 3, context),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, int index, BuildContext context) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        onTap(index);
        if (index == 1) {
          Navigator.pushNamed(context, Routes.stepTracking);
        } else if (index == 2) {
          Navigator.pushNamed(context, Routes.postureTracking);
        }
        // Uncomment and modify for additional navigation:
        // else if (index == 3) {
        //   Navigator.pushNamed(context, Routes.waterTracking);
        // }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff7199AA) : Color(0xffCADCE4),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
          size: 25,
        ),
      ),
    );
  }
}
