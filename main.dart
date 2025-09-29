import 'package:flutter/material.dart';

// --- CONFIGURATION CONSTANTS ---
const double kDesktopBreakpoint = 900.0;
const Color kPrimaryColor = Color(0xFFB71C1C); // Deep Red/Maroon
const Color kAccentColor = Color(0xFFEEEEEE);  // Light Grey/White for accents

class NavItem {
  final String title;
  final String route;
  NavItem(this.title, this.route);
}

final List<NavItem> kNavItems = [
  NavItem('Admissions', '/admissions'),
  NavItem('Academics', '/academics'),
  NavItem('News & Events', '/news'),
  NavItem('About Us', '/about'),
  NavItem('Portals', '/portals'),
];

// --- MAIN APPLICATION ENTRY POINT ---
void main() {
  runApp(const GRCCloneApp());
}

class GRCCloneApp extends StatelessWidget {
  const GRCCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Reciprocal Colleges Clone',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        appBarTheme: const AppBarTheme(
          color: kPrimaryColor,
          elevation: 0,
        ),
        textTheme: Typography.material2018().white,
        fontFamily: 'Roboto',
      ),
      home: const GRCCloneHomePage(),
    );
  }
}

// --- HOME PAGE WIDGET ---
class GRCCloneHomePage extends StatelessWidget {
  const GRCCloneHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= kDesktopBreakpoint;

