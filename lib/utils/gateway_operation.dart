import 'dart:async';

class GatewayController {
  static Completer<dynamic>? _completer;
  static bool get _isRefreshing => _computation != null;
  static Future<dynamic>? _computation;

  static Future<dynamic> refresh(Future<dynamic> Function() execute) async {
    if (_isRefreshing) return await _computation!;
    _completer = Completer();
    _computation = _completer!.future;
    var response = await execute();
    _completer!.complete(response);
    _computation = null;
    return response;
  }
}
