/// Conversor de medidas de longitud
///
/// Almacena una operación pudiendo ser conversiones de las
/// siguientes medidas:
/// 1. Kilómetros
/// 2. Métros
/// 3. Millas
///
/// También guarda su resultado como un `double`
class Conversion {
  static const _conversionRates = {
    'KM': {'KM': 1.0, 'M': 1000.0, 'MLL': 0.621371},
    'M': {'KM': 0.001, 'M': 1.0, 'MLL': 0.000621371},
    'MLL': {'KM': 1.60934, 'M': 1609.34, 'MLL': 1.0},
  };

  /// Devuelve el mapa de conversiones.
  static Map<String, Map<String, double>> get conversionRates =>
      _conversionRates;

  int? _id;

  /// Obtiene el id generado para el registro almacenado en la base de datos
  int? get id => _id;

  /// Establece el id.
  ///
  /// Por lo general se usa cuando se guarda la conversión
  /// en una base de datos, siendo el id generado.
  set id(int? value) {
    _id = value;
  }

  late final String _operation;

  /// Calculo realizado.
  String get operation => _operation;

  late final double _result;

  /// Resultado de la conversión.
  double get result => _result;

  Conversion(this._operation, this._result, this._id);

  /// Convierte el [value] de la medida [from] a la medida [to] y devuelve el objeto resultante.
  factory Conversion.convert(double value, String from, String to) {
    return Conversion(
        "$value $from -> $to", value * _conversionRates[from]![to]!, null);
  }

  /// Crea una Conversión a partir de un mapa.
  static Conversion fromMap(Map<String, dynamic> map) {
    return Conversion(map["operation"], map["result"], map["id"]);
  }

  /// Transforma el objeto a un mapa.
  Map<String, dynamic> toMap() {
    return {"operation": _operation, "result": _result};
  }

  /// @nodoc
  @override
  String toString() {
    return 'Conversion{_operation: $_operation, _result: $_result}';
  }
}
