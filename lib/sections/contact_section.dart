import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
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
                'I am open to software development opportunities, internships, and interesting projects.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(
                      alpha: 0.15,
                    ),
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 650;

                    final content = [
                      _ContactItem(
                        icon: Icons.email_outlined,
                        title: 'Email',
                        value: 'ashishgaikwad9561@gmail.com',
                      ),
                      _ContactItem(
                        icon: Icons.code_outlined,
                        title: 'GitHub',
                        value: 'github.com/Ashish956175',
                      ),
                      _ContactItem(
                        icon: Icons.work_outline,
                        title: 'LinkedIn',
                        value: 'linkedin.com/in/ashish9561/',
                      ),
                    ];

                    if (isMobile) {
                      return Column(
                        children: [
                          for (int i = 0; i < content.length; i++) ...[
                            content[i],
                            if (i != content.length - 1)
                              const SizedBox(height: 24),
                          ],
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(child: content[0]),
                        const SizedBox(width: 20),
                        Expanded(child: content[1]),
                        const SizedBox(width: 20),
                        Expanded(child: content[2]),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 50),

              Text(
                '© ${DateTime.now().year} Ashish. Built with Flutter.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(
              alpha: 0.10,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.primary,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          value,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}