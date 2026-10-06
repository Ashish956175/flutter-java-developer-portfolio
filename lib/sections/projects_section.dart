import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final projects = [
      // --------------------------------------------------
      // 1. NOTE EDITOR
      // --------------------------------------------------
      {
        'title': 'Note Editor',
        'category': 'Flutter Application',
        'description':
        'A simple Flutter note editor application for creating, '
            'editing, deleting and managing notes with local data storage.',
        'technologies': [
          'Flutter',
          'Dart',
          'SQLite',
          'CRUD',
        ],
        'icon': Icons.note_alt_outlined,
        'github':
        'https://github.com/Ashish956175/Note_Editor_App_Flutter',
      },

      // --------------------------------------------------
      // 2. BARBER BOOKING
      // --------------------------------------------------
      {
        'title': 'Barber Booking',
        'category': 'Full Stack Application',
        'description':
        'A modern Barber and Salon Booking platform built with '
            'Flutter and Spring Boot REST APIs for managing services '
            'and appointments.',
        'technologies': [
          'Flutter',
          'Dart',
          'Java',
          'Spring Boot',
          'REST API',
          'MongoDB',
        ],
        'icon': Icons.content_cut_outlined,
        'github':
        'https://github.com/Ashish956175/BarberBooking',
      },

      // --------------------------------------------------
      // 3. MEDICAREPLUS
      // --------------------------------------------------
      {
        'title': 'MedicarePlus',
        'category': 'Healthcare Application',
        'description':
        'A full-stack healthcare appointment platform designed '
            'for patients, doctors and administrators with a Flutter '
            'frontend and Spring Boot backend.',
        'technologies': [
          'Flutter',
          'Dart',
          'Java',
          'Spring Boot',
          'MySQL',
          'REST API',
        ],
        'icon': Icons.medical_services_outlined,
        'github':
        'https://github.com/Ashish956175/MedicarePlus',
      },

      // --------------------------------------------------
      // 4. BANK MANAGEMENT SYSTEM
      // --------------------------------------------------
      {
        'title': 'Bank Management System',
        'category': 'Java Application',
        'description':
        'A Java-based banking application focused on implementing '
            'core banking operations and practicing object-oriented '
            'programming concepts.',
        'technologies': [
          'Java',
          'OOP',
          'Banking',
        ],
        'icon': Icons.account_balance_outlined,
        'github':
        'https://github.com/Ashish956175/Bank_Management_System',
      },

      // --------------------------------------------------
      // 5. SHARED PREFERENCES FLUTTER
      // --------------------------------------------------
      {
        'title': 'Shared Preferences Flutter',
        'category': 'Flutter Application',
        'description':
        'A Flutter application demonstrating persistent local '
            'login state using Shared Preferences.',
        'technologies': [
          'Flutter',
          'Dart',
          'Shared Preferences',
          'Local Storage',
        ],
        'icon': Icons.settings_backup_restore_outlined,
        'github':
        'https://github.com/Ashish956175/Shared_Preferences_Flutter',
      },

      // --------------------------------------------------
      // 6. PORTFOLIO
      // --------------------------------------------------
      {
        'title': 'Flutter & Java Developer Portfolio',
        'category': 'Flutter Web Application',
        'description':
        'A responsive developer portfolio built with Flutter Web '
            'to showcase software development skills, experience, '
            'projects, certifications, education and contact information.',
        'technologies': [
          'Flutter',
          'Dart',
          'Responsive UI',
          'URL Launcher',
          'Git',
          'GitHub',
        ],
        'icon': Icons.web_outlined,
        'github':
        'https://github.com/Ashish956175/flutter-java-developer-portfolio',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --------------------------------------------------
              // SECTION TITLE
              // --------------------------------------------------
              Text(
                'Featured Projects',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'A selection of applications and projects built while '
                    'learning, experimenting and solving practical problems.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: theme.colorScheme.onSurface.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // --------------------------------------------------
              // PROJECT GRID
              // --------------------------------------------------
              LayoutBuilder(
                builder: (context, constraints) {
                  int columns = 1;

                  if (constraints.maxWidth >= 900) {
                    columns = 2;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    itemCount: projects.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 22,
                      mainAxisSpacing: 22,
                      childAspectRatio: 1.15,
                    ),
                    itemBuilder: (context, index) {
                      return _ProjectCard(
                        project: projects[index],
                        onOpenUrl: _openUrl,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================================
// PROJECT CARD
// ==========================================================

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final Future<void> Function(String url) onOpenUrl;

  const _ProjectCard({
    required this.project,
    required this.onOpenUrl,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    final String githubUrl =
        widget.project['github'] as String? ?? '';

    final bool hasGithub = githubUrl.isNotEmpty;

    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,

        transform: Matrix4.translationValues(
          0,
          isHovered ? -6 : 0,
          0,
        ),

        padding: const EdgeInsets.all(24),

        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: isHovered
                ? primaryColor.withValues(alpha: 0.45)
                : primaryColor.withValues(alpha: 0.12),
          ),

          boxShadow: isHovered
              ? [
            BoxShadow(
              blurRadius: 25,
              spreadRadius: 1,
              color: primaryColor.withValues(alpha: 0.12),
              offset: const Offset(0, 8),
            ),
          ]
              : [],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------------------------------------------------
            // ICON + GITHUB BUTTON
            // --------------------------------------------------
            Row(
              children: [
                Container(
                  height: 52,
                  width: 52,

                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: Icon(
                    widget.project['icon'] as IconData,
                    color: primaryColor,
                    size: 27,
                  ),
                ),

                const Spacer(),

                if (hasGithub)
                  OutlinedButton.icon(
                    onPressed: () {
                      widget.onOpenUrl(githubUrl);
                    },

                    icon: const Icon(
                      Icons.code_rounded,
                      size: 18,
                    ),

                    label: const Text(
                      'GitHub',
                    ),

                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryColor,

                      side: BorderSide(
                        color: primaryColor.withValues(
                          alpha: 0.25,
                        ),
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 20),

            // --------------------------------------------------
            // CATEGORY
            // --------------------------------------------------
            Text(
              widget.project['category'] as String,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 6),

            // --------------------------------------------------
            // PROJECT TITLE
            // --------------------------------------------------
            Text(
              widget.project['title'] as String,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,

              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 12),

            // --------------------------------------------------
            // DESCRIPTION
            // --------------------------------------------------
            Expanded(
              child: Text(
                widget.project['description'] as String,

                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.55,
                  color: theme.colorScheme.onSurface.withValues(
                    alpha: 0.72,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // --------------------------------------------------
            // TECHNOLOGIES
            // --------------------------------------------------
            Wrap(
              spacing: 7,
              runSpacing: 7,

              children:
              (widget.project['technologies']
              as List<String>)
                  .map(
                    (technology) => Chip(
                  label: Text(
                    technology,

                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  backgroundColor:
                  primaryColor.withValues(
                    alpha: 0.08,
                  ),

                  side: BorderSide.none,

                  visualDensity:
                  VisualDensity.compact,

                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}