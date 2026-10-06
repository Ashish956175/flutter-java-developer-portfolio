import 'package:ashish_portfolio/widgets/floating_card.dart';
import 'package:flutter/material.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final certifications = [
      {
        'title': 'ServiceNow Virtual Internship Program',
        'organization': 'SmartBridge • AICTE • ServiceNow',
        'description':
        'Virtual internship program focused on ServiceNow platform '
            'fundamentals, system administration and modern ServiceNow '
            'learning concepts.',
        'icon': Icons.cloud_done_outlined,
      },
      {
        'title': 'Java Full Stack with React JS and AI',
        'organization': 'Professional Training & Certification',
        'description':
        'Training focused on Java full-stack development, React JS '
            'and AI-oriented application development concepts.',
        'icon': Icons.code_rounded,
      },
      {
        'title': 'Prompt Engineering for ChatGPT',
        'organization': 'Professional Certification',
        'description':
        'Certification focused on prompt engineering techniques and '
            'effective interaction with AI-powered language models.',
        'icon': Icons.auto_awesome_outlined,
      },
      {
        'title': 'Java & SQL Development Program',
        'organization': 'EXL & TNS India Foundation',
        'description':
        'Development program covering Java programming and SQL '
            'fundamentals with practical software development learning.',
        'icon': Icons.storage_outlined,
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
                'Certifications',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Certifications and learning programs that support my '
                    'software development journey.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: theme.colorScheme.onSurface.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              LayoutBuilder(
                builder: (context, constraints) {


                  return GridView.builder(
                    shrinkWrap: true,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    itemCount: certifications.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth < 700 ? 1 : 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: constraints.maxWidth < 600
                          ? 260
                          : 230,
                    ),
                    itemBuilder: (context, index) {
                      return _CertificationCard(
                        certification: certifications[index],
                        number: index + 1,
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

class _CertificationCard extends StatefulWidget {
  final Map<String, dynamic> certification;
  final int number;

  const _CertificationCard({
    required this.certification,
    required this.number,
  });

  @override
  State<_CertificationCard> createState() =>
      _CertificationCardState();
}

class _CertificationCardState
    extends State<_CertificationCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return FloatingCard(
      padding: const EdgeInsets.all(20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: primary.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Icon(
                    widget.certification['icon']
                    as IconData,
                    color: primary,
                    size: 27,
                  ),
                ),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '#${widget.number}',
                    style: TextStyle(
                      color: primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              'CERTIFICATION',
              style: TextStyle(
                color: primary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              widget.certification['title'] as String,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              widget.certification['organization']
              as String,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: primary,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: Text(
                widget.certification['description']
                as String,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.55,
                  color:
                  theme.colorScheme.onSurface.withValues(
                    alpha: 0.70,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}