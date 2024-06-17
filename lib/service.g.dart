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
String _$repoSearchResultHash() => r'7c46add83d9dc7097576a36564cbaf2721fdec2f';

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
String _$queryHistoryServiceImplHash() =>
    r'11a9f701dcac843aa1e6f21c24b137246ae54ffd';

/// See also [queryHistoryServiceImpl].
@ProviderFor(queryHistoryServiceImpl)
final queryHistoryServiceImplProvider = Provider<QueryHistoryService>.internal(
  queryHistoryServiceImpl,
  name: r'queryHistoryServiceImplProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$queryHistoryServiceImplHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QueryHistoryServiceImplRef = ProviderRef<QueryHistoryService>;
String _$queryHistoryServiceHash() =>
    r'afa770471a304d34f064ac2350264f392175902e';

/// See also [queryHistoryService].
@ProviderFor(queryHistoryService)
final queryHistoryServiceProvider =
    Provider<ReactiveQueryHistoryService>.internal(
  queryHistoryService,
  name: r'queryHistoryServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$queryHistoryServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QueryHistoryServiceRef = ProviderRef<ReactiveQueryHistoryService>;
String _$queryHistoryStreamHash() =>
    r'ff0b448ddd5038859ec4db5c089f51cd39bd7c32';

/// See also [queryHistoryStream].
@ProviderFor(queryHistoryStream)
final queryHistoryStreamProvider = StreamProvider<List<String>>.internal(
  queryHistoryStream,
  name: r'queryHistoryStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$queryHistoryStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QueryHistoryStreamRef = StreamProviderRef<List<String>>;
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
String _$sortTypeValueHash() => r'8e1018e254dc1d709d05e98b03a04afc1544524c';

/// See also [SortTypeValue].
@ProviderFor(SortTypeValue)
final sortTypeValueProvider =
    AutoDisposeNotifierProvider<SortTypeValue, SortType>.internal(
  SortTypeValue.new,
  name: r'sortTypeValueProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sortTypeValueHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SortTypeValue = AutoDisposeNotifier<SortType>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
