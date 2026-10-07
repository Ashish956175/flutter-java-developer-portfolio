import 'package:flutter/material.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

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

              const SizedBox(height: 10),

              Text(
                'My academic background and engineering journey.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: theme.colorScheme.onSurface.withValues(
                    alpha: 0.70,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // =================================================
              // B.E. CARD
              // =================================================

              _EducationCard(
                title: 'Bachelor of Engineering (B.E.)',
                course: 'Computer Engineering',
                institution:
                'Savitribai Phule Pune University (SPPU)',
                period: '2022 – 2026',
                result: 'CGPA: 6.58',
                icon: Icons.school_outlined,
                isPrimary: true,
              ),

              const SizedBox(height: 20),

              // =================================================
              // HSC + SSC
              // =================================================

              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 700;

                  if (isMobile) {
                    return Column(
                      children: [
                        _AcademicCard(
                          title: 'Higher Secondary Certificate',
                          subtitle: 'HSC',
                          period: '2022',
                          result: '57.80%',
                          icon: Icons.menu_book_outlined,
                        ),
                        const SizedBox(height: 16),
                        _AcademicCard(
                          title: 'Secondary School Certificate',
                          subtitle: 'SSC',
                          period: '2020',
                          result: '80.60%',
                          icon: Icons.auto_stories_outlined,
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: _AcademicCard(
                          title: 'Higher Secondary Certificate',
                          subtitle: 'HSC',
                          period: '2022',
                          result: '57.80%',
                          icon: Icons.menu_book_outlined,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _AcademicCard(
                          title: 'Secondary School Certificate',
                          subtitle: 'SSC',
                          period: '2020',
                          result: '80.60%',
                          icon: Icons.auto_stories_outlined,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              // =================================================
              // EDUCATION NOTE
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: primary.withValues(alpha: 0.10),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      color: primary,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Alongside my academic journey, I have focused on '
                            'practical software development through Flutter, '
                            'Java, Spring Boot, databases, AWS and personal projects.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.55,
                          color:
                          theme.colorScheme.onSurface.withValues(
                            alpha: 0.72,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================================
// B.E. EDUCATION CARD
// ==========================================================

class _EducationCard extends StatefulWidget {
  final String title;
  final String course;
  final String institution;
  final String period;
  final String result;
  final IconData icon;
  final bool isPrimary;

  const _EducationCard({
    required this.title,
    required this.course,
    required this.institution,
    required this.period,
    required this.result,
    required this.icon,
    required this.isPrimary,
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
      opaque: true,
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
          isHovered ? -5 : 0,
          0,
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered
                ? primary.withValues(alpha: 0.40)
                : primary.withValues(alpha: 0.12),
          ),
          boxShadow: isHovered
              ? [
            BoxShadow(
              color: primary.withValues(alpha: 0.10),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ]
              : [],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 650;

            if (isMobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _EducationIcon(
                    icon: widget.icon,
                  ),
                  const SizedBox(height: 20),
                  _educationContent(context),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _EducationIcon(
                  icon: widget.icon,
                ),
                const SizedBox(width: 22),
                Expanded(
                  child: _educationContent(context),
                ),
                const SizedBox(width: 20),
                _EducationBadge(
                  text: widget.period,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _educationContent(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          widget.course,
          style: theme.textTheme.titleMedium?.copyWith(
            color: primary,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          widget.institution,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 14),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _InfoChip(
              icon: Icons.calendar_today_outlined,
              text: widget.period,
            ),
            _InfoChip(
              icon: Icons.grade_outlined,
              text: widget.result,
            ),
            const _InfoChip(
              icon: Icons.account_balance_outlined,
              text: '2019 Pattern',
            ),
          ],
        ),
      ],
    );
  }
}

// ==========================================================
// EDUCATION ICON
// ==========================================================

class _EducationIcon extends StatelessWidget {
  final IconData icon;

  const _EducationIcon({
    required this.icon,
  });

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
        icon,
        size: 34,
        color: primary,
      ),
    );
  }
}

// ==========================================================
// YEAR BADGE
// ==========================================================

class _EducationBadge extends StatelessWidget {
  final String text;

  const _EducationBadge({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primary.withValues(alpha: 0.18),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: primary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ==========================================================
// HSC / SSC CARD
// ==========================================================

class _AcademicCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String period;
  final String result;
  final IconData icon;

  const _AcademicCard({
    required this.title,
    required this.subtitle,
    required this.period,
    required this.result,
    required this.icon,
  });

  @override
  State<_AcademicCard> createState() => _AcademicCardState();
}

class _AcademicCardState extends State<_AcademicCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return MouseRegion(
      opaque: true,
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
          isHovered ? -4 : 0,
          0,
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isHovered
                ? primary.withValues(alpha: 0.35)
                : primary.withValues(alpha: 0.10),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                widget.icon,
                color: primary,
                size: 25,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                      color: primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    widget.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 10,
                    runSpacing: 6,
                    children: [
                      Text(
                        widget.period,
                        style:
                        theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.65),
                        ),
                      ),
                      Text(
                        widget.result,
                        style:
                        theme.textTheme.bodySmall?.copyWith(
                          color: primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================================
// INFORMATION CHIP
// ==========================================================

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
