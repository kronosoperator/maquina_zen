import 'package:shared_preferences/shared_preferences.dart';

/// The slice of persistence the app needs. Reads are synchronous so the first
/// frame can render real state.
abstract interface class KeyValueStore {
  int? getInt(String key);
  String? getString(String key);
  List<String>? getStringList(String key);

  Future<void> setInt(String key, int value);
  Future<void> setString(String key, String value);
  Future<void> setStringList(String key, List<String> value);
  Future<void> remove(String key);
}

class SharedPreferencesStore implements KeyValueStore {
  SharedPreferencesStore._(this._prefs);

  static Future<SharedPreferencesStore> open() async =>
      SharedPreferencesStore._(await SharedPreferences.getInstance());

  final SharedPreferences _prefs;

  @override
  int? getInt(String key) => _prefs.getInt(key);

  @override
  String? getString(String key) => _prefs.getString(key);

  @override
  List<String>? getStringList(String key) => _prefs.getStringList(key);

  @override
  Future<void> setInt(String key, int value) => _prefs.setInt(key, value);

  @override
  Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  @override
  Future<void> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  @override
  Future<void> remove(String key) => _prefs.remove(key);
}

class InMemoryStore implements KeyValueStore {
  InMemoryStore([Map<String, Object>? initial]) : _values = {...?initial};

  final Map<String, Object> _values;

  @override
  int? getInt(String key) => _values[key] as int?;

  @override
  String? getString(String key) => _values[key] as String?;

  @override
  List<String>? getStringList(String key) => _values[key] as List<String>?;

  @override
  Future<void> setInt(String key, int value) async => _values[key] = value;

  @override
  Future<void> setString(String key, String value) async =>
      _values[key] = value;

  @override
  Future<void> setStringList(String key, List<String> value) async =>
      _values[key] = List.of(value);

  @override
  Future<void> remove(String key) async => _values.remove(key);
}
