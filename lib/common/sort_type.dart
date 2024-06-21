import 'package:flutter/material.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';

enum RepoSearchSortType {
  bestMatch('best-match', Icons.sort_by_alpha_outlined),
  stars('stars', Icons.star_outline),
  forks('forks', Icons.fork_right_outlined),
  helpWantedIssues('help-wanted-issues', Icons.help_outline),
  updated('updated', Icons.update_outlined),
  ;

  const RepoSearchSortType(this.query, this.iconData);

  final String query;
  final IconData iconData;

  String get displayName => switch (this) {
        RepoSearchSortType.bestMatch => S.current.sortTypeBestMatch,
        RepoSearchSortType.stars => S.current.sortTypeStars,
        RepoSearchSortType.forks => S.current.sortTypeForks,
        RepoSearchSortType.helpWantedIssues =>
          S.current.sortTypeHelpWantedIssues,
        RepoSearchSortType.updated => S.current.sortTypeUpdated,
      };
}
