import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  final List<Map<String, dynamic>> skills = const [
    {
      'name': 'Flutter',
      'icon': Icons.phone_android,
    },
    {
      'name': 'Dart',
      'icon': Icons.code,
    },
    {
      'name': 'Java',
      'icon': Icons.coffee,
    },
    {
      'name': 'Spring Boot',
      'icon': Icons.web,
    },
    {
      'name': 'REST API',
      'icon': Icons.api,
    },
    {
      'name': 'MySQL',
      'icon': Icons.storage,
    },
    {
      'name': 'MongoDB',
      'icon': Icons.data_object,
    },
    {
      'name': 'AWS',
      'icon': Icons.cloud_outlined,
    },
    {
      'name': 'Docker',
      'icon': Icons.directions_boat,
    },
    {
      'name': 'Git & GitHub',
      'icon': Icons.source,
    },
    {
      'name': 'DSA',
      'icon': Icons.account_tree_outlined,
    },
    {
      'name': 'JavaScript',
      'icon': Icons.javascript,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount;

    if (width < 600) {
      crossAxisCount = 2;
    } else if (width < 1024) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 4;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width < 600 ? 24 : 70,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills & Technologies',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Technologies I use to build applications.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),

          const SizedBox(height: 35),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: skills.length,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.2,
            ),
            itemBuilder: (context, index) {
              final skill = skills[index];

              return _SkillCard(
                name: skill['name'],
                icon: skill['icon'],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final String name;
  final IconData icon;

  const _SkillCard({
    required this.name,
    required this.icon,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        Theme.of(context).colorScheme.primary;

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
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: isHovered
              ? primaryColor.withOpacity(0.10)
              : Theme.of(context)
              .cardTheme
              .color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered
                ? primaryColor
                : primaryColor.withOpacity(0.12),
          ),
        ),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: primaryColor,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                widget.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}