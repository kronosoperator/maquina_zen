import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/app_localizations.dart';
import '../state/zen_controller.dart';
import '../theme/zen_theme.dart';
import 'about_screen.dart';
import 'enso.dart';
import 'quote_view.dart';
import 'saved_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.controller});

  final ZenController controller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static const _brushDuration = Duration(milliseconds: 1100);
  static const _fadeDuration = Duration(milliseconds: 650);

  late final AnimationController _brush = AnimationController(vsync: this);
  final _shareButtonKey = GlobalKey();
  bool _started = false;

  ZenController get _controller => widget.controller;

  String get _languageCode => Localizations.localeOf(context).languageCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _brush.duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : _brushDuration;
    if (!_started) {
      _started = true;
      _brush.forward();
    }
  }

  @override
  void dispose() {
    _brush.dispose();
    super.dispose();
  }

  void _dispense() {
    HapticFeedback.lightImpact();
    _controller.dispense();
    _brush.forward(from: 0);
  }

  void _toggleSaved() {
    HapticFeedback.selectionClick();
    _controller.toggleSaved(_controller.current);
  }

  void _share() {
    // iPad and macOS anchor the share popover to the button.
    final box =
        _shareButtonKey.currentContext?.findRenderObject() as RenderBox?;
    SharePlus.instance.share(
      ShareParams(
        text: _controller.current.shareText(_languageCode),
        sharePositionOrigin: box == null
            ? null
            : box.localToGlobal(Offset.zero) & box.size,
      ),
    );
  }

  Future<void> _copy() async {
    final messenger = ScaffoldMessenger.of(context);
    final copied = AppLocalizations.of(context).copied;
    await Clipboard.setData(
      ClipboardData(text: _controller.current.shareText(_languageCode)),
    );
    HapticFeedback.mediumImpact();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(copied, textAlign: TextAlign.center),
          duration: const Duration(milliseconds: 1400),
          width: 160,
        ),
      );
  }

  void _openAbout() {
    HapticFeedback.mediumImpact();
    showAboutScreen(context);
  }

  void _switchLanguage() {
    _controller.setLocale(Locale(_languageCode == 'es' ? 'en' : 'es'));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final still = MediaQuery.disableAnimationsOf(context);

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.space): _dispense,
        const SingleActivator(LogicalKeyboardKey.enter): _dispense,
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          body: SafeArea(
            minimum: const EdgeInsets.symmetric(vertical: 12),
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, _) {
                final quote = _controller.current;
                final saved = _controller.isSaved(quote);
                return Column(
                  children: [
                    _TopBar(
                      title: l10n.appTitle,
                      dispensed: _controller.dispensed,
                      languageCode: _languageCode,
                      languageTooltip: l10n.switchLanguage,
                      savedTooltip: l10n.saved,
                      onOpenAbout: _openAbout,
                      onSwitchLanguage: _switchLanguage,
                      onOpenSaved: () => showSavedSheet(context, _controller),
                    ),
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onLongPress: _copy,
                        child: AnimatedSwitcher(
                          duration: still ? Duration.zero : _fadeDuration,
                          switchInCurve: const Interval(0.35, 1),
                          switchOutCurve: const Interval(0.5, 1),
                          child: QuoteView(
                            key: ValueKey('${quote.id}-$_languageCode'),
                            quote: quote,
                            languageCode: _languageCode,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          tooltip: saved ? l10n.unsave : l10n.save,
                          onPressed: _toggleSaved,
                          icon: Icon(
                            saved
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_outline_rounded,
                            color: saved ? scheme.secondary : null,
                          ),
                        ),
                        const SizedBox(width: 24),
                        EnsoButton(
                          progress: _brush,
                          seed: _controller.dispensed,
                          semanticLabel: l10n.newQuote,
                          onPressed: _dispense,
                        ),
                        const SizedBox(width: 24),
                        IconButton(
                          key: _shareButtonKey,
                          tooltip: l10n.share,
                          onPressed: _share,
                          icon: const Icon(Icons.ios_share_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Only the very first quote needs to explain the machine.
                    AnimatedOpacity(
                      opacity: _controller.dispensed <= 1 ? 1 : 0,
                      duration: still ? Duration.zero : _fadeDuration,
                      child: ExcludeSemantics(
                        child: Text(
                          l10n.tapHint,
                          style: ZenType.detail.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.dispensed,
    required this.languageCode,
    required this.languageTooltip,
    required this.savedTooltip,
    required this.onOpenAbout,
    required this.onSwitchLanguage,
    required this.onOpenSaved,
  });

  final String title;
  final int dispensed;
  final String languageCode;
  final String languageTooltip;
  final String savedTooltip;
  final VoidCallback onOpenAbout;
  final VoidCallback onSwitchLanguage;
  final VoidCallback onOpenSaved;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 12, 0),
      child: Row(
        children: [
          // Unmarked on purpose: the wordmark hides the about page.
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onOpenAbout,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: ZenType.label.copyWith(color: scheme.onSurface),
                  ),
                  const SizedBox(height: 2),
                  // The machine's ticket counter.
                  Text(
                    'Nº ${dispensed.toString().padLeft(4, '0')}',
                    style: ZenType.detail.copyWith(
                      fontSize: 14,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Tooltip(
            message: languageTooltip,
            child: TextButton(
              onPressed: onSwitchLanguage,
              style: TextButton.styleFrom(
                foregroundColor: scheme.onSurface,
                minimumSize: const Size.square(48),
              ),
              child: Text(languageCode.toUpperCase(), style: ZenType.label),
            ),
          ),
          IconButton(
            tooltip: savedTooltip,
            onPressed: onOpenSaved,
            icon: const Icon(Icons.bookmarks_outlined),
          ),
        ],
      ),
    );
  }
}
