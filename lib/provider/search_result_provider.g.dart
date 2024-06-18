// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$repoSearchResultHash() => r'e0d1afa23c2b8a9ba20e16fab64936c707b4d691';

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
String _$repoSearchTotalCountHash() =>
    r'f4b6172316e69561df45742ee8fa13bc45a60bda';

/// See also [repoSearchTotalCount].
@ProviderFor(repoSearchTotalCount)
final repoSearchTotalCountProvider = AutoDisposeProvider<int?>.internal(
  repoSearchTotalCount,
  name: r'repoSearchTotalCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$repoSearchTotalCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RepoSearchTotalCountRef = AutoDisposeProviderRef<int?>;
String _$repoSearchLastPageNumberHash() =>
    r'f02969e9fb1d38a86e6bdafa02ef1e40b8e90d68';

/// See also [RepoSearchLastPageNumber].
@ProviderFor(RepoSearchLastPageNumber)
final repoSearchLastPageNumberProvider =
    AutoDisposeNotifierProvider<RepoSearchLastPageNumber, int?>.internal(
  RepoSearchLastPageNumber.new,
  name: r'repoSearchLastPageNumberProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$repoSearchLastPageNumberHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RepoSearchLastPageNumber = AutoDisposeNotifier<int?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
