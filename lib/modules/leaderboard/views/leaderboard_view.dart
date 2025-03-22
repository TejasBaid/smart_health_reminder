import 'package:flutter/material.dart';
import 'package:smart_health_reminder/core/const_imports.dart';
import 'package:smart_health_reminder/modules/posture_tracking/widgets/ripple_background.dart';
import 'package:smart_health_reminder/core/widgets/custom_navbar.dart';

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({Key? key}) : super(key: key);

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  int _currentIndex = 4;

  final List<Map<String, dynamic>> _topUsers = [
    {'name': 'Michael Chen', 'points': 3120, 'rank': 1, 'streak': 21},
    {'name': 'Sarah Johnson', 'points': 2845, 'rank': 2, 'streak': 14},
    {'name': 'Priya Sharma', 'points': 2680, 'rank': 3, 'streak': 12},
  ];

  final List<Map<String, dynamic>> _allUsers = [
    {'name': 'Michael Chen', 'points': 3120, 'rank': 1, 'streak': 21},
    {'name': 'Sarah Johnson', 'points': 2845, 'rank': 2, 'streak': 14},
    {'name': 'Priya Sharma', 'points': 2680, 'rank': 3, 'streak': 12},
    {'name': 'David Wilson', 'points': 2540, 'rank': 4, 'streak': 9},
    {'name': 'Emma Garcia', 'points': 2315, 'rank': 5, 'streak': 7},
    {'name': 'You', 'points': 2290, 'rank': 6, 'streak': 8, 'isCurrentUser': true},
    {'name': 'Alex Kim', 'points': 2180, 'rank': 7, 'streak': 5},
    {'name': 'Olivia Brown', 'points': 2050, 'rank': 8, 'streak': 4},
    {'name': 'James Smith', 'points': 1920, 'rank': 9, 'streak': 3},
    {'name': 'Sophia Lee', 'points': 1780, 'rank': 10, 'streak': 2},
  ];

  final Map<String, dynamic> _userAchievements = {
    'currentStreak': 8,
    'longestStreak': 15,
    'totalPoints': 2290,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                const StaticRippleBackground(),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        _buildLeaderboardHeader(),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              color: ColorConsts.bluePrimary,
              child: Material(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                clipBehavior: Clip.antiAlias,
                color: ColorConsts.whiteCl,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUserProgressHeader(),
                        const SizedBox(height: 16),
                        _buildImprovedUserStreakCard(),
                        const SizedBox(height: 24),
                        _buildFullLeaderboardSection(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Leaderboard',
              style: TextStyle(
                color: ColorConsts.whiteCl,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: ColorConsts.greenAccent, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Weekly Challenge',
                  style: TextStyle(color: ColorConsts.whiteCl.withOpacity(0.9)),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: ColorConsts.whiteCl.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Text(
                'This Week',
                style: TextStyle(
                  color: ColorConsts.whiteCl,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                color: ColorConsts.whiteCl,
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopThreeBadges() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildBadge(_topUsers[1], 2),
          const SizedBox(width: 12),
          _buildBadge(_topUsers[0], 1),
          const SizedBox(width: 12),
          _buildBadge(_topUsers[2], 3),
        ],
      ),
    );
  }

  Widget _buildBadge(Map<String, dynamic> user, int position) {
    Color badgeColor = position == 1
        ? const Color(0xFFFFD700)
        : (position == 2 ? const Color(0xFFC0C0C0) : const Color(0xFFCD7F32));

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: position == 1 ? 50 : 40,
          height: position == 1 ? 50 : 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: badgeColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$position',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: position == 1 ? 32 : 28,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          user['name'].toString().split(' ')[0],
          style: TextStyle(
            color: ColorConsts.whiteCl,
            fontWeight: FontWeight.w500,
            fontSize: position == 1 ? 14 : 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${user['points']} pts',
          style: TextStyle(
            color: ColorConsts.whiteCl.withOpacity(0.8),
            fontSize: position == 1 ? 13 : 11,
          ),
        ),
      ],
    );
  }

  Widget _buildUserProgressHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your Progress",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorConsts.blackText,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'You\'re on an ${_userAchievements['currentStreak']}-day streak! Keep going!',
          style: const TextStyle(
            fontSize: 14,
            color: ColorConsts.greySubtitle,
          ),
        ),
      ],
    );
  }

  Widget _buildImprovedUserStreakCard() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orangeAccent.shade400, Colors.orangeAccent.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          StaticRippleBackgroundCard(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStreakInfo('Current', _userAchievements['currentStreak'], Icons.local_fire_department),
                    _buildStreakInfo('Longest', _userAchievements['longestStreak'], Icons.emoji_events),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total xp earned',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${_userAchievements['totalPoints']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakInfo(String label, int value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '$value',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }




  Widget _buildFullLeaderboardSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Full Leaderboard",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorConsts.blackText,
          ),
        ),
        const SizedBox(height: 16),
        ..._allUsers.map((user) => _buildLeaderboardItem(user)),
      ],
    );
  }

  Widget _buildLeaderboardItem(Map<String, dynamic> user) {
    final bool isCurrentUser = user['isCurrentUser'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentUser ? ColorConsts.tealPopAccent.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrentUser ? ColorConsts.tealPopAccent.withOpacity(0.3) : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildRankBadge(user['rank']),
          const SizedBox(width: 12),
          _buildUserAvatar(user, isCurrentUser),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: isCurrentUser ? ColorConsts.tealPopAccent : ColorConsts.blackText,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      color: Colors.orange,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${user['streak']} day streak',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '${user['points']} pts',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isCurrentUser ? ColorConsts.tealPopAccent : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankBadge(int rank) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: _getRankColor(rank),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          rank.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatar(Map<String, dynamic> user, bool isCurrentUser) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorConsts.bluePrimary.withOpacity(0.1),
        border: isCurrentUser
            ? Border.all(color: ColorConsts.tealPopAccent, width: 2)
            : null,
      ),
      child: Center(
        child: Text(
          user['name'].toString().substring(0, 1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isCurrentUser ? ColorConsts.tealPopAccent : ColorConsts.bluePrimary,
          ),
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    if (rank == 1) return const Color(0xFFFFD700);
    if (rank == 2) return const Color(0xFFC0C0C0);
    if (rank == 3) return const Color(0xFFCD7F32);
    return Colors.grey.shade500;
  }
}
class BubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.2), 30, paint);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.8), 20, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 15, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
class StaticRippleBackgroundCard extends StatelessWidget {
  const StaticRippleBackgroundCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StaticRipplePainterCard(),
      size: Size.infinite,
    );
  }
}

class StaticRipplePainterCard extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final origin = Offset(size.width * 0.2, size.height * -0.5);
    for (int i = 0; i < 8; i++) {
      final radius = size.width * (0.2 + i * 0.18);
      final paint = Paint()
        ..color = ColorConsts.whiteCl.withOpacity(0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawCircle(origin, radius, paint);
    }
  }

  @override
  bool shouldRepaint(StaticRipplePainterCard oldDelegate) => false;
}
