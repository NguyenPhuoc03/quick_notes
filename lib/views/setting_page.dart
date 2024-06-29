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
          title: Text(
            "Setting",
            //# style: theme.appBarTheme.titleTextStyle,
          ),
        ),
        body: Consumer<DarkModeControllers>(
          builder: (BuildContext context, DarkModeControllers notifier,
              Widget? child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.dark_mode,
                      color: theme.colorScheme.onTertiary,
                    ),
                    title: Text("Dark theme"),
                    trailing: Switch(
                      value: notifier.isDark,
                      onChanged: (value) => notifier.toggleSwitch(),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
