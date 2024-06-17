import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            _LanguageListTile(),
            _ThemeListTile(),
          ],
        ),
      ),
    );
  }
}

class _LanguageListTile extends StatelessWidget {
  const _LanguageListTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language_outlined),
      onTap: () => AppSettings.openAppSettings(
        type: AppSettingsType.appLocale,
      ), // 言語設定は本体設定から行うのが普通（LINEなどを参照）
      title: const Text('Language'),
      subtitle: Text(
        _getLanguageName(
          Localizations.localeOf(context),
        ),
      ),
      trailing: const Icon(Icons.open_in_new),
    );
  }

  String _getLanguageName(Locale locale) {
    return switch (locale.languageCode) {
      'en' => 'English',
      'ja' => '日本語',
      _ => 'Unknown',
    };
  }
}

class _ThemeListTile extends StatefulWidget {
  const _ThemeListTile();

  @override
  State<_ThemeListTile> createState() => _ThemeListTileState();
}

class _ThemeListTileState extends State<_ThemeListTile> {
  @override
  Widget build(BuildContext context) {
    final currentThemeMode = AdaptiveTheme.of(context).mode;

    const modes = [
      AdaptiveThemeMode.system,
      AdaptiveThemeMode.light,
      AdaptiveThemeMode.dark,
    ];

    return ListTile(
      leading: const Icon(Icons.color_lens_outlined),
      title: const Text('Theme'),
      subtitle: Text(_getThemeModeName(currentThemeMode)),
      trailing: ToggleButtons(
        isSelected: modes.map((theme) => theme == currentThemeMode).toList(),
        onPressed: (index) => _changeTheme(modes[index]),
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        children: modes.map((mode) => Icon(_getThemeModeIcon(mode))).toList(),
      ),
    );
  }

  String _getThemeModeName(AdaptiveThemeMode mode) {
    return switch (mode) {
      AdaptiveThemeMode.system => 'System',
      AdaptiveThemeMode.light => 'Light',
      AdaptiveThemeMode.dark => 'Dark',
    };
  }

  IconData _getThemeModeIcon(AdaptiveThemeMode mode) {
    return switch (mode) {
      AdaptiveThemeMode.system => Icons.brightness_4,
      AdaptiveThemeMode.light => Icons.light_mode,
      AdaptiveThemeMode.dark => Icons.dark_mode,
    };
  }

  void _changeTheme(AdaptiveThemeMode newMode) {
    // 本来ならPrefsなどを用いて永続化の処理を挟む。今回は省略
    setState(() {
      AdaptiveTheme.of(context).setThemeMode(newMode);
    });
  }
}
