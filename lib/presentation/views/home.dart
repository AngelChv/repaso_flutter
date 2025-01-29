import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:repaso_flutter/presentation/views/converter.dart';
import 'package:repaso_flutter/presentation/views/settings.dart';
import 'package:repaso_flutter/presentation/views/transactions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _page = const Converter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(AppLocalizations.of(context)!.menu),
            ),
            ListTile(
              leading: Icon(Icons.compare_arrows),
              title: Text(AppLocalizations.of(context)!.converter),
              onTap: () {
                setState(() {
                  _page = const Converter();
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text(AppLocalizations.of(context)!.transactions),
              onTap: () {
                setState(() {
                  _page = const Transactions();
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(AppLocalizations.of(context)!.settings),
              onTap: () {
                setState(() {
                  _page = const Settings();
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
