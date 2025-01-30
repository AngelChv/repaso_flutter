import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:repaso_flutter/presentation/views/converter.dart';
import 'package:repaso_flutter/presentation/views/settings.dart';
import 'package:repaso_flutter/presentation/views/transactions.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              AppLocalizations.of(context)!.menu,
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(Icons.compare_arrows),
            title: Text(AppLocalizations.of(context)!.converter),
            onTap: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Converter(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text(AppLocalizations.of(context)!.transactions),
            onTap: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Transactions(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(AppLocalizations.of(context)!.settings),
            onTap: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      Settings(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
