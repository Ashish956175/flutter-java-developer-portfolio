import 'package:flutter/material.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

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
                'Education',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'My academic background and engineering journey.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                  color: theme.textTheme.bodyMedium?.color?.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 700;

                  return _EducationCard(
                    isMobile: isMobile,
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

class _EducationCard extends StatefulWidget {
  final bool isMobile;

  const _EducationCard({
    required this.isMobile,
  });

  @override
  State<_EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<_EducationCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

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
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          0,
          isHovered ? -5 : 0,
          0,
        ),
        width: double.infinity,
        padding: EdgeInsets.all(
          widget.isMobile ? 22 : 30,
        ),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered
                ? primary.withValues(alpha: 0.35)
                : primary.withValues(alpha: 0.12),
          ),
          boxShadow: isHovered
              ? [
            BoxShadow(
              color: primary.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ]
              : [],
        ),
        child: widget.isMobile
            ? _mobileContent(context)
            : _desktopContent(context),
      ),
    );
  }

  Widget _desktopContent(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _EducationIcon(),

        const SizedBox(width: 22),

        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _educationDetails(context),
              ),

              const SizedBox(width: 20),

              _EducationBadge(
                text: '2022 – 2026',
                color: primary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _mobileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _EducationIcon(),

        const SizedBox(height: 22),

        _educationDetails(context),

        const SizedBox(height: 20),

        _EducationBadge(
          text: '2022 – 2026',
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  Widget _educationDetails(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bachelor of Engineering (B.E.)',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Computer Engineering',
          style: theme.textTheme.titleMedium?.copyWith(
            color: primary,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'Savitribai Phule Pune University (SPPU)',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          '2019 Pattern',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(
              alpha: 0.70,
            ),
          ),
        ),

        const SizedBox(height: 18),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _InfoChip(
              icon: Icons.calendar_today_outlined,
              text: '2022 – 2026',
            ),
            _InfoChip(
              icon: Icons.grade_outlined,
              text: 'CGPA: 6.58',
            ),
          ],
        ),
      ],
    );
  }
}

class _EducationIcon extends StatelessWidget {
  const _EducationIcon();

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: primary.withValues(alpha: 0.15),
        ),
      ),
      child: Icon(
        Icons.school_outlined,
        size: 34,
        color: primary,
      ),
    );
  }
}

class _EducationBadge extends StatelessWidget {
  final String text;
  final Color color;

  const _EducationBadge({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.18),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: primary,
          ),

          const SizedBox(width: 7),

          Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}