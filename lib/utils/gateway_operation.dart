import 'dart:async';

class GatewayController {
  static late Completer<dynamic>? _completer;
  static bool get _isRefreshing => _computation != null;
  static Future<dynamic>? _computation;

  static Future<dynamic> refresh(Future<dynamic> Function() execute) async {
    if (_isRefreshing) return _computation!;
    _completer = Completer();
    _computation = _completer!.future;
    final response = await execute();
    _completer!.complete(response);
    _computation = null;
    return response;
  }
}
