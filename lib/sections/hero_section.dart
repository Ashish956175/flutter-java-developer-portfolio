import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 70,
        vertical: isMobile ? 50 : 100,
      ),
      child: isMobile
          ? _mobileHero(context)
          : _desktopHero(context),
    );
  }

  Widget _desktopHero(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: _content(context),
        ),

        const SizedBox(width: 50),

        Expanded(
          flex: 4,
          child: _profileVisual(context),
        ),
      ],
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
    final primaryColor =
        Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, I am',
          style: Theme.of(context).textTheme.titleLarge,
        ),

        const SizedBox(height: 8),

        Text(
          'Ashish',
          style: TextStyle(
            fontSize: 58,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Flutter & Java Backend Developer',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Computer Engineering graduate from '
              'Savitribai Phule Pune University (SPPU), '
              'focused on building practical applications '
              'using Flutter, Java and Spring Boot.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),

        const SizedBox(height: 30),

        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.work_outline),
              label: const Text('View Projects'),
            ),

            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_outlined),
              label: const Text('Download Resume'),
            ),
          ],
        ),

        const SizedBox(height: 30),

        Row(
          children: [
            _socialButton(
              context,
              Icons.code,
              'GitHub',
            ),
            const SizedBox(width: 12),
            _socialButton(
              context,
              Icons.business_center_outlined,
              'LinkedIn',
            ),
            const SizedBox(width: 12),
            _socialButton(
              context,
              Icons.email_outlined,
              'Email',
            ),
          ],
        ),
      ],
    );
  }

  Widget _profileVisual(BuildContext context) {
    final primaryColor =
        Theme.of(context).colorScheme.primary;

    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColor.withOpacity(0.10),
        border: Border.all(
          color: primaryColor.withOpacity(0.25),
          width: 2,
        ),
      ),
      child: Icon(
        Icons.code,
        size: 120,
        color: primaryColor,
      ),
    );
  }

  Widget _socialButton(
      BuildContext context,
      IconData icon,
      String label,
      ) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}