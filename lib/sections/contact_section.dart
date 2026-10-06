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
              // =================================================
              // HEADER
              // =================================================

              Text(
                'Let’s Connect',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Let’s build something meaningful together.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(
                    alpha: 0.70,
                  ),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              // =================================================
              // CONTACT CARD
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: primary.withValues(alpha: 0.12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withValues(alpha: 0.05),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 700;

                    if (isMobile) {
                      return Column(
                        children: [
                          _ContactIntro(),
                          const SizedBox(height: 30),
                          _ContactItems(
                            onEmail: _sendEmail,
                            onGitHub: () => _openUrl(
                              'https://github.com/Ashish956175',
                            ),
                            onLinkedIn: () => _openUrl(
                              'https://linkedin.com/in/ashish9561/',
                            ),
                          ),
                        ],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: _ContactIntro(),
                        ),
                        const SizedBox(width: 50),
                        Expanded(
                          flex: 6,
                          child: _ContactItems(
                            onEmail: _sendEmail,
                            onGitHub: () => _openUrl(
                              'https://github.com/Ashish956175',
                            ),
                            onLinkedIn: () => _openUrl(
                              'https://linkedin.com/in/ashish9561/',
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 50),

              // =================================================
              // AVAILABILITY
              // =================================================

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withValues(
                            alpha: 0.35,
                          ),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 9),
                  Text(
                    'Open to software development opportunities',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.65,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // =================================================
              // FOOTER
              // =================================================

              Divider(
                color: theme.dividerColor.withValues(
                  alpha: 0.4,
                ),
              ),

              const SizedBox(height: 22),

              Text(
                'Think. Create. Evolve.',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Built with Flutter • © ${DateTime.now().year} Ashish',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(
                    alpha: 0.55,
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

// ==========================================================
// CONTACT INTRO
// ==========================================================

class _ContactIntro extends StatelessWidget {
  const _ContactIntro();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: primary.withValues(alpha: 0.15),
            ),
          ),
          child: Icon(
            Icons.handshake_outlined,
            size: 32,
            color: primary,
          ),
        ),

        const SizedBox(height: 22),

        Text(
          'Let’s build something together.',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            height: 1.25,
          ),
        ),

        const SizedBox(height: 14),

        Text(
          'I’m interested in software development opportunities, '
              'collaborative projects, and building practical applications '
              'that solve real-world problems.',
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.7,
            color: theme.colorScheme.onSurface.withValues(
              alpha: 0.70,
            ),
          ),
        ),

        const SizedBox(height: 18),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            color: primary.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Flutter • Java • Spring Boot • AWS',
            style: theme.textTheme.bodySmall?.copyWith(
              color: primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

// ==========================================================
// CONTACT ITEMS
// ==========================================================

class _ContactItems extends StatelessWidget {
  final VoidCallback onEmail;
  final VoidCallback onGitHub;
  final VoidCallback onLinkedIn;

  const _ContactItems({
    required this.onEmail,
    required this.onGitHub,
    required this.onLinkedIn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ContactItem(
          icon: Icons.email_outlined,
          title: 'Email',
          value: 'ashishgaikwad9561@gmail.com',
          onTap: onEmail,
        ),

        const SizedBox(height: 14),

        _ContactItem(
          icon: Icons.code_rounded,
          title: 'GitHub',
          value: 'github.com/Ashish956175',
          onTap: onGitHub,
        ),

        const SizedBox(height: 14),

        _ContactItem(
          icon: Icons.work_outline_rounded,
          title: 'LinkedIn',
          value: 'linkedin.com/in/ashish9561',
          onTap: onLinkedIn,
        ),
      ],
    );
  }
}

// ==========================================================
// CONTACT ITEM
// ==========================================================

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
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(
            isHovered ? 4 : 0,
            0,
            0,
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isHovered
                ? primary.withValues(alpha: 0.06)
                : theme.scaffoldBackgroundColor.withValues(
              alpha: 0.35,
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isHovered
                  ? primary.withValues(alpha: 0.25)
                  : theme.dividerColor.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  widget.icon,
                  color: primary,
                  size: 22,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.60,
                        ),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.value,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_outward_rounded,
                size: 19,
                color: isHovered
                    ? primary
                    : theme.colorScheme.onSurface.withValues(
                  alpha: 0.45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}