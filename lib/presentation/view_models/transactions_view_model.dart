import 'package:flutter/material.dart';
import 'package:repaso_flutter/data/conversion_service.dart';
import 'package:repaso_flutter/domain/conversion.dart';

/// VieModel que gestiona el estado de las transacciones.
///
/// Guarda una lista de las conversiones realizadas.
class TransactionViewModel extends ChangeNotifier {
  List<Conversion> _conversions = [];

  List<Conversion> get conversions => _conversions;

  TransactionViewModel() {
    ConversionService.getAll().then((result) {
      _conversions = result;
      notifyListeners();
    });
  }

  Future<bool> insert(Conversion conversion) async {
    final int id = await ConversionService.insert(conversion);
    if (id > 0) {
      conversion.id = id;
      _conversions.add(conversion);
      return true;
    }
    return false;
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
