import 'package:flutter/material.dart';

import '../widgets/floating_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 70,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            title: 'About Me',
            subtitle: 'A little about my journey',
          ),

          const SizedBox(height: 35),

          isMobile
              ? _mobileContent(context)
              : _desktopContent(context),
        ],
      ),
    );
  }

  Widget _desktopContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _introCard(context),
        ),

        const SizedBox(width: 30),

        Expanded(
          flex: 2,
          child: _educationCard(context),
        ),
      ],
    );
  }

  Widget _mobileContent(BuildContext context) {
    return Column(
      children: [
        _introCard(context),

        const SizedBox(height: 20),

        _educationCard(context),
      ],
    );
  }

  Widget _introCard(BuildContext context) {
    return Card(
      child: FloatingCard(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.person_outline,
              size: 38,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 20),

            Text(
              'Building with curiosity and purpose.',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              'I am a Computer Engineering graduate from '
                  'Savitribai Phule Pune University (SPPU), '
                  'interested in building practical software '
                  'solutions and continuously improving my '
                  'development skills.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 15),

            Text(
              'My primary interests include Flutter mobile '
                  'and web development, Java backend development, '
                  'Spring Boot, REST APIs, databases and cloud '
                  'technologies.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _educationCard(BuildContext context) {
    return Card(
      child: FloatingCard(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.school_outlined,
              size: 38,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 20),

            const Text(
              'Education',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Bachelor of Engineering',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Computer Engineering',
            ),

            const SizedBox(height: 10),

            Text(
              'Savitribai Phule Pune University',
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .primary,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              '2019 Pattern • 2022 – 2026',
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}