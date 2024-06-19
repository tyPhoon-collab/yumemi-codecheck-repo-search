// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resultHash() => r'36f6380ffdb056d295d744b6f38700496ec564af';

/// エラー時は必ずGitHubRepoServiceExceptionをthrowする
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
String _$lastPageNumberHash() => r'2438b277e6afba4f45a5f133b0bf7a0621a528cb';

/// See also [LastPageNumber].
@ProviderFor(LastPageNumber)
final lastPageNumberProvider = NotifierProvider<LastPageNumber, int?>.internal(
  LastPageNumber.new,
  name: r'lastPageNumberProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$lastPageNumberHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LastPageNumber = Notifier<int?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
