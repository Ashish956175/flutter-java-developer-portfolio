import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class HangingIdCard extends StatefulWidget {
  const HangingIdCard({super.key});

  @override
  State<HangingIdCard> createState() => _HangingIdCardState();
}

class _HangingIdCardState extends State<HangingIdCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  bool _isDragging = false;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController.unbounded(
      vsync: this,
      value: 0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ============================================================
  // PENDULUM PHYSICS
  // ============================================================

  void _settle({double velocity = 0}) {
    _controller.animateWith(
      SpringSimulation(
        const SpringDescription(
          mass: 1.15,
          stiffness: 58,
          damping: 6.5,
        ),
        _controller.value,
        0,
        velocity,
      ),
    );
  }

  void _onTap() {
    final direction = _controller.value >= 0 ? -1.0 : 1.0;

    _controller.animateWith(
      SpringSimulation(
        const SpringDescription(
          mass: 1.05,
          stiffness: 62,
          damping: 5.8,
        ),
        _controller.value,
        direction * 0.015,
        direction * 3.4,
      ),
    );
  }

  // ============================================================
  // DRAG START
  // ============================================================

  void _onPanStart(DragStartDetails details) {
    _controller.stop();

    setState(() {
      _isDragging = true;
    });
  }

  // ============================================================
  // DRAG UPDATE
  // ============================================================

  void _onPanUpdate(DragUpdateDetails details) {
    const sensitivity = 0.0085;

    final newAngle = (
        _controller.value + details.delta.dx * sensitivity
    ).clamp(-0.95, 0.95);

    _controller.value = newAngle;
  }

  // ============================================================
  // DRAG END
  // ============================================================

  void _onPanEnd(DragEndDetails details) {
    final velocity =
        details.velocity.pixelsPerSecond.dx * 0.004;

    setState(() {
      _isDragging = false;
    });

    _settle(
      velocity: velocity.clamp(-4.0, 4.0),
    );
  }

  // ============================================================
  // MAIN BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: _isDragging
          ? SystemMouseCursors.grabbing
          : SystemMouseCursors.grab,
      onEnter: (_) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: SizedBox(
          width: 520,
          height: 770,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform(
                // The whole hanging assembly rotates from
                // the actual hanging point.
                alignment: Alignment.topCenter,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0018)
                  ..rotateZ(_controller.value),
                child: child,
              );
            },
            child: _buildHangingAssembly(context),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HANGING ASSEMBLY
  // ============================================================

  Widget _buildHangingAssembly(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        // --------------------------------------------------------
        // RIBBON
        // --------------------------------------------------------

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 205,
          child: CustomPaint(
            painter: _PremiumRibbonPainter(
              primary: primary,
            ),
          ),
        ),

        // --------------------------------------------------------
        // ID CARD
        // --------------------------------------------------------

        Positioned(
          top: 174,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(
              0,
              _isHovering && !_isDragging ? -4 : 0,
              0,
            ),
            child: _buildCard(context),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PREMIUM ID CARD
  // ============================================================

  Widget _buildCard(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Container(
      width: 380,
      height: 575,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF172D59),
            Color(0xFF0C1A37),
            Color(0xFF11162D),
            Color(0xFF171331),
            Color(0xFF091A38),
          ],
          stops: [
            0.0,
            0.25,
            0.52,
            0.78,
            1.0,
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.44),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.55),
            blurRadius: 36,
            spreadRadius: 3,
            offset: const Offset(0, 24),
          ),
          BoxShadow(
            color: primary.withValues(alpha: 0.27),
            blurRadius: 38,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: const Color(0xFF725CFF).withValues(alpha: 0.13),
            blurRadius: 55,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(27),
        child: Stack(
          children: [
            // ==================================================
            // BACKGROUND ACCENTS
            // ==================================================

            Positioned.fill(
              child: CustomPaint(
                painter: _CardAccentPainter(
                  primary: primary,
                ),
              ),
            ),

            // ==================================================
            // HEADER
            // ==================================================

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 94,
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  22,
                  18,
                  22,
                  14,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF9AB9F2),
                      Color(0xFF586DB8),
                      Color(0xFF34336F),
                    ],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Code icon
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.white.withValues(alpha: 0.10),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.30),
                        ),
                      ),
                      child: const Icon(
                        Icons.code_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),

                    const SizedBox(width: 13),

                    // Header text
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DEVELOPER IDENTITY',
                            style: TextStyle(
                              color: Colors.white.withValues(
                                alpha: 0.78,
                              ),
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'SOFTWARE ENGINEER',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ID number
                    const Text(
                      'AS-DEV-2026',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ==================================================
            // SECURITY STRIP
            // ==================================================

            Positioned(
              top: 94,
              left: 0,
              right: 0,
              height: 4,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF20C4FF),
                      Color(0xFF655CFF),
                      Color(0xFFED73FF),
                    ],
                  ),
                ),
              ),
            ),

            // ==================================================
            // PROFILE PHOTO
            // ==================================================

            Positioned(
              top: 118,
              left: 0,
              right: 0,
              child: Center(
                child: _buildProfilePhoto(primary),
              ),
            ),

            // ==================================================
            // NAME + ROLE
            // ==================================================

            Positioned(
              top: 270,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  const Text(
                    'ASHISH GAIKWAD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Flutter & Java Developer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primary.withValues(alpha: 0.95),
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            // ==================================================
            // TECHNOLOGY BADGES
            // ==================================================

            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _PremiumBadge(
                    text: 'FLUTTER',
                    icon: Icons.flutter_dash,
                  ),
                  SizedBox(width: 8),
                  _PremiumBadge(
                    text: 'JAVA',
                    icon: Icons.coffee_rounded,
                  ),
                  SizedBox(width: 8),
                  _PremiumBadge(
                    text: 'SPRING',
                    icon: Icons.eco_outlined,
                  ),
                ],
              ),
            ),

            // ==================================================
            // DETAILS PANEL
            // ==================================================

            Positioned(
              top: 405,
              left: 24,
              right: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    _CardInfoRow(
                      icon: Icons.badge_outlined,
                      label: 'ROLE',
                      value: 'SOFTWARE DEVELOPER',
                    ),
                    SizedBox(height: 11),
                    _CardInfoRow(
                      icon: Icons.layers_outlined,
                      label: 'STACK',
                      value: 'FLUTTER • JAVA • SPRING BOOT',
                    ),
                    SizedBox(height: 11),
                    _CardInfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'BASE',
                      value: 'PUNE, MAHARASHTRA',
                    ),
                  ],
                ),
              ),
            ),

            // ==================================================
            // BARCODE
            // ==================================================

            Positioned(
              left: 25,
              bottom: 28,
              child: _buildBarcode(),
            ),

            // ==================================================
            // YEAR
            // ==================================================

            const Positioned(
              right: 25,
              bottom: 30,
              child: Text(
                '2026',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            // ==================================================
            // GLASS REFLECTION
            // ==================================================

            Positioned(
              top: -100,
              right: -120,
              child: IgnorePointer(
                child: Transform.rotate(
                  angle: -0.45,
                  child: Container(
                    width: 230,
                    height: 620,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.07),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PROFILE PHOTO
  // ============================================================

  Widget _buildProfilePhoto(Color primary) {
    return Container(
      width: 140,
      height: 140,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE7F7FF),
            Color(0xFF19C2FF),
            Color(0xFF715CFF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.46),
            blurRadius: 27,
            spreadRadius: 3,
          ),
          BoxShadow(
            color: const Color(0xFF765CFF).withValues(alpha: 0.17),
            blurRadius: 42,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF07111F),
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/images/profile_image.png',
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BARCODE
  // ============================================================

  Widget _buildBarcode() {
    return SizedBox(
      width: 78,
      height: 27,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(
          22,
              (index) {
            final width = index % 3 == 0 ? 2.4 : 1.0;

            return Container(
              width: width,
              margin: const EdgeInsets.only(right: 1.4),
              color: Colors.white.withValues(alpha: 0.68),
            );
          },
        ),
      ),
    );
  }
}

// ================================================================
// PREMIUM TECHNOLOGY BADGE
// ================================================================

class _PremiumBadge extends StatelessWidget {
  final String text;
  final IconData icon;

  const _PremiumBadge({
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.14),
            Colors.black.withValues(alpha: 0.20),
          ],
        ),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.19),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13,
            color: Colors.white70,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 8.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// CARD INFORMATION ROW
// ================================================================

class _CardInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _CardInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
          color: Colors.white54,
        ),

        const SizedBox(width: 9),

        SizedBox(
          width: 42,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 7,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),

        const SizedBox(width: 5),

        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 8,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }
}

