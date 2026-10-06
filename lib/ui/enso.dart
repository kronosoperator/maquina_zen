import 'dart:math';

import 'package:flutter/material.dart';

/// The machine's only control: an ensō that is brushed anew for every quote.
class EnsoButton extends StatefulWidget {
  const EnsoButton({
    super.key,
    required this.progress,
    required this.seed,
    required this.semanticLabel,
    required this.onPressed,
    this.size = 104,
  });

  /// 0 → 1 as the brush travels around the circle.
  final Animation<double> progress;

  /// Each seed yields a slightly different circle.
  final int seed;
  final String semanticLabel;
  final VoidCallback onPressed;
  final double size;

  @override
  State<EnsoButton> createState() => _EnsoButtonState();
}

class _EnsoButtonState extends State<EnsoButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final still = MediaQuery.disableAnimationsOf(context);
    return Semantics(
      container: true,
      button: true,
      label: widget.semanticLabel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onPressed,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedScale(
          scale: _pressed ? 0.94 : 1,
          duration: still ? Duration.zero : const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          child: CustomPaint(
            size: Size.square(widget.size),
            painter: EnsoPainter(
              progress: widget.progress,
              seed: widget.seed,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class EnsoPainter extends CustomPainter {
  EnsoPainter({required this.progress, required this.seed, required this.color})
    : super(repaint: progress);

  final Animation<double> progress;
  final int seed;
  final Color color;

  static const _segments = 140;

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(seed);
    final startAngle = random.nextDouble() * 2 * pi;
    final sweep = 2 * pi * (0.88 + random.nextDouble() * 0.07);
    final wobblePhase = random.nextDouble() * 2 * pi;
    final bristlePhase = random.nextDouble() * 2 * pi;

    final center = size.center(Offset.zero);
    final radius = size.shortestSide * 0.39;
    final maxWidth = size.shortestSide * 0.1;
    final drawn = Curves.easeInOutCubic.transform(progress.value);

    Offset pointAt(double t) {
      final angle = startAngle + sweep * t;
      // A hand-drawn circle is never quite round.
      final r = radius * (1 + 0.025 * sin(2 * angle + wobblePhase));
      return center + Offset(cos(angle), sin(angle)) * r;
    }

    // The brush lands, presses in, then runs dry toward the tail.
    double widthAt(double t) {
      final landing = min(1.0, 0.45 + t / 0.06);
      final drying = 0.22 + 0.78 * pow(1 - t, 1.4);
      final bristle = 1 + 0.08 * sin(9 * pi * t + bristlePhase);
      return maxWidth * landing * drying * bristle;
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < _segments; i++) {
      final from = i / _segments;
      if (from >= drawn) break;
      final to = min((i + 1) / _segments, drawn);
      paint.strokeWidth = widthAt((from + to) / 2);
      canvas.drawLine(pointAt(from), pointAt(to), paint);
    }
  }

  @override
  bool shouldRepaint(EnsoPainter oldDelegate) =>
      oldDelegate.seed != seed ||
      oldDelegate.color != color ||
      oldDelegate.progress != progress;
}
