import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralized access to environment variables loaded from .env
class Env {
  Env._();

  /// Firebase — loaded from .env (if using REST or custom keys)
  static String get firebaseApiKey => _get('FIREBASE_API_KEY');

  /// OCR API — the service endpoint for OCR processing
  static String get ocrApiBaseUrl => _get('OCR_API_BASE_URL');

  /// App name for display
  static String get appName => _getOr('APP_NAME', 'OCR Processing');

  // ── Internal ─────────────────────────────────────────

  static String _get(String key) {
    final value = dotenv.env[key];
    assert(value != null && value.isNotEmpty, '[$key] falta en .env');
    return value!;
  }

  static String _getOr(String key, String fallback) {
    final value = dotenv.env[key];
    return (value != null && value.isNotEmpty) ? value : fallback;
  }
}
