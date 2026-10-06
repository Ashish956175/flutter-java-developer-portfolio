import 'dart:math' as math;

import 'package:flutter/material.dart';

class HeroAmbientBackground extends StatefulWidget {
  final Widget child;

  const HeroAmbientBackground({
    super.key,
    required this.child,
  });

  @override
  State<HeroAmbientBackground> createState() =>
      _HeroAmbientBackgroundState();
}

class _HeroAmbientBackgroundState extends State<HeroAmbientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final List<_Star> _stars;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _stars = _createStars();
  }

  List<_Star> _createStars() {
    final random = math.Random(9561);

    return List.generate(75, (_) {
      return _Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: 0.7 + random.nextDouble() * 2.0,
        opacity: 0.25 + random.nextDouble() * 0.65,
        speed: 0.5 + random.nextDouble() * 1.5,
        phase: random.nextDouble() * math.pi * 2,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        // Animated background stays behind the Hero content.
        Positioned.fill(
          child: IgnorePointer(
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _HeroBackgroundPainter(
                      primary: primary,
                      isDark: isDark,
                      stars: _stars,
                      animationValue: _controller.value,
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        // Hero content stays above the background.
        widget.child,
      ],
    );
  }
}

class _Star {
  final double x;
  final double y;
  final double size;
  final double opacity;
  final double speed;
  final double phase;

  const _Star({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.speed,
    required this.phase,
  });
}

class _HeroBackgroundPainter extends CustomPainter {
  final Color primary;
  final bool isDark;
  final List<_Star> stars;
  final double animationValue;

  _HeroBackgroundPainter({
    required this.primary,
    required this.isDark,
    required this.stars,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawAmbientGlow(canvas, size);
    _drawStars(canvas, size);
  }

  // ------------------------------------------------------------
  // AMBIENT GLOW
  // ------------------------------------------------------------

  void _drawAmbientGlow(
      Canvas canvas,
      Size size,
      ) {
    final progress = animationValue * math.pi * 2;

    final x1 = math.sin(progress) * 45;
    final y1 = math.cos(progress * 0.8) * 30;

    final x2 = math.cos(progress * 0.7) * 55;
    final y2 = math.sin(progress * 0.9) * 40;

    _drawGlow(
      canvas,
      Offset(
        -90 + x1 + 110,
        -80 + y1 + 110,
      ),
      220,
      isDark ? 0.055 : 0.075,
    );

    _drawGlow(
      canvas,
      Offset(
        size.width - 100 + x2 - 125,
        size.height - 80 + y2 - 125,
      ),
      250,
      isDark ? 0.045 : 0.065,
    );

    _drawGlow(
      canvas,
      Offset(
        size.width - 60,
        160 + y2,
      ),
      120,
      isDark ? 0.025 : 0.035,
    );
  }

  void _drawGlow(
      Canvas canvas,
      Offset center,
      double size,
      double opacity,
      ) {
    final radius = size / 2;

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          primary.withValues(alpha: opacity),
          primary.withValues(alpha: 0),
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      );

    canvas.drawCircle(
      center,
      radius,
      paint,
    );
  }

  // ------------------------------------------------------------
  // STARS
  // ------------------------------------------------------------

  void _drawStars(
      Canvas canvas,
      Size size,
      ) {
    for (final star in stars) {
      final twinkle =
          (math.sin(
            animationValue *
                math.pi *
                2 *
                star.speed +
                star.phase,
          ) +
              1) /
              2;

      final opacity =
          star.opacity * (0.45 + twinkle * 0.55);

      // Very slow vertical movement.
      final movement =
          (animationValue * star.speed * 8) % 1;

      final x = star.x * size.width;

      final y =
          ((star.y + movement) % 1) *
              size.height;

      final paint = Paint()
        ..color = Colors.white.withValues(
          alpha: isDark
              ? opacity
              : opacity * 0.35,
        );

      canvas.drawCircle(
        Offset(x, y),
        star.size,
        paint,
      );

      // A few stars get a subtle glow.
      if (star.size > 2.0) {
        final glowPaint = Paint()
          ..color = primary.withValues(
            alpha: opacity * 0.12,
          )
          ..maskFilter = const MaskFilter.blur(
            BlurStyle.normal,
            4,
          );

        canvas.drawCircle(
          Offset(x, y),
          star.size * 2.5,
          glowPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(
      covariant _HeroBackgroundPainter oldDelegate,
      ) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.primary != primary ||
        oldDelegate.isDark != isDark;
  }
}