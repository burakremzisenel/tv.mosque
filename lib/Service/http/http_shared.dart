export 'http_unsupported.dart'
if (dart.library.html) 'http_web_adapter.dart'
if (dart.library.io) 'http_mobile_adapter.dart';