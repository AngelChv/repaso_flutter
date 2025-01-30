import 'package:flutter/material.dart';

/// VieModel que gestiona el estado del conversor.
///
/// En concreto gestiona el resultado.
class ConversorViewModel extends ChangeNotifier {
  String? _result;
  String? get result => _result;
  set result(String? value) {
    _result = value;
    notifyListeners();
  }
}