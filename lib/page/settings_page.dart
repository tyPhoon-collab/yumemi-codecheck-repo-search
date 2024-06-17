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
        _getCurrentLanguageName(
          Localizations.localeOf(context),
        ),
      ),
      trailing: const Icon(Icons.open_in_new),
    );
  }

  String _getCurrentLanguageName(Locale locale) {
    return switch (locale.languageCode) {
      'en' => 'English',
      'ja' => '日本語',
      _ => 'Unknown',
    };
  }
}
