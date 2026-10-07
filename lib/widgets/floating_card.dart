import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FloatingCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;
  final bool enableTilt;
  final bool enableHover;

  const FloatingCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = const BorderRadius.all(
      Radius.circular(20),
    ),
    this.onTap,
    this.enableTilt = true,
    this.enableHover = true,
  });

  @override
  State<FloatingCard> createState() => _FloatingCardState();
}

class _FloatingCardState extends State<FloatingCard> {
  double _rotationX = 0;
  double _rotationY = 0;

  bool _isHovered = false;

  void _handleHover(PointerHoverEvent event) {
    if (!widget.enableTilt) return;

    final renderBox = context.findRenderObject() as RenderBox?;

    if (renderBox == null || !renderBox.hasSize) {
      return;
    }

    final localPosition = renderBox.globalToLocal(
      event.position,
    );

    final size = renderBox.size;

    if (size.width <= 0 || size.height <= 0) {
      return;
    }

    final normalizedX =
        ((localPosition.dx / size.width) * 2) - 1;

    final normalizedY =
        ((localPosition.dy / size.height) * 2) - 1;

    setState(() {
      _rotationY = normalizedX * 0.045;
      _rotationX = -normalizedY * 0.045;
      _isHovered = true;
    });
  }

  void _handleEnter(PointerEnterEvent event) {
    if (!widget.enableHover) return;

    setState(() {
      _isHovered = true;
    });
  }

  void _handleExit(PointerExitEvent event) {
    setState(() {
      _rotationX = 0;
      _rotationY = 0;
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isLightMode =
        theme.brightness == Brightness.light;

    final primary = theme.colorScheme.primary;

    final defaultShadow = isLightMode
        ? [
      BoxShadow(
        color: Colors.black.withValues(
          alpha: 0.10,
        ),
        blurRadius: 24,
        offset: const Offset(0, 10),
      ),
      BoxShadow(
        color: Colors.black.withValues(
          alpha: 0.035,
        ),
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ]
        : [
      BoxShadow(
        color: Colors.black.withValues(
          alpha: 0.22,
        ),
        blurRadius: 18,
        offset: const Offset(0, 7),
      ),
    ];

    final hoverShadow = isLightMode
        ? [
      BoxShadow(
        color: Colors.black.withValues(
          alpha: 0.13,
        ),
        blurRadius: 28,
        offset: const Offset(0, 13),
      ),
      BoxShadow(
        color: primary.withValues(
          alpha: 0.06,
        ),
        blurRadius: 18,
        offset: const Offset(0, 5),
      ),
    ]
        : [
      BoxShadow(
        color: Colors.black.withValues(
          alpha: 0.27,
        ),
        blurRadius: 22,
        offset: const Offset(0, 9),
      ),
    ];

    return MouseRegion(
      // Keep the hover target fixed to the card's layout bounds. The visual
      // transform below must not move the pointer hit test with the card.
      opaque: true,
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: widget.enableHover
          ? _handleEnter
          : null,
      onHover: widget.enableTilt
          ? _handleHover
          : null,
      onExit: widget.enableHover
          ? _handleExit
          : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Transform(
          alignment: Alignment.center,
          transformHitTests: false,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0012)
            ..rotateX(_rotationX)
            ..rotateY(_rotationY)
            ..translateByDouble(
              0.0,
              _isHovered ? -4.0 : 0.0,
              0.0,
              1.0,
            ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width: double.infinity,
            padding: widget.padding,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: widget.borderRadius,
              border: Border.all(
                color: _isHovered
                    ? primary.withValues(
                  alpha: isLightMode
                      ? 0.20
                      : 0.25,
                )
                    : primary.withValues(
                  alpha: isLightMode
                      ? 0.10
                      : 0.15,
                ),
              ),
              boxShadow: _isHovered
                  ? hoverShadow
                  : defaultShadow,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
