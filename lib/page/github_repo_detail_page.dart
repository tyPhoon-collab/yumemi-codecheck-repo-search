import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yumemi_codecheck_repo_search/common/brightness_adaptive_svg.dart';
import 'package:yumemi_codecheck_repo_search/common/launch_url.dart';
import 'package:yumemi_codecheck_repo_search/common/loading_indicator.dart';
import 'package:yumemi_codecheck_repo_search/const.dart';
import 'package:yumemi_codecheck_repo_search/model/owner.dart';
import 'package:yumemi_codecheck_repo_search/model/repo.dart';

class GitHubRepoDetailPage extends StatelessWidget {
  const GitHubRepoDetailPage({required this.repo, super.key});

  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(repo.name)),
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SelectableText(
                repo.fullName,
                style: textTheme.headlineLarge,
              ),
            ),
            IconButton(
              onPressed: () => launchUrlSafe(context, repo.htmlUrl),
              icon: const Icon(Icons.launch),
            ),
          ],
        ),
        if (repo.description case final String description)
          SelectableText(description, style: textTheme.bodyLarge),
        const SizedBox(height: 16),
        if (repo.language case final String language)
          _SvgAndText(
            assetName: SvgAssets.code,
            text: language,
          ),
        const SizedBox(height: 8),
        _RepoPopularitySummaryView(repo: repo),
        const SizedBox(height: 8),
        _SvgAndText(
          assetName: SvgAssets.clock,
          text: _formatDate(repo.createdDateTime),
        ),
        _SvgAndText(
          assetName: SvgAssets.history,
          text: _formatDate(repo.updatedDateTime),
        ),
      ],
    );
  }

  String _formatDate(DateTime dateTime) {
    final formatter = DateFormat.yMMMd().add_jm();
    return formatter.format(dateTime);
  }
}

class _RepoPopularitySummaryView extends StatelessWidget {
  const _RepoPopularitySummaryView({
    required this.repo,
  });

  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        _SvgAndText(
          assetName: SvgAssets.star,
          text: repo.stargazersCount.toString(),
        ),
        _SvgAndText(
          assetName: SvgAssets.watch,
          text: repo.watchersCount.toString(),
        ),
        _SvgAndText(
          assetName: SvgAssets.fork,
          text: repo.forksCount.toString(),
        ),
        _SvgAndText(
          assetName: SvgAssets.issue,
          text: repo.openIssuesCount.toString(),
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
      onTap: () => launchUrlSafe(context, owner.htmlUrl),
      borderRadius: borderRadius,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          imageUrl: owner.avatarUrl,
          placeholder: (context, url) => const LoadingIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class _SvgAndText extends StatelessWidget {
  const _SvgAndText({
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
        AdaptiveBrightnessSvg(assetName),
        const SizedBox(width: 4),
        Flexible(child: Text(text)),
      ],
    );
  }
}
