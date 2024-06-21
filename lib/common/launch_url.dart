import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';

/// launchUrlのラッパー。エラー時にSnackBarを表示する
Future<void> launchUrlSafe(BuildContext context, String url) async {
  final uri = Uri.parse(url);
  try {
    final result = await launchUrl(uri);
    if (!result && context.mounted) {
      _showLaunchUrlError(context, url);
    }
  } catch (e) {
    if (!context.mounted) return;

    _showLaunchUrlError(context, url);
  }
}

void _showLaunchUrlError(BuildContext context, String url) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(S.current.failedLaunch(url))),
  );
}
