// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resultHash() => r'76b2555c70dfb9b8b4668c8ad75a6697f7cbfacf';

/// エラー時は必ずGitHubRepoServiceExceptionをthrowする
/// Sが初期化されている必要があり、やや責務が大きいが、一旦おいておく
///
/// Copied from [result].
@ProviderFor(result)
final resultProvider = AutoDisposeFutureProvider<RepoSearchResult?>.internal(
  result,
  name: r'resultProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$resultHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ResultRef = AutoDisposeFutureProviderRef<RepoSearchResult?>;
String _$totalCountHash() => r'9100d7160d8676a5d09eb2d38ec5baf418278599';

/// See also [totalCount].
@ProviderFor(totalCount)
final totalCountProvider = AutoDisposeProvider<int?>.internal(
  totalCount,
  name: r'totalCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$totalCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TotalCountRef = AutoDisposeProviderRef<int?>;
String _$lastPageNumberHash() => r'8c082dbe6a14eec2d82b9de19148f186473522bd';

/// See also [LastPageNumber].
@ProviderFor(LastPageNumber)
final lastPageNumberProvider =
    AutoDisposeNotifierProvider<LastPageNumber, int?>.internal(
  LastPageNumber.new,
  name: r'lastPageNumberProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lastPageNumberHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LastPageNumber = AutoDisposeNotifier<int?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
