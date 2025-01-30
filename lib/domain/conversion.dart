class Conversion {
  static const _conversionRates = {
    'KM': {'KM': 1.0, 'M': 1000.0, 'MLL': 0.621371},
    'M': {'KM': 0.001, 'M': 1.0, 'MLL': 0.000621371},
    'MLL': {'KM': 1.60934, 'M': 1609.34, 'MLL': 1.0},
  };
  static Map<String, Map<String, double>> get conversionRates => _conversionRates;

  int? _id;
  int? get id => _id;
  set id(int? value) {
    _id = value;
  }

  late final String _operation;

  String get operation => _operation;

  late final double _result;

  double get result => _result;

  Conversion(this._operation, this._result, this._id);

  factory Conversion.convert(double value, String from, String to) {
    return Conversion(
      "$value $from -> $to",
      value * _conversionRates[from]![to]!,
      null
    );
  }

  static Conversion fromMap(Map<String, dynamic> map) {
    return Conversion(map["operation"], map["result"], map["id"]);
  }

  Map<String, dynamic> toMap() {
    return {"operation": _operation, "result": _result};
  }

  @override
  String toString() {
    return 'Conversion{_operation: $_operation, _result: $_result}';
  }
}