    return Scaffold(
      appBar: AppBar(
        // Logo or Institution Name
        title: const Text(
          'GLOBAL RECIPROCAL COLLEGES',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        // On desktop, the main navigation is a Row; on mobile, it's a menu icon.
        actions: isDesktop
            ? [] // Nav items are in the body
            : [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: isDesktop ? null : const MobileDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Desktop Navigation Bar (shown only on desktop)
            if (isDesktop) const DesktopNavBar(),

            // Section 1: Hero Banner (Main Call to Action)
            const HeroSection(),

            // Section 2: Quick Links / Areas of Interest
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: isDesktop
                  ? const DesktopQuickLinks()
                  : const MobileQuickLinks(),
            ),

            // Section 3: News & Announcements
            const NewsSection(),

            // Section 4: Footer
            const WebsiteFooter(),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------

// --- DESKTOP NAVIGATION BAR (Secondary Bar) ---
class DesktopNavBar extends StatelessWidget {
  const DesktopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
      color: Colors.white, // Contrasting background
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: kNavItems.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextButton(
              onPressed: () {
                // In a real app, you'd use Navigator to go to item.route
                print('Navigating to ${item.route}');
              },
              child: Text(
                item.title,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// -----------------------------------------------------------------------------

// --- MOBILE DRAWER (For Menu on Small Screens) ---
class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: kPrimaryColor),
            child: const Text(
              'GRC Navigation',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ...kNavItems.map((item) => ListTile(
            leading: const Icon(Icons.school),
            title: Text(item.title),
            onTap: () {
              print('Navigating to ${item.route}');
              Navigator.pop(context);
            },
          )),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------

// --- HERO SECTION ---
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.8),
        image: DecorationImage(
          // Replace with a suitable placeholder image asset
          image: const NetworkImage('https://yt3.googleusercontent.com/ytc/AIdro_kQFQKAvUvEKH9qCIpryzJgcPOvD2Sqa8oKy6LZqALHnw=s900-c-k-c0x00ffffff-no-rj'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              kPrimaryColor.withOpacity(0.5), BlendMode.darken),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'START YOUR JOURNEY. ENROLL NOW!',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Apply Now clicked');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kAccentColor,
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: const Text(
                'APPLY ONLINE',
                style: TextStyle(fontSize: 20, color: kPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------

// --- QUICK LINKS/INFO CARDS ---
const List<Map<String, dynamic>> _infoCards = [
  {
    'title': 'Admission',
    'icon': Icons.person_add,
    'color': Colors.redAccent,
  },
  {
    'title': 'Scholarship',
    'icon': Icons.star,
    'color': Colors.redAccent,
  },
  {
    'title': 'Academics',
    'icon': Icons.menu_book,
    'color': Colors.redAccent,
  },
  {
    'title': 'Library',
    'icon': Icons.local_library,
    'color': Colors.red,
  },
];

class InfoCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const InfoCard(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          print('${data['title']} Card Tapped');
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                data['icon'] as IconData,
                size: 50,
                color: data['color'] as Color,
              ),
              const SizedBox(height: 10),
              Text(
                data['title'] as String,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Desktop layout uses a Row
class DesktopQuickLinks extends StatelessWidget {
  const DesktopQuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _infoCards.map((data) => Expanded(child: InfoCard(data))).toList(),
    );
  }
}

// Mobile layout uses a Grid
class MobileQuickLinks extends StatelessWidget {
  const MobileQuickLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 1.2,
      ),
      itemCount: _infoCards.length,
      itemBuilder: (context, index) => InfoCard(_infoCards[index]),
    );
  }
}

// -----------------------------------------------------------------------------

// --- NEWS SECTION (A simple list) ---
class NewsSection extends StatelessWidget {
  const NewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= kDesktopBreakpoint;

    return Container(
      width: double.infinity,
      color: Colors.grey[100],
      padding: EdgeInsets.all(isDesktop ? 50.0 : 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LATEST NEWS & EVENTS',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
          const Divider(thickness: 3, color: kAccentColor, endIndent: 700),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3, // Show top 3 news items
            itemBuilder: (context, index) {
              return NewsTile(index);
            },
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              print('View all news');
            },
            child: const Text('View All News',
                style: TextStyle(
                    fontSize: 16,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final int index;

  const NewsTile(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            color: kAccentColor.withOpacity(0.3),
            child: Center(
                child: Text('AUG\n${29 + index}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: kPrimaryColor))),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GRC Holds Annual Foundation Day ${2025 - index}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  'The Global Reciprocal Colleges successfully celebrated its annual foundation day with various activities and programs.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------

// --- WEBSITE FOOTER ---
class WebsiteFooter extends StatelessWidget {
  const WebsiteFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= kDesktopBreakpoint;

    return Container(
      width: double.infinity,
      color: kPrimaryColor,
      padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 50.0 : 20.0, vertical: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: FooterSection(title: 'Quick Links', items: ['About Us', 'Mission/Vision', 'Contact Us', 'Portals'])),
                Expanded(child: FooterSection(title: 'Academics', items: ['College of Education', 'BS Information Technology', 'BS Business Admin.'])),
                Expanded(child: ContactInfoSection()),
              ],
            )
          else
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FooterSection(title: 'Quick Links', items: ['About Us', 'Mission/Vision', 'Contact Us', 'Portals']),
                SizedBox(height: 20),
                FooterSection(title: 'Academics', items: ['College of Education', 'BS Information Technology', 'BS Business Admin.']),
                SizedBox(height: 20),
                ContactInfoSection(),
              ],
            ),
          const Divider(color: Colors.white70, height: 40),
          const Center(
            child: Text(
              '© 2025 Global Reciprocal Colleges. Designed and Maintained by IT Office.',
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  final String title;
  final List<String> items;

  const FooterSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            item,
            style: const TextStyle(color: Colors.white70),
          ),
        )),
      ],
    );
  }
}

class ContactInfoSection extends StatelessWidget {
  const ContactInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.location_on, color: kAccentColor, size: 18),
            SizedBox(width: 10),
            Flexible(
                child: Text('454 GRC BLDG. Rizal Ave. Caloocan City',
                    style: TextStyle(color: Colors.white70))),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(Icons.phone, color: kAccentColor, size: 18),
            SizedBox(width: 10),
            Text('8-452-2945 (Registrar)',
                style: TextStyle(color: Colors.white70)),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.facebook, color: kAccentColor, size: 24),
            SizedBox(width: 15),
            Icon(Icons.email, color: kAccentColor, size: 24),
            SizedBox(width: 15),
            // Placeholder for custom icon or platform (like YouTube)
            Icon(Icons.video_camera_back, color: kAccentColor, size: 24),
          ],
        )
      ],
    );
  }
}
