import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/controllers/dark_mode_controllers.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Setting",
          //# style: theme.appBarTheme.titleTextStyle,
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Appearnace",
                    style: theme.textTheme.bodySmall,
                  ),
                )),
            ListTile(
              leading: Icon(
                Icons.dark_mode,
                color: theme.colorScheme.onTertiary,
              ),
              title: const Text("Dark theme"),
              trailing: Consumer<DarkModeControllers>(builder:
                  (BuildContext context, DarkModeControllers notifier,
                      Widget? child) {
                return Switch(
                  value: notifier.isDark,
                  onChanged: (value) => notifier.toggleSwitch(),
                );
              }),
            ),
            const Divider(
              thickness: 0.5,
              indent: 24,
              endIndent: 24,
            ),
          ]),
    );
  }
}
