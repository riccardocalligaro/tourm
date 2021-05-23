mixin TMApiConfig {
  static String apiUrl = '${_getBaseUrl()}/api/v1';
}

String _getBaseUrl() {
  return 'http://localhost:8000';
}
