import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final projects = [
      {
        'title': 'Note Editor',
        'description':
        'A Flutter note-taking application with local database storage, CRUD operations, note editing and detail navigation.',
        'technologies': ['Flutter', 'Dart', 'SQLite', 'CRUD'],
        'icon': Icons.note_alt_outlined,
      },
      {
        'title': 'Barber Booking',
        'description':
        'A booking application designed to manage barber services and appointments with a Flutter frontend and Spring Boot backend.',
        'technologies': ['Flutter', 'Dart', 'Java', 'Spring Boot', 'REST API'],
        'icon': Icons.content_cut_outlined,
      },
      {
        'title': 'MedicarePlus',
        'description':
        'Doctor appointment booking platform designed for patients, doctors and administrators with a modern Flutter interface.',
        'technologies': ['Flutter', 'Dart', 'Java', 'Spring Boot', 'MySQL'],
        'icon': Icons.medical_services_outlined,
      },
      {
        'title': 'B2B Trade Portal',
        'description':
        'A business-to-business trading platform concept focused on connecting businesses and simplifying product and service interactions.',
        'technologies': ['Flutter', 'Dart', 'REST API', 'Backend'],
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
          constraints: const BoxConstraints(maxWidth: 1100),
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
                'Projects that showcase my development skills and practical experience.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withValues(
                    alpha: 0.7,
                  ),
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: projects.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.25,
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

    return MouseRegion(
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
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, isHovered ? -6.0 : 0.0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered
                ? theme.colorScheme.primary.withValues(alpha: 0.5)
                : theme.colorScheme.primary.withValues(alpha: 0.12),
          ),
          boxShadow: isHovered
              ? [
            BoxShadow(
              blurRadius: 20,
              spreadRadius: 1,
              color: theme.colorScheme.primary.withValues(
                alpha: 0.12,
              ),
            ),
          ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(
                      alpha: 0.12,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    widget.project['icon'],
                    color: theme.colorScheme.primary,
                    size: 26,
                  ),
                ),

                const Spacer(),

                IconButton(
                  onPressed: () {
                    // GitHub link will be added later.
                  },
                  icon: const Icon(Icons.open_in_new),
                  tooltip: 'View Project',
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              widget.project['title'],
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Text(
                widget.project['description'],
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
              (widget.project['technologies'] as List<String>)
                  .map(
                    (technology) => Chip(
                  label: Text(
                    technology,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor:
                  theme.colorScheme.primary.withValues(
                    alpha: 0.08,
                  ),
                  side: BorderSide.none,
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