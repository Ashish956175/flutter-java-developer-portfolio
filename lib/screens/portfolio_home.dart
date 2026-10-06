import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../sections/about_section.dart';
import '../sections/certifications_section.dart';
import '../sections/contact_section.dart';
import '../sections/education_section.dart';
import '../sections/experience_section.dart';
import '../sections/hero_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/scroll_reveal.dart';

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

  // Section keys
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey certificationsKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  // Scroll to selected section
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
      // =====================================================
      // MOBILE
      // =====================================================
      mobile: _MobileHome(
        scrollController: _scrollController,
        homeKey: homeKey,
        aboutKey: aboutKey,
        skillsKey: skillsKey,
        experienceKey: experienceKey,
        projectsKey: projectsKey,
        certificationsKey: certificationsKey,
        educationKey: educationKey,
        contactKey: contactKey,
        scrollToSection: scrollToSection,
        onThemeChanged: widget.onThemeChanged,
      ),

      // =====================================================
      // TABLET
      // =====================================================
      tablet: _MobileHome(
        scrollController: _scrollController,
        homeKey: homeKey,
        aboutKey: aboutKey,
        skillsKey: skillsKey,
        experienceKey: experienceKey,
        projectsKey: projectsKey,
        certificationsKey: certificationsKey,
        educationKey: educationKey,
        contactKey: contactKey,
        scrollToSection: scrollToSection,
        onThemeChanged: widget.onThemeChanged,
      ),

      // =====================================================
      // DESKTOP
      // =====================================================
      desktop: _DesktopHome(
        scrollController: _scrollController,
        homeKey: homeKey,
        aboutKey: aboutKey,
        skillsKey: skillsKey,
        experienceKey: experienceKey,
        projectsKey: projectsKey,
        certificationsKey: certificationsKey,
        educationKey: educationKey,
        contactKey: contactKey,
        scrollToSection: scrollToSection,
        onThemeChanged: widget.onThemeChanged,
      ),
    );
  }
}

// ==========================================================
// DESKTOP / TABLET HOME
// ==========================================================

class _DesktopHome extends StatelessWidget {
  final ScrollController scrollController;

  final VoidCallback onThemeChanged;

  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey certificationsKey;
  final GlobalKey educationKey;
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
    required this.certificationsKey,
    required this.educationKey,
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
            // =================================================
            // NAVBAR
            // =================================================

            _DesktopNavbar(
              onThemeChanged: onThemeChanged,
              scrollToSection: scrollToSection,
              homeKey: homeKey,
              aboutKey: aboutKey,
              skillsKey: skillsKey,
              experienceKey: experienceKey,
              projectsKey: projectsKey,
              certificationsKey: certificationsKey,
              educationKey: educationKey,
              contactKey: contactKey,
            ),

            // =================================================
            // HERO
            // =================================================

            Container(
              key: homeKey,
              child: HeroSection(
                onViewProjects: () {
                  scrollToSection(projectsKey);
                },
              ),
            ),

            // =================================================
            // ABOUT
            // =================================================

            Container(
              key: aboutKey,
              child: ScrollReveal(child: const AboutSection()),
            ),

            // =================================================
            // SKILLS
            // =================================================

            Container(
              key: skillsKey,
              child: ScrollReveal(child: const SkillsSection()),
            ),

            // =================================================
            // EXPERIENCE
            // =================================================

            Container(
              key: experienceKey,
              child: ScrollReveal(child: const ExperienceSection()),
            ),

            // =================================================
            // PROJECTS
            // =================================================

            Container(
              key: projectsKey,
              child: ScrollReveal(child: const ProjectsSection()),
            ),

            // =================================================
            // CERTIFICATIONS
            // =================================================

            Container(
              key: certificationsKey,
              child: ScrollReveal(child: const CertificationsSection()),
            ),

            // =================================================
            // EDUCATION
            // =================================================

            Container(
              key: educationKey,
              child: ScrollReveal(child: const EducationSection()),
            ),

            // =================================================
            // CONTACT
            // =================================================

