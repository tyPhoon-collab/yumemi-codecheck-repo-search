import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yumemi_codecheck_repo_search/model/owner.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';

class GitHubRepoDetailPage extends StatelessWidget {
  const GitHubRepoDetailPage({required this.repo, super.key});

  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(repo.fullName)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: OrientationBuilder(
            builder: (context, orientation) {
              return switch (orientation) {
                Orientation.portrait => _PortraitLayout(repo: repo),
                Orientation.landscape => _LandscapeLayout(repo: repo),
              };
            },
          ),
        ),
      ),
    );
  }
}

class _PortraitLayout extends StatelessWidget {
  const _PortraitLayout({required this.repo});

  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: _AvatarImage(owner: repo.owner),
            ),
            const SizedBox(height: 16),
            _RepoDescription(repo: repo),
          ],
        ),
      ),
    );
  }
}

class _LandscapeLayout extends StatelessWidget {
  const _LandscapeLayout({required this.repo});

  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _AvatarImage(owner: repo.owner),
          const SizedBox(width: 32),
          Flexible(
            child: SingleChildScrollView(
              child: _RepoDescription(repo: repo),
            ),
          ),
        ],
      ),
    );
  }
}

class _RepoDescription extends StatelessWidget {
  const _RepoDescription({required this.repo});

  final Repo repo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
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
    );
  }
}

class _AvatarImage extends StatelessWidget {
  const _AvatarImage({
    required this.owner,
  });

  final Owner owner;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(32);
    return InkWell(
      onTap: () => _launchUrl(context, owner.htmlUrl),
      borderRadius: borderRadius,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          imageUrl: owner.avatarUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
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
        SvgPicture.asset(
          assetName,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}

Future<void> _launchUrl(BuildContext context, String url) async {
  final uri = Uri.parse(url);
  try {
    await launchUrl(uri);
  } catch (e) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to launch $uri')),
    );
  }
}
