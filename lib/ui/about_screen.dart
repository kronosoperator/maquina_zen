import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../theme/zen_theme.dart';

final _authorUrl = Uri.parse('https://ivanro.com');

/// The hidden page behind the wordmark: a blank sheet to brush your own
/// circle on, signed by the author.
Future<void> showAboutScreen(BuildContext context) {
  final still = MediaQuery.disableAnimationsOf(context);
  return Navigator.of(context).push(
    PageRouteBuilder<void>(
      fullscreenDialog: true,
      transitionDuration: still
          ? Duration.zero
          : const Duration(milliseconds: 450),
      reverseTransitionDuration: still
          ? Duration.zero
          : const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) => const AboutScreen(),
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  );
}

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final _stroke = _BrushStroke();

  @override
  void dispose() {
    _stroke.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final still = MediaQuery.disableAnimationsOf(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              // One circle at a time: a new stroke replaces the last.
              onPanStart: (details) {
                HapticFeedback.selectionClick();
                _stroke.begin(details.localPosition);
              },
              onPanUpdate: (details) => _stroke.extend(details.localPosition),
              child: CustomPaint(
                painter: _BrushPainter(_stroke, scheme.onSurface),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: ListenableBuilder(
                listenable: _stroke,
                builder: (context, child) => AnimatedOpacity(
                  opacity: _stroke.isEmpty ? 1 : 0,
                  duration: still
                      ? Duration.zero
                      : const Duration(milliseconds: 400),
                  child: child,
                ),
                child: Center(
                  child: Text(
                    l10n.aboutDrawHint,
                    style: ZenType.detail.copyWith(
                      fontSize: 20,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.all(12),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    tooltip: MaterialLocalizations.of(context)
                        .closeButtonTooltip,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
                const Spacer(),
                const IgnorePointer(child: _Seal()),
                const SizedBox(height: 16),
                IgnorePointer(
                  child: Text(
                    l10n.aboutCredit,
                    textAlign: TextAlign.center,
                    style: ZenType.body.copyWith(color: scheme.onSurface),
                  ),
                ),
                TextButton(
                  onPressed: () => launchUrl(
                    _authorUrl,
                    mode: LaunchMode.externalApplication,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: scheme.secondary,
                    minimumSize: const Size(48, 48),
                  ),
                  child: Text(l10n.aboutLink, style: ZenType.detail),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The author's mark, in the manner of the red stamp on a scroll.
class _Seal extends StatelessWidget {
  const _Seal();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Transform.rotate(
      angle: -0.07,
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: scheme.secondary,
          borderRadius: BorderRadius.circular(7),
        ),
        child: ExcludeSemantics(
          child: Text(
            'IR',
            style: ZenType.label.copyWith(
              fontSize: 17,
              letterSpacing: 1,
              color: scheme.onSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _BrushStroke extends ChangeNotifier {
  static const _thick = 18.0;
  static const _thin = 3.0;

  final List<Offset> points = [];
  final List<double> widths = [];

  bool get isEmpty => points.isEmpty;

  void begin(Offset point) {
    points
      ..clear()
      ..add(point);
    widths
      ..clear()
      ..add(_thick * 0.6);
    notifyListeners();
  }

  void extend(Offset point) {
    if (points.isEmpty) return;
    // A slow hand lays down more ink; a fast one runs thin.
    final speed = (point - points.last).distance;
    final target = lerpDouble(_thick, _thin, (speed / 28).clamp(0, 1))!;
    points.add(point);
    widths.add(widths.last * 0.8 + target * 0.2);
    notifyListeners();
  }
}

class _BrushPainter extends CustomPainter {
  _BrushPainter(this.stroke, this.color) : super(repaint: stroke);

  final _BrushStroke stroke;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (var i = 1; i < stroke.points.length; i++) {
      paint.strokeWidth = (stroke.widths[i - 1] + stroke.widths[i]) / 2;
      canvas.drawLine(stroke.points[i - 1], stroke.points[i], paint);
    }
  }

  @override
  bool shouldRepaint(_BrushPainter oldDelegate) =>
      oldDelegate.stroke != stroke || oldDelegate.color != color;
}
