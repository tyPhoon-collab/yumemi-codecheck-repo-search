import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';

typedef GRSException = GitHubRepoServiceException;

class GitHubRepoServiceException implements Exception {
  const GitHubRepoServiceException([this._message = '']);

  final String _message;
  String get message => _message;
}

class ValidationGRSException extends GRSException {
  const ValidationGRSException();

  @override
  String get message => S.current.errorValidation;
}

class ServiceUnavailableGRSException extends GRSException {
  const ServiceUnavailableGRSException();

  @override
  String get message => S.current.errorServiceUnavailable;
}

class NoInternetGRSException extends GRSException {
  const NoInternetGRSException();

  @override
  String get message => S.current.errorNoInternet;
}

class UnexpectedGRSException extends GRSException {
  const UnexpectedGRSException();

  @override
  String get message => S.current.errorUnexpected;
}
