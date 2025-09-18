// main.dart
// Generated starter Flutter UI based on the Figma link you shared.
// I couldn't directly open the Figma file (likely permissions), so this is a
// well-structured, easily-editable Flutter implementation scaffold you can
// drop into a new Flutter project and adapt to match your Figma screens.

import 'package:flutter/material.dart';

void main() => runApp(const InmakesApp());

class InmakesApp extends StatelessWidget {
  const InmakesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inmakes UI (starter)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF7F8FB),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Overall safe padding and max width for larger screens
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        title: Row(
          children: [
            // Placeholder logo
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                  child: Text('IM',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ),
            const SizedBox(width: 12),
            const Text('Inmakes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_none)),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                GreetingHeader(),
                SizedBox(height: 18),
                SearchAndFilterRow(),
                SizedBox(height: 20),
                CardsGrid(),
                SizedBox(height: 20),
                FeaturedList(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Good Morning,',
                style: TextStyle(fontSize: 16, color: Colors.black54)),
            SizedBox(height: 6),
            Text('Mariet Sunny',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.indigo.shade100,
          child: const Text('MS'),
        ),
      ],
    );
  }
}

class SearchAndFilterRow extends StatelessWidget {
  const SearchAndFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 6))
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.black54),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                        hintText: 'Search courses, topics, or creators'),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic_none, color: Colors.black38)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () {},
              icon: const Icon(Icons.filter_list_rounded),
              label: const Text('Filter'),
            ),
          ),
        ),
      ],
    );
  }
}

class CardsGrid extends StatelessWidget {
  const CardsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // This grid replicates a Figma card list — change itemCount and builder to match design
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => CourseCard(index: index),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final int index;
  const CourseCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 6))
        ],
      ),
      child: Row(
        children: [
          // image placeholder
          Container(
            width: 94,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14)),
            ),
            child:
                const Center(child: Icon(Icons.play_circle_outline, size: 38)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Course ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  const Text('Beginner • 3 lessons',
                      style: TextStyle(fontSize: 12, color: Colors.black54)),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: const [
                        Icon(Icons.star, size: 14),
                        SizedBox(width: 6),
                        Text('4.8')
                      ]),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Open')),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FeaturedList extends StatelessWidget {
  const FeaturedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recommended for you',
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) => FeaturedTile(index: i),
          ),
        )
      ],
    );
  }
}

class FeaturedTile extends StatelessWidget {
  final int index;
  const FeaturedTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.indigo.shade50),
            child: const Icon(Icons.book, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Topic ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                const Text('Short description goes here',
                    style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(icon: Icons.home, label: 'Home', onTap: () {}),
            NavItem(icon: Icons.explore, label: 'Explore', onTap: () {}),
            NavItem(
                icon: Icons.play_circle_outline,
                label: 'My Courses',
                onTap: () {}),
            NavItem(icon: Icons.person_outline, label: 'Profile', onTap: () {}),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const NavItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

/*
How to use this starter:
1. Create a new Flutter project (flutter create inmakes_ui).
2. Replace lib/main.dart with this file.
3. Update colors, typography, and widgets to match your Figma exactly.
4. If you can make the Figma file public or export PNGs/screenshots, send them and I will
   update the widgets (images, sizes, spacing and exact colors) to match pixel-perfect.

If you want, I can also:
- Extract assets and provide an assets/ folder & pubspec.yaml snippet.
- Break the UI into smaller widget files (recommended for larger projects).
- Convert specific Figma screens to matching Flutter widgets if you upload screenshots or
  give me the component names (eg: Login, Dashboard, Course Details).
*/
