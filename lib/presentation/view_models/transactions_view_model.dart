import 'package:flutter/material.dart';
import 'package:repaso_flutter/data/conversion_service.dart';
import 'package:repaso_flutter/domain/conversion.dart';

class TransactionViewModel extends ChangeNotifier {
  List<Conversion> _conversions = [];

  List<Conversion> get conversions => _conversions;

  TransactionViewModel() {
    ConversionService.getAll().then((result) {
      _conversions = result;
      notifyListeners();
    });
  }

  Future<bool> delete(Conversion conversion) async {
    if (conversion.id != null &&
        await ConversionService.delete(conversion.id!)) {
      _conversions.remove(conversion);
      notifyListeners();
      return true;
    }
    return false;
  }
}
