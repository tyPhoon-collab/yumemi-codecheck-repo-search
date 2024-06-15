import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                Center(
                  child: _AvatarImage(
                    avatarUrl: repo.owner.avatarUrl,
                  ),
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                if (repo.language case final String language)
                  _SVGAndText(
                    assetName: 'assets/image/svg/file-code.svg',
                    text: language,
                  ),
                Wrap(
                  children: [
                    _SVGAndText(
                      assetName: 'assets/image/svg/star.svg',
                      text: repo.stargazersCount.toString(),
                    ),
                    const SizedBox(width: 8),
                    _SVGAndText(
                      assetName: 'assets/image/svg/eye.svg',
                      text: repo.watchersCount.toString(),
                    ),
                    const SizedBox(width: 8),
                    _SVGAndText(
                      assetName: 'assets/image/svg/repo-forked.svg',
                      text: repo.forksCount.toString(),
                    ),
                    const SizedBox(width: 8),
                    _SVGAndText(
                      assetName: 'assets/image/svg/issue-opened.svg',
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

class _AvatarImage extends StatelessWidget {
  const _AvatarImage({
    required this.avatarUrl,
  });

  final String avatarUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: CachedNetworkImage(
        imageUrl: avatarUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

class _SVGAndText extends StatelessWidget {
  const _SVGAndText({
    required this.assetName,
    required this.text,
  });

  final String assetName;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(assetName),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
