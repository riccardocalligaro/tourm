mixin TMApiConfig {
  static String apiUrl = '${_getProductionBaseURL()}/api/';
}

String _getProductionBaseURL() {
  return 'https://www.refertionline.it';
}
