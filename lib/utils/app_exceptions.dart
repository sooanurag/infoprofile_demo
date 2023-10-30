class AppExceptions implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() => "$_prefix:\n$_message";
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message, "Error during communication");
}

class Uint8ListConvertException extends AppExceptions {
  Uint8ListConvertException([String? message])
      : super(message, "Error converting file to Uint8List");
}

class AWSBucketException extends AppExceptions {
  AWSBucketException([String? message])
      : super(message, "Error while uploading");
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, "Invalid Request");
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message])
      : super(message, "Unauthorized Request");
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message]) : super(message, "Invalid input");
}
