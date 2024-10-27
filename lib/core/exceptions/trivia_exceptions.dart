class TriviaExceptions implements Exception {
  final String message;

  TriviaExceptions([this.message = 'An error occurred.']);

  @override
  String toString() => message;
}

class NoResultsException extends TriviaExceptions {
  NoResultsException([
    super.message = 'No Results: Not enough questions for your query.',
  ]);

  @override
  String toString() => message;
}

class InvalidParameterException extends TriviaExceptions {
  InvalidParameterException([
    super.message = 'Invalid Parameter: Arguments passed are not valid.',
  ]);

  @override
  String toString() => message;
}

class TokenNotFoundException implements Exception {
  final String message;

  TokenNotFoundException([
    this.message = 'Token Not Found: The session token does not exist.',
  ]);

  @override
  String toString() => message;
}

class TokenEmptyException implements Exception {
  final String message;

  TokenEmptyException([
    this.message =
        'Token Empty: All possible questions returned. Reset the token.',
  ]);

  @override
  String toString() => message;
}

class RateLimitException implements Exception {
  final String message;

  RateLimitException([
    this.message = 'Rate Limit: Too many requests. Please wait 5 seconds.',
  ]);

  @override
  String toString() => message;
}
