import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../quotes/quote.dart';
import '../state/zen_controller.dart';
import '../theme/zen_theme.dart';

Future<void> showSavedSheet(BuildContext context, ZenController controller) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.92,
      builder: (context, scrollController) => _SavedList(
        controller: controller,
        scrollController: scrollController,
      ),
    ),
  );
}

class _SavedList extends StatelessWidget {
  const _SavedList({required this.controller, required this.scrollController});

  final ZenController controller;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final languageCode = Localizations.localeOf(context).languageCode;

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final saved = controller.saved;
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: Text(
                  l10n.saved.toUpperCase(),
                  style: ZenType.label.copyWith(color: scheme.onSurface),
                ),
              ),
            ),
            if (saved.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      l10n.savedEmpty,
                      textAlign: TextAlign.center,
                      style: ZenType.detail.copyWith(
                        fontSize: 20,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              )
            else
              SliverList.separated(
                itemCount: saved.length,
                separatorBuilder: (_, _) => Divider(
                  height: 1,
                  indent: 24,
                  endIndent: 24,
                  color: scheme.outlineVariant,
                ),
                itemBuilder: (context, index) {
                  final quote = saved[index];
                  return _SavedTile(
                    key: ValueKey(quote.id),
                    quote: quote,
                    languageCode: languageCode,
                    removeTooltip: l10n.unsave,
                    onOpen: () {
                      controller.show(quote);
                      Navigator.of(context).pop();
                    },
                    onRemove: () => controller.toggleSaved(quote),
                  );
                },
              ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        );
      },
    );
  }
}

class _SavedTile extends StatelessWidget {
  const _SavedTile({
    super.key,
    required this.quote,
    required this.languageCode,
    required this.removeTooltip,
    required this.onOpen,
    required this.onRemove,
  });

  final Quote quote;
  final String languageCode;
  final String removeTooltip;
  final VoidCallback onOpen;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onOpen,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 8, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quote.text(languageCode),
                    style: ZenType.body.copyWith(color: scheme.onSurface),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    quote.master.name.toUpperCase(),
                    style: ZenType.label.copyWith(
                      fontSize: 11,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: removeTooltip,
              onPressed: onRemove,
              icon: Icon(Icons.bookmark_rounded, color: scheme.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
