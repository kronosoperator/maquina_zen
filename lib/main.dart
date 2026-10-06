import 'package:flutter/widgets.dart';

import 'app.dart';
import 'state/key_value_store.dart';
import 'state/zen_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await SharedPreferencesStore.open();
  runApp(MaquinaZenApp(controller: ZenController(store: store)));
}
