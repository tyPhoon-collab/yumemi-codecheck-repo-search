import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';

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
            _ClearAllHistoryListTile(),
            _AboutListTile(),
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
      key: const Key('language_list_tile'),
      leading: const Icon(Icons.language_outlined),
      onTap: () => AppSettings.openAppSettings(
        type: AppSettingsType.appLocale,
      ), // 言語設定は本体設定から行うのが普通（LINEなどを参照）
      title: Text(S.current.language),
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
      _ => locale.languageCode,
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
      key: const Key('theme_list_tile'),
      leading: const Icon(Icons.color_lens_outlined),
      title: Text(S.current.theme),
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
      AdaptiveThemeMode.system => S.current.system,
      AdaptiveThemeMode.light => S.current.light,
      AdaptiveThemeMode.dark => S.current.dark,
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

class _ClearAllHistoryListTile extends ConsumerWidget {
  const _ClearAllHistoryListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryHistory = ref.watch(queryHistoryStreamProvider);

    final isEmpty = queryHistory.value?.isEmpty ?? true;

    return ListTile(
      enabled: !isEmpty,
      key: const Key('clear_all_history_list_tile'),
      leading: const Icon(Icons.history),
      title: Text(S.current.clearHistory),
      trailing: const Icon(Icons.navigate_next_outlined),
      onTap: () => _showClearAllHistoryDialog(context, ref),
    );
  }

  Future<void> _showClearAllHistoryDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.current.clearHistory),
        content: Text(S.current.clearHistoryConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.current.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(queryHistoryServiceProvider).clearAll();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.current.clearHistorySuccess),
                  showCloseIcon: true,
                ),
              );
            },
            child: Text(S.current.clear),
          ),
        ],
      ),
    );
  }
}

class _AboutListTile extends StatelessWidget {
  const _AboutListTile();

  @override
  Widget build(BuildContext context) {
    final applicationName = S.current.title;

    // AboutListTileがあるが、バージョンを非同期的に取得するため、独自で実装する
    return ListTile(
      key: const Key('about_list_tile'),
      leading: const Icon(Icons.info_outline),
      title: Text(
        MaterialLocalizations.of(context).aboutListTileTitle(
          applicationName,
        ),
      ),
      trailing: const Icon(Icons.navigate_next_outlined),
      onTap: () async {
        final version =
            await PackageInfo.fromPlatform().then((value) => value.version);

        if (!context.mounted) return;

        showAboutDialog(
          context: context,
          applicationName: applicationName,
          applicationVersion: version,
          applicationLegalese: '''Copyright 2024 Hiroaki Osawa''',
          children: [
            const SizedBox(height: 16),
            Text(S.current.description),
          ],
        );
      },
    );
  }
}
