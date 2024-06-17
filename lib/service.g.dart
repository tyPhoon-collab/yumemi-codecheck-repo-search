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
String _$repoSearchResultHash() => r'495fe7114e7028831f62bc99c872150f13654f1b';

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
String _$repoSearchSortTypeHash() =>
    r'57e8245c7a9947a6f55aedb00ae4dd6884fd6f8d';

/// See also [RepoSearchSortType].
@ProviderFor(RepoSearchSortType)
final repoSearchSortTypeProvider =
    AutoDisposeNotifierProvider<RepoSearchSortType, SortType>.internal(
  RepoSearchSortType.new,
  name: r'repoSearchSortTypeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$repoSearchSortTypeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RepoSearchSortType = AutoDisposeNotifier<SortType>;
String _$repoSearchPageHash() => r'89690258464d1d9e7107f3fe57ed4e04b1d3efbc';

/// See also [RepoSearchPage].
@ProviderFor(RepoSearchPage)
final repoSearchPageProvider =
    AutoDisposeNotifierProvider<RepoSearchPage, int>.internal(
  RepoSearchPage.new,
  name: r'repoSearchPageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$repoSearchPageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RepoSearchPage = AutoDisposeNotifier<int>;
String _$repoSearchPerPageHash() => r'bbc4586db38b6f4857c7d50292d3d3a5be1ea39b';

/// See also [RepoSearchPerPage].
@ProviderFor(RepoSearchPerPage)
final repoSearchPerPageProvider =
    AutoDisposeNotifierProvider<RepoSearchPerPage, int>.internal(
  RepoSearchPerPage.new,
  name: r'repoSearchPerPageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$repoSearchPerPageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RepoSearchPerPage = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
