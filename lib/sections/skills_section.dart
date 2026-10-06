import 'package:ashish_portfolio/widgets/floating_card.dart';
import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  final List<Map<String, dynamic>> skillCategories = const [
    {
      'title': 'Frontend & Mobile',
      'icon': Icons.phone_android_rounded,
      'skills': [
        {'name': 'Flutter', 'icon': Icons.phone_android_rounded},
        {'name': 'Dart', 'icon': Icons.code_rounded},
        {'name': 'JavaScript', 'icon': Icons.javascript_rounded},
        {'name': 'HTML & CSS', 'icon': Icons.web_rounded},
      ],
    },
    {
      'title': 'Backend',
      'icon': Icons.dns_outlined,
      'skills': [
        {'name': 'Java', 'icon': Icons.coffee_rounded},
        {'name': 'Spring Boot', 'icon': Icons.webhook_rounded},
        {'name': 'REST API', 'icon': Icons.api_rounded},
      ],
    },
    {
      'title': 'Database',
      'icon': Icons.storage_rounded,
      'skills': [
        {'name': 'MySQL', 'icon': Icons.storage_rounded},
        {'name': 'MongoDB', 'icon': Icons.data_object_rounded},
        {'name': 'SQLite', 'icon': Icons.table_chart_outlined},
      ],
    },
    {
      'title': 'Cloud & DevOps',
      'icon': Icons.cloud_outlined,
      'skills': [
        {'name': 'AWS', 'icon': Icons.cloud_outlined},
        {'name': 'Docker', 'icon': Icons.layers_outlined},
      ],
    },
    {
      'title': 'Tools & Development',
      'icon': Icons.build_outlined,
      'skills': [
        {'name': 'Git', 'icon': Icons.source_rounded},
        {'name': 'GitHub', 'icon': Icons.code_rounded},
        {'name': 'DSA', 'icon': Icons.account_tree_outlined},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width < 600 ? 24 : 70,
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
                'Skills & Technologies',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Technologies and tools I use to build applications '
                    'across frontend, backend, databases and cloud.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
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
                    itemCount: skillCategories.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.65,
                    ),
                    itemBuilder: (context, index) {
                      return _SkillCategoryCard(
                        category: skillCategories[index],
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

class _SkillCategoryCard extends StatefulWidget {
  final Map<String, dynamic> category;

  const _SkillCategoryCard({
    required this.category,
  });

  @override
  State<_SkillCategoryCard> createState() =>
      _SkillCategoryCardState();
}

class _SkillCategoryCardState
    extends State<_SkillCategoryCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    final skills =
    widget.category['skills'] as List<Map<String, dynamic>>;

    return FloatingCard(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.category['icon'],
                    color: primaryColor,
                    size: 23,
                  ),
                ),

                const SizedBox(width: 13),

                Expanded(
                  child: Text(
                    widget.category['title'],
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills.map((skill) {
                return _SkillChip(
                  name: skill['name'],
                  icon: skill['icon'],
                );
              }).toList(),
            ),
          ],
        ),
      );
  }
}

class _SkillChip extends StatelessWidget {
  final String name;
  final IconData icon;

  const _SkillChip({
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: primaryColor,
          ),

          const SizedBox(width: 6),

          Text(
            name,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
