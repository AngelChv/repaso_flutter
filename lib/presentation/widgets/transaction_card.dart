import 'package:flutter/material.dart';
import 'package:repaso_flutter/domain/conversion.dart';

/// Tarjeta que muestra una conversion con su resultado.
class TransactionCard extends StatelessWidget {
  const TransactionCard(
      {super.key,
      required Conversion conversion,
      required void Function(BuildContext context, Conversion conversion) onDeletePressed})
      : _onDeletePressed = onDeletePressed, _conversion = conversion;

  final Conversion _conversion;

  final void Function(BuildContext context, Conversion conversion) _onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(_conversion.operation),
        subtitle: Text(_conversion.result.toString()),
        trailing: IconButton(
          onPressed: () => _onDeletePressed(context, _conversion),
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}