            Container(
              key: contactKey,
              child: ScrollReveal(child: const ContactSection()),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================================
// MOBILE HOME
// ==========================================================

class _MobileHome extends StatelessWidget {
  final ScrollController scrollController;

  final VoidCallback onThemeChanged;

  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey certificationsKey;
  final GlobalKey educationKey;
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
    required this.certificationsKey,
    required this.educationKey,
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
            // =================================================
            // MOBILE NAVBAR
            // =================================================

            _MobileNavbar(
              onThemeChanged: onThemeChanged,
              scrollToSection: scrollToSection,
              homeKey: homeKey,
              aboutKey: aboutKey,
              skillsKey: skillsKey,
              experienceKey: experienceKey,
              projectsKey: projectsKey,
              certificationsKey: certificationsKey,
              educationKey: educationKey,
              contactKey: contactKey,
            ),

            // =================================================
            // HERO
            // =================================================

            Container(
              key: homeKey,
              child: HeroSection(
                onViewProjects: () {
                  scrollToSection(projectsKey);
                },
              ),
            ),

            // =================================================
            // ABOUT
            // =================================================

            Container(
              key: aboutKey,
              child: const AboutSection(),
            ),

            // =================================================
            // SKILLS
            // =================================================

            Container(
              key: skillsKey,
              child: const SkillsSection(),
            ),

            // =================================================
            // EXPERIENCE
            // =================================================

            Container(
              key: experienceKey,
              child: const ExperienceSection(),
            ),

            // =================================================
            // PROJECTS
            // =================================================

            Container(
              key: projectsKey,
              child: const ProjectsSection(),
            ),

            // =================================================
            // CERTIFICATIONS
            // =================================================

            Container(
              key: certificationsKey,
              child: const CertificationsSection(),
            ),

            // =================================================
            // EDUCATION
            // =================================================

            Container(
              key: educationKey,
              child: const EducationSection(),
            ),

            // =================================================
            // CONTACT
            // =================================================

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

// ==========================================================
// DESKTOP NAVBAR
// ==========================================================

class _DesktopNavbar extends StatelessWidget {
  final VoidCallback onThemeChanged;

  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey certificationsKey;
  final GlobalKey educationKey;
  final GlobalKey contactKey;

  final Function(GlobalKey) scrollToSection;

  const _DesktopNavbar({
    required this.onThemeChanged,
    required this.homeKey,
    required this.aboutKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.certificationsKey,
    required this.educationKey,
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
          // =================================================
          // LOGO
          // =================================================

          Text(
            'ASHISH',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),

          const Spacer(),

          // =================================================
          // NAV ITEMS
          // =================================================

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
            'Experience',
            experienceKey,
          ),

          _navItem(
            'Projects',
            projectsKey,
          ),

          _navItem(
            'Certifications',
            certificationsKey,
          ),

          _navItem(
            'Education',
            educationKey,
          ),

          _navItem(
            'Contact',
            contactKey,
          ),

          const SizedBox(width: 8),

          // =================================================
          // THEME BUTTON
          // =================================================

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

          // =================================================
          // RESUME BUTTON
          // =================================================

          ElevatedButton.icon(
            onPressed: _openResume,
            icon: const Icon(
              Icons.download_outlined,
              size: 18,
            ),
            label: const Text('Resume'),
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

  Future<void> _openResume() async {
    final uri = Uri.base.resolve(
      'resume/Ashish_Resume.pdf',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}

// ==========================================================
// MOBILE NAVBAR
// ==========================================================

class _MobileNavbar extends StatelessWidget {
  final VoidCallback onThemeChanged;

  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey projectsKey;
  final GlobalKey certificationsKey;
  final GlobalKey educationKey;
  final GlobalKey contactKey;

  final Function(GlobalKey) scrollToSection;

  const _MobileNavbar({
    required this.onThemeChanged,
    required this.homeKey,
    required this.aboutKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.projectsKey,
    required this.certificationsKey,
    required this.educationKey,
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
          // =================================================
          // LOGO
          // =================================================

          Text(
            'ASHISH',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),

          const Spacer(),

          // =================================================
          // THEME
          // =================================================

          IconButton(
            tooltip: 'Change theme',
            onPressed: onThemeChanged,
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),

          // =================================================
          // MENU
          // =================================================

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
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // =========================================
                  // HOME
                  // =========================================

                  _menuItem(
                    context,
                    'Home',
                    Icons.home_outlined,
                    homeKey,
                  ),

                  // =========================================
                  // ABOUT
                  // =========================================

                  _menuItem(
                    context,
                    'About',
                    Icons.person_outline,
                    aboutKey,
                  ),

                  // =========================================
                  // SKILLS
                  // =========================================

                  _menuItem(
                    context,
                    'Skills',
                    Icons.code_outlined,
                    skillsKey,
                  ),

                  // =========================================
                  // EXPERIENCE
                  // =========================================

                  _menuItem(
                    context,
                    'Experience',
                    Icons.work_outline,
                    experienceKey,
                  ),

                  // =========================================
                  // PROJECTS
                  // =========================================

                  _menuItem(
                    context,
                    'Projects',
                    Icons.folder_outlined,
                    projectsKey,
                  ),

                  // =========================================
                  // CERTIFICATIONS
                  // =========================================

                  _menuItem(
                    context,
                    'Certifications',
                    Icons.verified_outlined,
                    certificationsKey,
                  ),

                  // =========================================
                  // EDUCATION
                  // =========================================

                  _menuItem(
                    context,
                    'Education',
                    Icons.school_outlined,
                    educationKey,
                  ),

                  // =========================================
                  // CONTACT
                  // =========================================

                  _menuItem(
                    context,
                    'Contact',
                    Icons.email_outlined,
                    contactKey,
                  ),

                  const SizedBox(height: 10),

                  // =========================================
                  // RESUME
                  // =========================================

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _openResume();
                      },
                      icon: const Icon(
                        Icons.download_outlined,
                      ),
                      label: const Text(
                        'Download Resume',
                      ),
                    ),
                  ),
                ],
              ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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

  Future<void> _openResume() async {
    final uri = Uri.base.resolve(
      'resume/Ashish_Resume.pdf',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}