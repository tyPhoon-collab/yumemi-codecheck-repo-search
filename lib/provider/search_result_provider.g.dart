// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$repoSearchResultHash() => r'84123cf9d96e7115dd045233e4b458986cab58a9';

/// エラー時は必ずGitHubRepoServiceExceptionをthrowする
/// Sが初期化されている必要があり、やや責務が大きいが、一旦おいておく
///
/// Copied from [repoSearchResult].
@ProviderFor(repoSearchResult)
final repoSearchResultProvider =
    AutoDisposeFutureProvider<RepoSearchResult?>.internal(
  repoSearchResult,
  name: r'repoSearchResultProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$repoSearchResultHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RepoSearchResultRef = AutoDisposeFutureProviderRef<RepoSearchResult?>;
String _$realTotalCountHash() => r'a54879c7d86a639dd6648e88c4e3331bfc131ab2';

/// See also [realTotalCount].
@ProviderFor(realTotalCount)
final realTotalCountProvider = AutoDisposeProvider<int?>.internal(
  realTotalCount,
  name: r'realTotalCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$realTotalCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RealTotalCountRef = AutoDisposeProviderRef<int?>;
String _$repoSearchLastPageHash() =>
    r'3c66736aa13497ff080d85153ef56456321f63a1';

/// See also [RepoSearchLastPage].
@ProviderFor(RepoSearchLastPage)
final repoSearchLastPageProvider =
    AutoDisposeNotifierProvider<RepoSearchLastPage, int?>.internal(
  RepoSearchLastPage.new,
  name: r'repoSearchLastPageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$repoSearchLastPageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RepoSearchLastPage = AutoDisposeNotifier<int?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
