import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final projects = [
      {
        'title': 'Note Editor',
        'category': 'Flutter Application',
        'description':
        'A Flutter note-taking application with local SQLite storage, '
            'CRUD operations, note editing and detailed note navigation.',
        'technologies': [
          'Flutter',
          'Dart',
          'SQLite',
          'CRUD',
        ],
        'icon': Icons.note_alt_outlined,
      },
      {
        'title': 'Barber Booking',
        'category': 'Full Stack Application',
        'description':
        'A booking application for managing barber services and '
            'appointments with a Flutter frontend and Spring Boot backend.',
        'technologies': [
          'Flutter',
          'Dart',
          'Java',
          'Spring Boot',
          'REST API',
        ],
        'icon': Icons.content_cut_outlined,
      },
      {
        'title': 'MedicarePlus',
        'category': 'Healthcare Application',
        'description':
        'A doctor appointment booking platform designed for patients, '
            'doctors and administrators with a modern Flutter interface.',
        'technologies': [
          'Flutter',
          'Dart',
          'Java',
          'Spring Boot',
          'MySQL',
        ],
        'icon': Icons.medical_services_outlined,
      },
      {
        'title': 'B2B Trade Portal',
        'category': 'Business Application',
        'description':
        'A business-to-business trading platform concept focused on '
            'connecting businesses and simplifying product and service interactions.',
        'technologies': [
          'Flutter',
          'Dart',
          'REST API',
          'Backend',
        ],
        'icon': Icons.business_center_outlined,
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
              Text(
                'Featured Projects',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'A selection of applications and projects built while learning, '
                    'experimenting and solving practical problems.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),

              const SizedBox(height: 40),

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
                      childAspectRatio: 1.18,
                    ),
                    itemBuilder: (context, index) {
                      return _ProjectCard(
                        project: projects[index],
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

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;

  const _ProjectCard({
    required this.project,
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

    return MouseRegion(
      cursor: SystemMouseCursors.click,

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
                ? primaryColor.withOpacity(0.45)
                : primaryColor.withOpacity(0.12),
          ),

          boxShadow: isHovered
              ? [
            BoxShadow(
              blurRadius: 25,
              spreadRadius: 1,
              color: primaryColor.withOpacity(0.12),
            ),
          ]
              : [],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row
            Row(
              children: [
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    widget.project['icon'],
                    color: primaryColor,
                    size: 27,
                  ),
                ),

                const Spacer(),

                _ProjectIconButton(
                  icon: Icons.code_rounded,
                  tooltip: 'GitHub',
                  onPressed: () {
                    // GitHub URL will be connected later.
                  },
                ),

                const SizedBox(width: 5),

                _ProjectIconButton(
                  icon: Icons.open_in_new_rounded,
                  tooltip: 'Live Demo',
                  onPressed: () {
                    // Live demo URL will be connected later.
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Category
            Text(
              widget.project['category'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 6),

            // Title
            Text(
              widget.project['title'],
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Description
            Expanded(
              child: Text(
                widget.project['description'],
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.55,
                  color: theme.colorScheme.onSurface.withOpacity(0.72),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Technologies
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children:
              (widget.project['technologies'] as List<String>)
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
                  primaryColor.withOpacity(0.08),
                  side: BorderSide.none,
                  visualDensity:
                  VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(
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

class _ProjectIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _ProjectIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 19,
        ),
        style: IconButton.styleFrom(
          foregroundColor:
          theme.colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
    );
  }
}