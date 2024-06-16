import 'package:mocktail/mocktail.dart';
import 'package:yumemi_codecheck_repo_search/service/github_repo_service.dart';
import 'package:yumemi_codecheck_repo_search/service/query_history_service.dart';

class MockGtHubRepoService extends Mock implements GitHubRepoService {}

class MockQueryHistoryService extends Mock implements QueryHistoryService {}
