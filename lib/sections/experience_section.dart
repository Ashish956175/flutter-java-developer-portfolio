import 'package:flutter/material.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: Padding(
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
                  'Experience',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
      
                const SizedBox(height: 10),
      
                Text(
                  'My professional experience and technical journey.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withValues(
                      alpha: 0.7,
                    ),
                  ),
                ),
      
                const SizedBox(height: 40),
      
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF111722)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(
                        alpha: 0.15,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              Icons.work_outline,
                              color: theme.colorScheme.primary,
                              size: 28,
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
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
      
                                const SizedBox(height: 6),
      
                                Text(
                                  'Pune, Maharashtra',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
      
                      const SizedBox(height: 28),
      
                      Text(
                        'Key Responsibilities',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
      
                      const SizedBox(height: 16),
      
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
      
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
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
                            label: Text(skill),
                            backgroundColor:
                            theme.colorScheme.primary.withValues(
                              alpha: 0.10,
                            ),
                            side: BorderSide.none,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 20,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}