import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<void> _sendEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'ashishgaikwad9561@gmail.com',
      queryParameters: {
        'subject': 'Software Development Opportunity',
      },
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        24,
        80,
        24,
        40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1100,
          ),
          child: Column(
            children: [
              Text(
                'Let’s Connect',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'I am open to software development opportunities, '
                    'internships, and interesting projects.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: theme.textTheme.bodyMedium?.color?.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: primary.withValues(alpha: 0.15),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Have an opportunity or project in mind?',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Feel free to reach out through any of the '
                          'platforms below.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color?.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isMobile = constraints.maxWidth < 700;

                        final items = [
                          _ContactItem(
                            icon: Icons.email_outlined,
                            title: 'Email',
                            value: 'ashishgaikwad9561@gmail.com',
                            onTap: _sendEmail,
                          ),

                          _ContactItem(
                            icon: Icons.code_outlined,
                            title: 'GitHub',
                            value: 'github.com/Ashish956175',
                            onTap: () => _openUrl(
                              'https://github.com/Ashish956175',
                            ),
                          ),

                          _ContactItem(
                            icon: Icons.work_outline,
                            title: 'LinkedIn',
                            value: 'linkedin.com/in/ashish9561/',
                            onTap: () => _openUrl(
                              'https://linkedin.com/in/ashish9561/',
                            ),
                          ),
                        ];

                        if (isMobile) {
                          return Column(
                            children: [
                              for (int i = 0; i < items.length; i++) ...[
                                items[i],
                                if (i != items.length - 1)
                                  const SizedBox(height: 20),
                              ],
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Expanded(
                              child: items[0],
                            ),

                            const SizedBox(width: 20),

                            Expanded(
                              child: items[1],
                            ),

                            const SizedBox(width: 20),

                            Expanded(
                              child: items[2],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 45),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.code_outlined,
                    size: 16,
                    color: theme.textTheme.bodySmall?.color?.withValues(
                      alpha: 0.6,
                    ),
                  ),

                  const SizedBox(width: 7),

                  Text(
                    'Built with Flutter',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Text(
                    '•',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: primary,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Text(
                    '© ${DateTime.now().year} Ashish',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

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

      child: GestureDetector(
        onTap: widget.onTap,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),

          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: isHovered
                ? primary.withValues(alpha: 0.07)
                : Colors.transparent,

            borderRadius: BorderRadius.circular(16),

            border: Border.all(
              color: isHovered
                  ? primary.withValues(alpha: 0.25)
                  : Colors.transparent,
            ),
          ),

          child: Column(
            children: [
              Container(
                height: 56,
                width: 56,

                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Icon(
                  widget.icon,
                  color: primary,
                  size: 27,
                ),
              ),

              const SizedBox(height: 13),

              Text(
                widget.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                widget.value,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  height: 1.4,
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Open',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}