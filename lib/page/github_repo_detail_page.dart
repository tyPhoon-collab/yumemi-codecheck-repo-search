import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';

class GitHubRepoDetailPage extends StatelessWidget {
  const GitHubRepoDetailPage({required this.repo, super.key});

  final Repo repo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(repo.fullName)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => _launchUrl(context, repo.htmlUrl),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          repo.fullName,
                          style: textTheme.headlineLarge,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.launch),
                    ],
                  ),
                ),
                if (repo.description case final String description)
                  Text(description, style: textTheme.bodyLarge),
                if (repo.language case final String language)
                  _IconAndText(iconData: Icons.abc, text: language),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _IconAndText(
                      iconData: Icons.star,
                      text: repo.stargazersCount.toString(),
                    ),
                    const SizedBox(width: 8),
                    _IconAndText(
                      iconData: Icons.remove_red_eye,
                      text: repo.watchersCount.toString(),
                    ),
                    const SizedBox(width: 8),
                    _IconAndText(
                      iconData: Icons.code,
                      text: repo.forksCount.toString(),
                    ),
                    const SizedBox(width: 8),
                    _IconAndText(
                      iconData: Icons.bug_report,
                      text: repo.openIssuesCount.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(repo.htmlUrl);
    try {
      await launchUrl(uri);
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to launch $uri')),
      );
    }
  }
}

class _IconAndText extends StatelessWidget {
  const _IconAndText({required this.iconData, required this.text});

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
