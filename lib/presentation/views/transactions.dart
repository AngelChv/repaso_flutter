import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:repaso_flutter/presentation/view_models/transactions_view_model.dart';
import 'package:repaso_flutter/presentation/widgets/transaction_card.dart';
import '../../domain/conversion.dart';
import '../widgets/app_drawer.dart';

/// Pantalla que muestra las conversiones realizadas.
class Transactions extends StatelessWidget {
  const Transactions({super.key});

  void _onDeleteTransaction(BuildContext context, Conversion conversion) async {
    final vm = context.read<TransactionViewModel>();
    final isSuccess = await vm.delete(conversion);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isSuccess
              ? "Transacción eliminada"
              : "Error al eliminar la transacción"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TransactionViewModel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.transactions),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        itemCount: vm.conversions.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          maxCrossAxisExtent: 600,
          mainAxisExtent: 100,
        ),
        itemBuilder: (context, index) {
          return TransactionCard(
            conversion: vm.conversions[index],
            onDeletePressed: _onDeleteTransaction,
          );
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
