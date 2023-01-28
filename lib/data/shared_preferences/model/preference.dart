import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Preference entity.
/// Provide getter, setter and listener.
class PreferenceEntry<T> {
  final String key;
  final T defaultValue;
  final SharedPreferences preferences;
  final PublishSubject<T> subject = PublishSubject();

  PreferenceEntry(this.key, this.defaultValue, this.preferences);

  /// Get value.
  /// Supported types: String, int, bool, double, List<String>
  /// Throws exception if type is not supported.
  T get() => preferences.get(key) as T ?? defaultValue;

  /// Set value.
  /// Supported types: String, int, bool, double, List<String>
  /// Throws exception if type is not supported.
  void set(T value) {
    if (value == null) {
      preferences.remove(key);
    } else if (value is String) {
      preferences.setString(key, value);
    } else if (value is int) {
      preferences.setInt(key, value);
    } else if (value is bool) {
      preferences.setBool(key, value);
    } else if (value is double) {
      preferences.setDouble(key, value);
    } else if (value is List<String>) {
      preferences.setStringList(key, value);
    } else {
      throw Exception("Unsupported type");
    }
    subject.add(value);
  }

  /// Listen to changes.
  Stream<T> listen() => subject.stream;
}
