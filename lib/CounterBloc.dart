import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

// BLoCオブジェクト作成
class CounterBloc {
  StreamController counterAdditionController = StreamController();
  Sink get counterAddition => counterAdditionController.sink;

  BehaviorSubject<int> _count = BehaviorSubject<int>(seedValue: 0);
  Stream<int> get countString => _count.stream;

  CounterBloc() {
    counterAdditionController.stream.listen((addition) {
      _count.add(_count.value + 1);
    });
  }
}
