import 'dart:async';

import 'package:flutter/foundation.dart';

/// Classe base para a gerencia de estado
abstract class Bloc<T> {
  final _controller = StreamController<T>();

  Stream<T> get stream => _controller.stream;

  @protected
  Sink<T> get sink => _controller.sink;

  void closeStream() {
    _controller.close();
    sink.close();
  }
}
