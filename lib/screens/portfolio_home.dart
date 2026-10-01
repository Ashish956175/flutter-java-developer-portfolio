import 'package:flutter/material.dart';
import '../sections/hero_section.dart';
import '../widgets/responsive_layout.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/experience_section.dart';
import '../sections/projects_section.dart';
import '../sections/certifications_section.dart';
import '../sections/education_section.dart';
import '../sections/contact_section.dart';

class PortfolioHome extends StatelessWidget {
  final VoidCallback onThemeChanged;

  const PortfolioHome({
    super.key,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: _MobileHome(
          onThemeChanged: onThemeChanged,
        ),
        tablet: _DesktopHome(
          onThemeChanged: onThemeChanged,
        ),
        desktop: _DesktopHome(
          onThemeChanged: onThemeChanged,
        ),
      ),
    );
  }
}

//destop
class _DesktopHome extends StatelessWidget {
  final VoidCallback onThemeChanged;

  const _DesktopHome({
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _DesktopNavbar(
            onThemeChanged: onThemeChanged,
          ),

          const HeroSection(),
          const AboutSection(),
          const SkillsSection(),
          const ExperienceSection(),
          const ProjectsSection(),
          const CertificationsSection(),
          const EducationSection(),
          const ContactSection(),
        ],
      ),
    );
  }
}

//mobile
class _MobileHome extends StatelessWidget {
  final VoidCallback onThemeChanged;

  const _MobileHome({
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _MobileNavbar(
            onThemeChanged: onThemeChanged,
          ),

          const HeroSection(),
          const AboutSection(),
          const SkillsSection(),
          const ExperienceSection(),
          const ProjectsSection(),
          const CertificationsSection(),
          const EducationSection(),
          const ContactSection(),
        ],
      ),
    );
  }
}
//destopNavebar
class _DesktopNavbar extends StatelessWidget {
  final VoidCallback onThemeChanged;

  const _DesktopNavbar({
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 20,
      ),
      child: Row(
        children: [
          Text(
            'ASHISH',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context)
                  .colorScheme
                  .primary,
            ),
          ),

          const Spacer(),

          _navItem('Home'),
          _navItem('About'),
          _navItem('Skills'),
          _navItem('Projects'),
          _navItem('Experience'),
          _navItem('Contact'),

          IconButton(
            tooltip: 'Change theme',
            onPressed: onThemeChanged,
            icon: Icon(
              Theme.of(context).brightness ==
                  Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),

          const SizedBox(width: 8),

          ElevatedButton(
            onPressed: () {},
            child: const Text('Resume'),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String title) {
    return TextButton(
      onPressed: () {},
      child: Text(title),
    );
  }
}

//mobileNavbar
class _MobileNavbar extends StatelessWidget {
  final VoidCallback onThemeChanged;

  const _MobileNavbar({
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Row(
        children: [
          Text(
            'ASHISH',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context)
                  .colorScheme
                  .primary,
            ),
          ),

          const Spacer(),

          IconButton(
            tooltip: 'Change theme',
            onPressed: onThemeChanged,
            icon: Icon(
              Theme.of(context).brightness ==
                  Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),

          IconButton(
            tooltip: 'Menu',
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
    );
  }
}