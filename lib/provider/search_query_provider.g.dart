// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_query_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hasQueryHash() => r'470b050c647a98879563ed36d659729522b5bd40';

/// See also [hasQuery].
@ProviderFor(hasQuery)
final hasQueryProvider = AutoDisposeProvider<bool>.internal(
  hasQuery,
  name: r'hasQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$hasQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HasQueryRef = AutoDisposeProviderRef<bool>;
String _$queryHash() => r'a60ea5c78eec9e334c7154ab733cf0075cf903ac';

/// See also [Query].
@ProviderFor(Query)
final queryProvider = AutoDisposeNotifierProvider<Query, String?>.internal(
  Query.new,
  name: r'queryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$queryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Query = AutoDisposeNotifier<String?>;
String _$sortTypeHash() => r'a3cbd0948071476be59661ce036446603eeaab0d';

/// See also [SortType].
@ProviderFor(SortType)
final sortTypeProvider =
    AutoDisposeNotifierProvider<SortType, RepoSearchSortType>.internal(
  SortType.new,
  name: r'sortTypeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sortTypeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SortType = AutoDisposeNotifier<RepoSearchSortType>;
String _$pageNumberHash() => r'557e2ebaf4aae740b598cbaec204ff88127f4bc0';

/// See also [PageNumber].
@ProviderFor(PageNumber)
final pageNumberProvider =
    AutoDisposeNotifierProvider<PageNumber, int>.internal(
  PageNumber.new,
  name: r'pageNumberProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pageNumberHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PageNumber = AutoDisposeNotifier<int>;
String _$perPageNumberHash() => r'78b0f1404045b17078f11098b2c60437c5c4ad01';

/// See also [PerPageNumber].
@ProviderFor(PerPageNumber)
final perPageNumberProvider =
    AutoDisposeNotifierProvider<PerPageNumber, int>.internal(
  PerPageNumber.new,
  name: r'perPageNumberProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$perPageNumberHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PerPageNumber = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