// ================================================================
// PREMIUM RIBBON PAINTER
// ================================================================

class _PremiumRibbonPainter extends CustomPainter {
  final Color primary;

  _PremiumRibbonPainter({
    required this.primary,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.width / 2;

    // ------------------------------------------------------------
    // LEFT RIBBON
    // ------------------------------------------------------------

    final leftRibbon = Path()
      ..moveTo(center - 7, 34)
      ..lineTo(center - 68, 180)
      ..lineTo(center - 42, 194)
      ..lineTo(center + 1, 43)
      ..close();

    final leftPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2589FF),
          Color(0xFF0755C9),
          Color(0xFF172B70),
          Color(0xFF301C70),
        ],
      ).createShader(
        Rect.fromLTWH(
          center - 75,
          20,
          80,
          180,
        ),
      );

    canvas.drawPath(
      leftRibbon,
      leftPaint,
    );

    // ------------------------------------------------------------
    // RIGHT RIBBON
    // ------------------------------------------------------------

    final rightRibbon = Path()
      ..moveTo(center + 7, 34)
      ..lineTo(center + 68, 180)
      ..lineTo(center + 42, 194)
      ..lineTo(center - 1, 43)
      ..close();

    final rightPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF58C3FF),
          Color(0xFF2869DF),
          Color(0xFF18397F),
          Color(0xFF4B2384),
        ],
      ).createShader(
        Rect.fromLTWH(
          center,
          20,
          80,
          180,
        ),
      );

    canvas.drawPath(
      rightRibbon,
      rightPaint,
    );

    // ------------------------------------------------------------
    // RIBBON HIGHLIGHTS
    // ------------------------------------------------------------

    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.22)
      ..strokeWidth = 1.7
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(center - 5, 37),
      Offset(center - 53, 173),
      highlightPaint,
    );

    canvas.drawLine(
      Offset(center + 5, 37),
      Offset(center + 53, 173),
      highlightPaint,
    );

    // ------------------------------------------------------------
    // METAL CONNECTOR
    // ------------------------------------------------------------

    final connectorPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFF6FAFF),
          Color(0xFF7189AD),
          Color(0xFF16253B),
        ],
      ).createShader(
        Rect.fromLTWH(
          center - 12,
          28,
          24,
          34,
        ),
      );

    final connector = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center, 45),
        width: 21,
        height: 35,
      ),
      const Radius.circular(7),
    );

    canvas.drawRRect(
      connector,
      connectorPaint,
    );

    // ------------------------------------------------------------
    // METAL RING
    // ------------------------------------------------------------

    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFFFFFFF),
          Color(0xFF7187A8),
          Color(0xFF15243A),
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(center, 18),
          radius: 13,
        ),
      );

    canvas.drawCircle(
      Offset(center, 18),
      12,
      ringPaint,
    );

    canvas.drawCircle(
      Offset(center, 18),
      5,
      Paint()..color = const Color(0xFF07101E),
    );
  }

  @override
  bool shouldRepaint(
      covariant _PremiumRibbonPainter oldDelegate,
      ) {
    return oldDelegate.primary != primary;
  }
}

