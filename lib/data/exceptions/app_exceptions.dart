class AppExceptions implements Exception {
  final String? _message;
  final String? _prefix;
  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_message';
  }
}

class NoInternetConnection extends AppExceptions {
  NoInternetConnection(String? message) : super(message, "No Internet: ");
}
class AuthError extends AppExceptions {
  AuthError(String? message) : super(message, "Auth Error: ");
}
class BadRequestException extends AppExceptions {
  BadRequestException(String? message) : super(message, "Bad Request: ");
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException(String? message) : super(message, "Unauthorized: ");
}

class ForbiddenException extends AppExceptions {
  ForbiddenException(String? message) : super(message, "Forbidden: ");
}

class NotFoundException extends AppExceptions {
  NotFoundException(String? message) : super(message, "Not Found: ");
}

class MethodNotAllowedException extends AppExceptions {
  MethodNotAllowedException(String? message) : super(message, "Method Not Allowed: ");
}

class RequestTimeoutException extends AppExceptions {
  RequestTimeoutException(String? message) : super(message, "Request Timeout: ");
}

class ConflictException extends AppExceptions {
  ConflictException(String? message) : super(message, "Conflict: ");
}

class TooManyRequestsException extends AppExceptions {
  TooManyRequestsException(String? message) : super(message, "Too Many Requests: ");
}

class InternalServerException extends AppExceptions {
  InternalServerException(String? message) : super(message, "Internal Server Error: ");
}

class BadGatewayException extends AppExceptions {
  BadGatewayException(String? message) : super(message, "Bad Gateway: ");
}

class ServiceUnavailableException extends AppExceptions {
  ServiceUnavailableException(String? message) : super(message, "Service Unavailable: ");
}

class GatewayTimeoutException extends AppExceptions {
  GatewayTimeoutException(String? message) : super(message, "Gateway Timeout: ");
}
