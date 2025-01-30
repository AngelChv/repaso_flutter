import 'package:flutter/material.dart';

class ConversorViewModel extends ChangeNotifier {
  String? _result;
  String? get result => _result;
  set result(String? value) {
    _result = value;
    notifyListeners();
  }
}