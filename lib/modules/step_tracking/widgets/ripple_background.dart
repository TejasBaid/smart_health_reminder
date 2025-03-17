import '../../../core/const_imports.dart';

class StaticRippleBackground extends StatelessWidget {
  const StaticRippleBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConsts.bluePrimary, // Teal color matching your image
      child: CustomPaint(
        painter: StaticRipplePainter(),
        size: Size.infinite,
      ),
    );
  }
}

class StaticRipplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Origin point in the top left area (slightly off-screen)
    final origin = Offset(size.width * 0.2, size.height * 0.2);

    // Create multiple static ripple circles
    for (int i = 0; i < 8; i++) {
      final radius = size.width * (0.001 + i * 0.14);

      final paint = Paint()
        ..color = Colors.white.withOpacity(0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      canvas.drawCircle(origin, radius, paint);
    }
  }

  @override
  bool shouldRepaint(StaticRipplePainter oldDelegate) => false; // Static, no need to repaint
}