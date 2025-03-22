import '../../../core/const_imports.dart';

class StaticRippleBackground extends StatelessWidget {
  final Color btnCol;

  const StaticRippleBackground({
    Key? key,
    required this.btnCol

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      color: btnCol,
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
    final origin = Offset(size.width * 0.2, size.height * 0.2);

    for (int i = 0; i < 8; i++) {
      final radius = size.width * (0.001 + i * 0.14);

      final paint = Paint()
        ..color = ColorConsts.whiteCl.withOpacity(0.2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      canvas.drawCircle(origin, radius, paint);
    }
  }

  @override
  bool shouldRepaint(StaticRipplePainter oldDelegate) => false;
}