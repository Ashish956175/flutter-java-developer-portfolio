import 'package:flutter/material.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                'Experience',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'My professional experience and technical journey.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),

              const SizedBox(height: 40),

              _ExperienceCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard();

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

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

        transform: Matrix4.translationValues(
          0,
          isHovered ? -4 : 0,
          0,
        ),

        padding: const EdgeInsets.all(28),

        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: isHovered
                ? primaryColor.withValues(alpha: 0.4)
                : primaryColor.withValues(alpha: 0.12),
          ),

          boxShadow: isHovered
              ? [
            BoxShadow(
              blurRadius: 24,
              spreadRadius: 1,
              color: primaryColor.withValues(alpha: 0.10),
            ),
          ]
              : [],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ExperienceHeader(),

            const SizedBox(height: 30),

            Divider(
              color: theme.dividerColor.withValues(alpha: 0.5),
            ),

            const SizedBox(height: 26),

            Text(
              'Key Responsibilities',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            const _ExperiencePoint(
              text:
              'Developed responsive mobile interfaces using Flutter and Dart.',
            ),

            const _ExperiencePoint(
              text:
              'Integrated REST APIs with Flutter applications for dynamic data handling.',
            ),

            const _ExperiencePoint(
              text:
              'Developed backend REST APIs using Java and Spring Boot.',
            ),

            const _ExperiencePoint(
              text:
              'Worked with MySQL and MongoDB for application data management.',
            ),

            const _ExperiencePoint(
              text:
              'Used Docker for application deployment and development environments.',
            ),

            const _ExperiencePoint(
              text:
              'Worked on authentication, debugging, API integration and application development.',
            ),

            const SizedBox(height: 24),

            Text(
              'Technologies',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Wrap(
              spacing: 9,
              runSpacing: 9,
              children: [
                'Flutter',
                'Dart',
                'Java',
                'Spring Boot',
                'REST API',
                'MySQL',
                'MongoDB',
                'Docker',
              ].map((skill) {
                return Chip(
                  label: Text(
                    skill,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor:
                  primaryColor.withValues(alpha: 0.08),
                  side: BorderSide.none,
                  visualDensity: VisualDensity.compact,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceHeader extends StatelessWidget {
  const _ExperienceHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 58,
          width: 58,
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            Icons.work_outline_rounded,
            color: primaryColor,
            size: 29,
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Associate Software Engineer',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'ThynkTech India Pvt. Ltd.',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 7),

              Wrap(
                spacing: 16,
                runSpacing: 6,
                children: [
                  _HeaderInfo(
                    icon: Icons.location_on_outlined,
                    text: 'Pune, Maharashtra',
                  ),
                  _HeaderInfo(
                    icon: Icons.code_rounded,
                    text: 'Software Development',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const _HeaderInfo({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
          ),
        ),
      ],
    );
  }
}

class _ExperiencePoint extends StatelessWidget {
  final String text;

  const _ExperiencePoint({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(
              Icons.check_circle_outline_rounded,
              size: 19,
              color: primaryColor,
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.55,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.82),
              ),
            ),
          ),
        ],
      ),
    );
  }
}