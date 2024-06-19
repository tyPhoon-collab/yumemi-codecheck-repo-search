// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resultHash() => r'69c73928e07bad0d515267fdf50f2eed32c4ffbf';

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
String _$totalCountHash() => r'8d405f243e3c05071f75ed2b5ba16814bf7eb5d7';

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
