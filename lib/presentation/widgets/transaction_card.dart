import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repaso_flutter/domain/conversion.dart';
import 'package:repaso_flutter/presentation/view_models/transactions_view_model.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required Conversion conversion})
      : _conversion = conversion;
  final Conversion _conversion;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(_conversion.operation),
        subtitle: Text(_conversion.result.toString()),
        trailing: IconButton(
          onPressed: () async {
            final vm = context.read<TransactionViewModel>();
            final isSuccess = await vm.delete(_conversion);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isSuccess
                      ? "Transacción eliminada"
                      : "Error al eliminar la transacción"),
                ),
              );
            }
          },
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}