// ================================================================
// CARD BACKGROUND ACCENTS
// ================================================================

class _CardAccentPainter extends CustomPainter {
  final Color primary;

  _CardAccentPainter({
    required this.primary,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // ------------------------------------------------------------
    // TOP-RIGHT HOLOGRAPHIC SHAPE
    // ------------------------------------------------------------

    final topPath = Path()
      ..moveTo(size.width - 155, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, 185)
      ..lineTo(size.width - 78, 110)
      ..close();

    final topPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF238BFF),
          Color(0xFF563DCC),
          Color(0x00000000),
        ],
      ).createShader(
        Rect.fromLTWH(
          size.width - 175,
          0,
          175,
          200,
        ),
      );

    canvas.drawPath(
      topPath,
      topPaint,
    );

    // ------------------------------------------------------------
    // BOTTOM-RIGHT HOLOGRAPHIC SHAPE
    // ------------------------------------------------------------

    final bottomPath = Path()
      ..moveTo(size.width - 175, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height - 120)
      ..quadraticBezierTo(
        size.width - 92,
        size.height - 72,
        size.width - 175,
        size.height,
      )
      ..close();

    final bottomPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0x00000000),
          Color(0xFF155EFF),
          Color(0xFF7C4DFF),
        ],
      ).createShader(
        Rect.fromLTWH(
          size.width - 185,
          size.height - 130,
          185,
          130,
        ),
      );

    canvas.drawPath(
      bottomPath,
      bottomPaint,
    );

    // ------------------------------------------------------------
    // VERY SUBTLE SECURITY CURVES
    // ------------------------------------------------------------

    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = primary.withValues(alpha: 0.075);

    final line1 = Path()
      ..moveTo(-20, 185)
      ..quadraticBezierTo(
        size.width * 0.35,
        125,
        size.width + 30,
        210,
      );

    final line2 = Path()
      ..moveTo(-20, 200)
      ..quadraticBezierTo(
        size.width * 0.35,
        140,
        size.width + 30,
        225,
      );

    canvas.drawPath(
      line1,
      linePaint,
    );

    canvas.drawPath(
      line2,
      linePaint,
    );
  }

  @override
  bool shouldRepaint(
      covariant _CardAccentPainter oldDelegate,
      ) {
    return oldDelegate.primary != primary;
  }
}