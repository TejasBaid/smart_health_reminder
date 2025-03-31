import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDDE4CC),
                  ),
                  child: Image.asset(
                    'assets/notif_asset.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.7),
                  child: const Icon(Icons.dark_mode, color: Colors.black),
                ),
              ),
            ],
          ),

          // Bottom Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "+",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff926247),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "20 xp",
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4C3425),
                        letterSpacing: -2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 0),
                const Text(
                  "Hydration Goal",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF4B382E),
                  ),
                ),
                const SizedBox(height: 30),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    children: [
                      TextSpan(text: "You consumed 40% "),
                      TextSpan(
                        text: "more water",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      TextSpan(text: " than your hydration goal"),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Xp Now:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4B382E),
                        ),
                      ),

                      SizedBox(width: 10,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F5EB),
                          border: Border.all(color: const Color(0xFFCFD9B5), width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "2000",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9BB068),
                          ),
                        ),

                      )
                    ],
                  )
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9EAF6E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 80),
                  ),
                  onPressed: () {},
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "See Leaderboard",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.emoji_events_outlined, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Curved clipper for smooth transition
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
