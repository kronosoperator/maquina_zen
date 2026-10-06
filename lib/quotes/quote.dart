import 'package:flutter/foundation.dart';

@immutable
class ZenMaster {
  const ZenMaster(this.name, {this.era});

  final String name;

  /// Language-neutral life dates, e.g. `1200–1253` or `†866`. Null when the
  /// record is too uncertain to print.
  final String? era;
}

@immutable
class Quote {
  const Quote({
    required this.id,
    required this.master,
    required this.en,
    required this.es,
    this.source,
  });

  /// Stable identifier. Persisted with saved quotes, so never rename one.
  final String id;
  final ZenMaster master;
  final String en;
  final String es;

  /// The work the line comes from, by its original title.
  final String? source;

  String text(String languageCode) => languageCode == 'es' ? es : en;

  String shareText(String languageCode) =>
      '${text(languageCode)}\n\n— ${master.name}';
}
