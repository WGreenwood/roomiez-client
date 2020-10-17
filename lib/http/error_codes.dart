
class ErrorCodes {
  factory ErrorCodes() => null;
  static const Map<int, String> Names = {
    ServerConnectError: 'ServerConnectError',
    Success: 'Success',
    UnknownError: 'UnknownError',
    NoContentType: 'NoContentType',
    InvalidContentType: 'InvalidContentType',
    NotFound: 'NotFound',
    MissingParameter: 'MissingParameter',
    EmptyParameter: 'EmptyParameter',
    UnauthorizedAccess: 'UnauthorizedAccess',
    InvalidEmail: 'InvalidEmail',
    EmailAlreadyRegistered: 'EmailAlreadyRegistered',
    WeakPassword: 'WeakPassword',
    IncorrectLogin: 'IncorrectLogin',
    InvalidBillType: 'InvalidBillType',
    InvalidCost: 'InvalidCost',
    InvalidDate: 'InvalidDate',
    NoTimezoneInfo: 'NoTimezoneInfo',
    DateInFuture: 'DateInFuture',
    DateNotCurrentPeriod: 'DateNotCurrentPeriod',
    InvalidBillIdList: 'InvalidBillIdList'
  };
  static const Map<int, String> English = {
    ServerConnectError: 'The provided host address does not exist',
    Success: 'The operation was a success',
    UnknownError: 'The server experienced an unknown error',
    NoContentType: 'No content type was provided on request input',
    InvalidContentType: 'An unsupported content type was provided',
    NotFound: "The record you're looking for does not exist",
    MissingParameter: 'A required parameter was not provided for a request',
    EmptyParameter: 'A required parameter was empty',
    UnauthorizedAccess: 'An attempt was made to access a restricted page',
    InvalidEmail: 'An invalid email address was provided',
    EmailAlreadyRegistered: 'A user with that email address already exists',
    WeakPassword: 'Your password does not meet the complexity requirements',
    IncorrectLogin: 'An invalid username/password combination was provided',
    InvalidBillType: 'An invalid bill type was provided',
    InvalidCost: 'The cost value is incorrect',
    InvalidDate: 'The date format is incorrect',
    NoTimezoneInfo: 'No timezone info was provided with a datetime object',
    DateInFuture: "Bill's must provide the date at the beginning of the current billing cycle",
    DateNotCurrentPeriod: "Bill's must provide the date at the beginning of the current billing cycle",
    InvalidBillIdList: 'An invalid bill id list was provided'
  };

  static const int ServerConnectError = -1;
  static const int Success = 0;
  static const int UnknownError = 666;
  static const int NoContentType = 10;
  static const int InvalidContentType = 11;
  static const int NotFound = 12;

  // Basic form Errors
  static const int MissingParameter = 20;
  static const int EmptyParameter = 21;

  // Auth Errors
  static const int UnauthorizedAccess = 40;

  // Login/Register Errors
  static const int InvalidEmail = 41;
  static const int EmailAlreadyRegistered = 42;
  static const int WeakPassword = 43;
  static const int IncorrectLogin = 44;

  // Bill Field Validation Errors
  static const int InvalidBillType = 60;
  static const int InvalidCost = 61;
  static const int InvalidDate = 62;
  static const int NoTimezoneInfo = 63;
  static const int DateInFuture = 64;
  static const int DateNotCurrentPeriod = 65;
  static const int InvalidBillIdList = 66;
}