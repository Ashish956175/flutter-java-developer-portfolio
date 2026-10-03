import 'package:flutter/material.dart';

import '../sections/about_section.dart';
import '../sections/certifications_section.dart';
import '../sections/contact_section.dart';
import '../sections/education_section.dart';
import '../sections/experience_section.dart';
import '../sections/hero_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../widgets/responsive_layout.dart';

class PortfolioHome extends StatefulWidget {
  final VoidCallback onThemeChanged;

  const PortfolioHome({
    super.key,
    required this.onThemeChanged,
  });

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        alignment: 0.05,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _MobileHome(
        scrollController: _scrollController,
        homeKey: homeKey,
        aboutKey: aboutKey,
        skillsKey: skillsKey,
        experienceKey: experienceKey,
        projectsKey: projectsKey,
        contactKey: contactKey,
        scrollToSection: scrollToSection,
        onThemeChanged: widget.onThemeChanged,
      ),
      tablet: _DesktopHome(
        scrollController: _scrollController,
        homeKey: homeKey,
        aboutKey: aboutKey,
        skillsKey: skillsKey,
        experienceKey: experienceKey,
        projectsKey: projectsKey,
        contactKey: contactKey,
        scrollToSection: scrollToSection,
        onThemeChanged: widget.onThemeChanged,
      ),
      desktop: _DesktopHome(
        scrollController: _scrollController,
        homeKey: homeKey,
        aboutKey: aboutKey,
        skillsKey: skillsKey,
        experienceKey: experienceKey,
        projectsKey: projectsKey,
        contactKey: contactKey,
        scrollToSection: scrollToSection,
        onThemeChanged: widget.onThemeChanged,
      ),
    );
  }
}

// =====================================================
// DESKTOP HOME
// =====================================================

class _DesktopHome extends StatelessWidget {
  final ScrollController scrollController;

  final VoidCallback onThemeChanged;

  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  final Function(GlobalKey) scrollToSection;

  const _DesktopHome({
    required this.scrollController,
    required this.onThemeChanged,
    required this.homeKey,
    required this.aboutKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.contactKey,
    required this.scrollToSection,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            _DesktopNavbar(
              onThemeChanged: onThemeChanged,
              scrollToSection: scrollToSection,
              homeKey: homeKey,
              aboutKey: aboutKey,
              skillsKey: skillsKey,
              experienceKey: experienceKey,
              projectsKey: projectsKey,
              contactKey: contactKey,
            ),
            // Hero
            Container(
              key: homeKey,
              child: HeroSection(
                onViewProjects: () => scrollToSection(projectsKey),
              )
            ),

            // About
            Container(
              key: aboutKey,
              child: const AboutSection(),
            ),

            // Skills
            Container(
              key: skillsKey,
              child: const SkillsSection(),
            ),

            // Experience
            Container(
              key: experienceKey,
              child: const ExperienceSection(),
            ),

            // Projects
            Container(
              key: projectsKey,
              child: const ProjectsSection(),
            ),

            // Certifications
            const CertificationsSection(),

            // Education
            const EducationSection(),

            // Contact
            Container(
              key: contactKey,
              child: const ContactSection(),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// MOBILE HOME
// =====================================================

class _MobileHome extends StatelessWidget {
  final ScrollController scrollController;

  final VoidCallback onThemeChanged;

  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  final Function(GlobalKey) scrollToSection;

  const _MobileHome({
    required this.scrollController,
    required this.onThemeChanged,
    required this.homeKey,
    required this.aboutKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.contactKey,
    required this.scrollToSection,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            _MobileNavbar(
              onThemeChanged: onThemeChanged,
              scrollToSection: scrollToSection,
              homeKey: homeKey,
              aboutKey: aboutKey,
              skillsKey: skillsKey,
              experienceKey: experienceKey,
              projectsKey: projectsKey,
              contactKey: contactKey,
            ),

            // Hero
            Container(
              key: homeKey,
              child: HeroSection(
                onViewProjects: () => scrollToSection(projectsKey),
              ),
            ),

            // About
            Container(
              key: aboutKey,
              child: const AboutSection(),
            ),

            // Skills
            Container(
              key: skillsKey,
              child: const SkillsSection(),
            ),

            // Experience
            Container(
              key: experienceKey,
              child: const ExperienceSection(),
            ),

            // Projects
            Container(
              key: projectsKey,
              child: const ProjectsSection(),
            ),

            // Certifications
            const CertificationsSection(),

            // Education
            const EducationSection(),

            // Contact
            Container(
              key: contactKey,
              child: const ContactSection(),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// DESKTOP NAVBAR
// =====================================================

class _DesktopNavbar extends StatelessWidget {
  final VoidCallback onThemeChanged;

  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  final Function(GlobalKey) scrollToSection;

  const _DesktopNavbar({
    required this.onThemeChanged,
    required this.homeKey,
    required this.aboutKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.contactKey,
    required this.scrollToSection,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              color: theme.colorScheme.primary,
            ),
          ),

          const Spacer(),

          _navItem(
            'Home',
            homeKey,
          ),

          _navItem(
            'About',
            aboutKey,
          ),

          _navItem(
            'Skills',
            skillsKey,
          ),

          _navItem(
            'Projects',
            projectsKey,
          ),

          _navItem(
            'Experience',
            experienceKey,
          ),

          _navItem(
            'Contact',
            contactKey,
          ),

          IconButton(
            tooltip: 'Change theme',
            onPressed: onThemeChanged,
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),

          const SizedBox(width: 8),

          ElevatedButton(
            onPressed: () {
              // Resume download will be added later.
            },
            child: const Text('Resume'),
          ),
        ],
      ),
    );
  }

  Widget _navItem(
      String title,
      GlobalKey sectionKey,
      ) {
    return TextButton(
      onPressed: () {
        scrollToSection(sectionKey);
      },
      child: Text(title),
    );
  }
}

// =====================================================
// MOBILE NAVBAR
// =====================================================

class _MobileNavbar extends StatelessWidget {
  final VoidCallback onThemeChanged;

  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey contactKey;

  final Function(GlobalKey) scrollToSection;

  const _MobileNavbar({
    required this.onThemeChanged,
    required this.homeKey,
    required this.aboutKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.contactKey,
    required this.scrollToSection,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              color: theme.colorScheme.primary,
            ),
          ),

          const Spacer(),

          IconButton(
            tooltip: 'Change theme',
            onPressed: onThemeChanged,
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),

          IconButton(
            tooltip: 'Menu',
            onPressed: () {
              _showMobileMenu(context);
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _menuItem(
                  context,
                  'Home',
                  Icons.home_outlined,
                  homeKey,
                ),

                _menuItem(
                  context,
                  'About',
                  Icons.person_outline,
                  aboutKey,
                ),

                _menuItem(
                  context,
                  'Skills',
                  Icons.code_outlined,
                  skillsKey,
                ),

                _menuItem(
                  context,
                  'Experience',
                  Icons.work_outline,
                  experienceKey,
                ),

                _menuItem(
                  context,
                  'Projects',
                  Icons.folder_outlined,
                  projectsKey,
                ),

                _menuItem(
                  context,
                  'Contact',
                  Icons.email_outlined,
                  contactKey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _menuItem(
      BuildContext context,
      String title,
      IconData icon,
      GlobalKey sectionKey,
      ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);

        Future.delayed(
          const Duration(milliseconds: 150),
              () {
            scrollToSection(sectionKey);
          },
        );
      },
    );
  }
}