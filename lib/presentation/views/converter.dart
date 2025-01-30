import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:repaso_flutter/domain/conversion.dart';
import 'package:repaso_flutter/presentation/view_models/conversor_view_model.dart';
import 'package:repaso_flutter/presentation/view_models/transactions_view_model.dart';
import 'package:repaso_flutter/presentation/widgets/app_drawer.dart';

class Converter extends StatelessWidget {
  Converter({super.key});

  static const double _spacing = 16;

  final menuEntries = Conversion.conversionRates.entries.map((entry) {
    return DropdownMenuEntry(value: entry.key, label: entry.key);
  }).toList();

  final _formKey = GlobalKey<FormState>();

  final _valueController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  _validate(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final Conversion conversion = Conversion.convert(
        double.parse(_valueController.text.toString()),
        _fromController.text,
        _toController.text,
      );

      context.read<ConversorViewModel>().result =
      "${AppLocalizations.of(context)!.result}: ${conversion.result} "
          "${_toController.text}";

      final isSuccess =
          await context.read<TransactionViewModel>().insert(conversion);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isSuccess
              ? AppLocalizations.of(context)!.transactionSavedSuccessfully
              : AppLocalizations.of(context)!.transactionSavingError),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = context.watch<ConversorViewModel>().result;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.converter),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _valueController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.insertTheValue,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.completeTheValue;
                } else {
                  try {
                    double.parse(value);
                    return null;
                  } catch (e) {
                    return AppLocalizations.of(context)!.insertANumber;
                  }
                }
              },
            ),
            SizedBox(height: _spacing),
            Center(
              child: DropdownMenu(
                controller: _fromController,
                initialSelection: menuEntries.first.label,
                dropdownMenuEntries: menuEntries,
              ),
            ),
            SizedBox(height: _spacing),
            Center(
              child: DropdownMenu(
                controller: _toController,
                initialSelection: menuEntries.first.label,
                dropdownMenuEntries: menuEntries,
              ),
            ),
            SizedBox(height: _spacing),
            if (result != null) Center(child: Text(result)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _validate(context),
        label: Text(AppLocalizations.of(context)!.convertAndSave),
      ),
      drawer: const AppDrawer(),
    );
  }
}
