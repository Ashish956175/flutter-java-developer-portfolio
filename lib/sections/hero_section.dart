import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewProjects;

  const HeroSection({
    super.key,
    required this.onViewProjects,
  });

  // Open external URL
  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  // Open email
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

  // Open resume
  Future<void> _openResume() async {
    final uri = Uri.base.resolve(
      'resume/resume_2_coloured.pdf',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 70,
        vertical: isMobile ? 55 : 90,
      ),
      child: isMobile
          ? _mobileHero(context)
          : _desktopHero(context),
    );
  }

  Widget _desktopHero(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 600,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: _content(context),
          ),

          const SizedBox(width: 60),

          Expanded(
            flex: 4,
            child: Center(
              child: _profileVisual(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobileHero(BuildContext context) {
    return Column(
      children: [
        _profileVisual(context),

        const SizedBox(height: 45),

        _content(context),
      ],
    );
  }

  Widget _content(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Small introduction
        Text(
          'HELLO, I AM',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
            color: primaryColor,
          ),
        ),

        const SizedBox(height: 12),

        // Name
        Text(
          'Ashish',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width < 600
                ? 46
                : 64,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.5,
            color: theme.colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 8),

        // Role
        Text(
          'Flutter & Java Developer',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: primaryColor,
          ),
        ),

        const SizedBox(height: 20),

        // Tagline
        Text(
          'Think. Create. Evolve.',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 18),

        // Description
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 650,
          ),
          child: Text(
            'Computer Engineering graduate focused on building '
                'practical and scalable applications using Flutter, '
                'Java, Spring Boot, REST APIs and modern backend technologies.',
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.7,
              color: theme.colorScheme.onSurface.withValues(
                alpha: 0.75,
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        // Main buttons
        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: onViewProjects,
              icon: const Icon(
                Icons.arrow_forward_rounded,
              ),
              label: const Text(
                'View Projects',
              ),
            ),

            OutlinedButton.icon(
              onPressed: _openResume,
              icon: const Icon(
                Icons.download_outlined,
              ),
              label: const Text(
                'Download Resume',
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        // Social buttons
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _socialButton(
              context,
              Icons.code_rounded,
              'GitHub',
                  () => _openUrl(
                'https://github.com/Ashish956175',
              ),
            ),

            _socialButton(
              context,
              Icons.business_center_outlined,
              'LinkedIn',
                  () => _openUrl(
                'https://linkedin.com/in/ashish9561/',
              ),
            ),

            _socialButton(
              context,
              Icons.email_outlined,
              'Email',
              _sendEmail,
            ),
          ],
        ),

        const SizedBox(height: 28),

        // Availability
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 9,
              height: 9,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ),

            const SizedBox(width: 9),

            Flexible(
              child: Text(
                'Open to software development opportunities',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _profileVisual(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    final width = MediaQuery.of(context).size.width;

    final size = width < 600
        ? 230.0
        : 320.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            primaryColor.withValues(alpha: 0.18),
            primaryColor.withValues(alpha: 0.05),
          ],
        ),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.35),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(alpha: 0.12),
            blurRadius: 35,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.code_rounded,
            size: size * 0.36,
            color: primaryColor,
          ),

          Positioned(
            top: size * 0.12,
            right: size * 0.15,
            child: _techIcon(
              context,
              Icons.phone_android_rounded,
            ),
          ),

          Positioned(
            bottom: size * 0.13,
            left: size * 0.14,
            child: _techIcon(
              context,
              Icons.storage_rounded,
            ),
          ),

          Positioned(
            bottom: size * 0.18,
            right: size * 0.10,
            child: _techIcon(
              context,
              Icons.cloud_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _techIcon(
      BuildContext context,
      IconData icon,
      ) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.surface,
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: primaryColor,
        size: 24,
      ),
    );
  }

  Widget _socialButton(
      BuildContext context,
      IconData icon,
      String label,
      VoidCallback onPressed,
      ) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 18,
      ),
      label: Text(label),
    );
  }
}