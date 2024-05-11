import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ThemeProvider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: Builder(builder: (context) {
              return Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                ),
              );
            }),
            title: Text('Dark Mode'),
          ),
        ],
      ),
    );
  }
}
