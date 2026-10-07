import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/hero_ambient_background.dart';
import '../utils/link_launcher.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewProjects;

  const HeroSection({
    super.key,
    required this.onViewProjects,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _profileController;

  Timer? _clickTimer;

  Offset _mousePosition = Offset.zero;

  bool _isHoveringProfile = false;
  bool _isClicked = false;

  @override
  void initState() {
    super.initState();

    _profileController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    );
  }

  @override
  void dispose() {
    _clickTimer?.cancel();
    _profileController.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------
  // RESUME
  // ------------------------------------------------------------

  Future<void> _openResume() async {
    final uri = Uri.base.resolve(
      'resume/Ashish_Resume.pdf',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  // ------------------------------------------------------------
  // PROFILE HOVER
  // ------------------------------------------------------------

  void _onProfileHover(PointerHoverEvent event) {
    final renderObject = context.findRenderObject();

    if (renderObject is! RenderBox) {
      return;
    }

    final localPosition = renderObject.globalToLocal(
      event.position,
    );

    setState(() {
      _mousePosition = localPosition;
      _isHoveringProfile = true;
    });
  }

  void _onProfileExit(PointerExitEvent event) {
    setState(() {
      _mousePosition = Offset.zero;
      _isHoveringProfile = false;
    });
  }

  // ------------------------------------------------------------
  // PROFILE CLICK ANIMATION
  // ------------------------------------------------------------

  void _animateProfile() {
    _clickTimer?.cancel();

    setState(() {
      _isClicked = true;
    });

    _profileController.forward(from: 0);

    _clickTimer = Timer(
      const Duration(
        milliseconds: 1250,
      ),
          () {
        if (!mounted) return;

        setState(() {
          _isClicked = false;
        });
      },
    );
  }

  // ------------------------------------------------------------
  // MAIN BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return HeroAmbientBackground(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 70,
          vertical: isMobile ? 55 : 90,
        ),
        child: isMobile
            ? _mobileHero(context)
            : _desktopHero(context),
      ),
    );
  }

  // ------------------------------------------------------------
  // DESKTOP HERO
  // ------------------------------------------------------------

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

  // ------------------------------------------------------------
  // MOBILE HERO
  // ------------------------------------------------------------

  Widget _mobileHero(BuildContext context) {
    return Column(
      children: [
        _profileVisual(context),
        const SizedBox(height: 45),
        _content(context),
      ],
    );
  }

  // ------------------------------------------------------------
  // CONTENT
  // ------------------------------------------------------------

  Widget _content(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --------------------------------------------------------
        // GREETING
        // --------------------------------------------------------

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

        // --------------------------------------------------------
        // NAME
        // --------------------------------------------------------

        Text(
          'Ashish',
          style: TextStyle(
            fontSize: isMobile ? 46 : 64,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.5,
            color: theme.colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 8),

        // --------------------------------------------------------
        // ROLE
        // --------------------------------------------------------

        Text(
          'Flutter & Java Developer',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: primaryColor,
          ),
        ),

        const SizedBox(height: 20),

        // --------------------------------------------------------
        // TAGLINE
        // --------------------------------------------------------

        Text(
          'Think. Create. Evolve.',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 18),

        // --------------------------------------------------------
        // DESCRIPTION
        // --------------------------------------------------------

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

        // --------------------------------------------------------
        // MAIN BUTTONS
        // --------------------------------------------------------

        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: widget.onViewProjects,
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

        // --------------------------------------------------------
        // SOCIAL BUTTONS
        // --------------------------------------------------------

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _socialButton(
              context,
              Icons.code_rounded,
              'GitHub',
                    (){
                      LinkLauncher.openUrl(
                        context,
                        'https://github.com/Ashish956175'
                      );
                    }
            ),
            _socialButton(
              context,
              Icons.business_center_outlined,
              'LinkedIn',
                  (){
                      LinkLauncher.openUrl(
                        context,
                        'https://linkedin.com/in/ashish9561'
                      );
                    }
            ),
            _socialButton(
              context,
              Icons.email_outlined,
              'Email',
                (){
                LinkLauncher.sendEmail(context);
                }
            ),
          ],
        ),

        const SizedBox(height: 28),

        // --------------------------------------------------------
        // AVAILABILITY
        // --------------------------------------------------------

        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
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

  // ------------------------------------------------------------
  // ANIMATED PROFILE
  // ------------------------------------------------------------

  Widget _profileVisual(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    final width = MediaQuery.of(context).size.width;

    final size = width < 600
        ? 250.0
        : 340.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: _onProfileHover,
      onExit: _onProfileExit,
      child: GestureDetector(
        onTap: _animateProfile,
        child: AnimatedBuilder(
          animation: _profileController,
          builder: (context, child) {
            final progress = _profileController.value;

            // ----------------------------------------------------
            // CLICK PULSE
            // ----------------------------------------------------

            final pulse = math.sin(
              progress * math.pi,
            );

            final clickScale =
                1.0 + (pulse * 0.045);

            // ----------------------------------------------------
            // CLICK ROTATION
            // ----------------------------------------------------

            final clickRotation =
                math.sin(
                  progress * math.pi * 2,
                ) *
                    0.025;

            // ----------------------------------------------------
            // MOUSE TILT
            // ----------------------------------------------------

            double mouseTiltX = 0;
            double mouseTiltY = 0;

            if (_isHoveringProfile) {
              final center = Offset(
                size / 2,
                size / 2,
              );

              final dx =
                  (_mousePosition.dx - center.dx) /
                      center.dx;

              final dy =
                  (_mousePosition.dy - center.dy) /
                      center.dy;

              mouseTiltY = dx.clamp(-1.0, 1.0) * 0.07;
              mouseTiltX = -dy.clamp(-1.0, 1.0) * 0.07;
            }

            return TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 1,
                end: clickScale,
              ),
              duration: const Duration(
                milliseconds: 100,
              ),
              curve: Curves.easeOut,
              builder: (
                  context,
                  scale,
                  profileChild,
                  ) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(
                      3,
                      2,
                      0.0015,
                    )
                    ..rotateX(
                      mouseTiltX,
                    )
                    ..rotateY(
                      mouseTiltY,
                    )
                    ..rotateZ(
                      clickRotation,
                    )
                    ..translateByDouble(
                      0.0,
                      _isHoveringProfile ? -5.0 : 0.0,
                      0.0,
                      1.0,
                    )
                    ..scaleByDouble(
                      scale,
                      scale,
                      scale,
                      1.0,
                    ),
                  child: profileChild,
                );
              },
              child: _profileContainer(
                context,
                size,
                primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // PROFILE CONTAINER
  // ------------------------------------------------------------

  Widget _profileContainer(
      BuildContext context,
      double size,
      Color primaryColor,
      ) {
    final theme = Theme.of(context);

    final isDark =
        theme.brightness == Brightness.dark;

    final glowStrength =
    _isClicked ? 0.34 : 0.16;

    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 300,
      ),
      width: size,
      height: size,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        // Outer blue glow.
        boxShadow: [
          BoxShadow(
            color: primaryColor.withValues(
              alpha: glowStrength,
            ),
            blurRadius: _isClicked ? 65 : 38,
            spreadRadius: _isClicked ? 12 : 5,
          ),

          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.10,
              ),
              blurRadius: 24,
              offset: const Offset(
                0,
                12,
              ),
            ),
        ],
      ),

      child: Stack(
        alignment: Alignment.center,
        children: [
          // ------------------------------------------------------
          // PROFILE IMAGE
          // ------------------------------------------------------

          AnimatedScale(
            scale: _isClicked ? 1.025 : 1.0,
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.easeOutBack,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,

                border: Border.all(
                  color: primaryColor.withValues(
                    alpha: _isClicked ? 0.95 : 0.75,
                  ),
                  width: _isClicked ? 4 : 3,
                ),
              ),

              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile_image.png',
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),

          // ------------------------------------------------------
          // INNER LIGHT RING
          // ------------------------------------------------------

          IgnorePointer(
            child: Container(
              width: size * 0.90,
              height: size * 0.90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(
                    alpha: isDark ? 0.12 : 0.20,
                  ),
                  width: 1,
                ),
              ),
            ),
          ),

          // ------------------------------------------------------
          // CLICK RIPPLE RING
          // ------------------------------------------------------

          if (_isClicked)
            IgnorePointer(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: 0.85,
                  end: 1.15,
                ),
                duration: const Duration(
                  milliseconds: 700,
                ),
                curve: Curves.easeOut,
                builder: (
                    context,
                    rippleScale,
                    child,
                    ) {
                  return Transform.scale(
                    scale: rippleScale,
                    child: Container(
                      width: size * 0.90,
                      height: size * 0.90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primaryColor.withValues(
                            alpha: 0.35,
                          ),
                          width: 2,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // SOCIAL BUTTON
  // ------------------------------------------------------------

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