mixin TMApiConfig {
  static String apiUrl = '${getBaseUrl()}/api/v1';
}

String getBaseUrl() {
  // return 'http://989604df14a9.eu.ngrok.io';
  return 'http://localhost:8000';
}
