import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recipe_app/utils/ui_event/ui_event.dart';

class SplashViewModel with ChangeNotifier {
  final _eventController = StreamController<UiEvent>();

  Stream<UiEvent> get eventStream => _eventController.stream;

  Future<void> isNetworkConnect() async {
    _eventController.add(const UiEvent.networkError('네트워크 연결이 필요합니다.'));
  }
}
