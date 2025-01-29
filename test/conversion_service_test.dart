import 'package:flutter_test/flutter_test.dart';
import 'package:repaso_flutter/data/conversion_service.dart';
import 'package:repaso_flutter/domain/conversion.dart';

main() {
  test("Insertar en la tabla conversions", () async {
    final bool result = await ConversionService.insert(
      Conversion.convert(10, 'KM', 'KM'),
    );
    expect(result, true);
  });

  test("Obtener todos los registros de la tabla conversions", () async {
    final result = await ConversionService.getAll();
    expect(result.isNotEmpty, true);
  });

  test("Eliminar de la tabla conversions", () async {
    final list = await ConversionService.getAll();
    final result = await ConversionService.delete(list.last.id ?? 0);
    expect(result, true);
  });
}
