// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gitHubRepoServiceHash() => r'f8587e1b341348f84be29790ba117790d321177a';

/// See also [gitHubRepoService].
@ProviderFor(gitHubRepoService)
final gitHubRepoServiceProvider = Provider<GitHubRepoService>.internal(
  gitHubRepoService,
  name: r'gitHubRepoServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gitHubRepoServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GitHubRepoServiceRef = ProviderRef<GitHubRepoService>;
String _$repoSearchResultHash() => r'8d88a1045efc46dd9d08413d939ee4b86b54989d';

/// See also [repoSearchResult].
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
String _$queryHistoryServiceHash() =>
    r'576fcec6f9d9403a5427b43fcad61e1e8f4b5f69';

/// See also [queryHistoryService].
@ProviderFor(queryHistoryService)
final queryHistoryServiceProvider =
    AutoDisposeProvider<QueryHistoryService>.internal(
  queryHistoryService,
  name: r'queryHistoryServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$queryHistoryServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QueryHistoryServiceRef = AutoDisposeProviderRef<QueryHistoryService>;
String _$queryHistoryHash() => r'4476479e7089ba56cac733edba3f9edbd916f78d';

/// See also [queryHistory].
@ProviderFor(queryHistory)
final queryHistoryProvider = AutoDisposeFutureProvider<List<String>>.internal(
  queryHistory,
  name: r'queryHistoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$queryHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QueryHistoryRef = AutoDisposeFutureProviderRef<List<String>>;
String _$repoSearchQueryHash() => r'96f1113bc8cea6b11097df9ea35e3baf1ccf9534';

/// See also [RepoSearchQuery].
@ProviderFor(RepoSearchQuery)
final repoSearchQueryProvider =
    AutoDisposeNotifierProvider<RepoSearchQuery, String?>.internal(
  RepoSearchQuery.new,
  name: r'repoSearchQueryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$repoSearchQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RepoSearchQuery = AutoDisposeNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
