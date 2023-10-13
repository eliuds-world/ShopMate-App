//login exceptions
class UserNotFoundAuthException implements Exception{}

class WrongPasswordAuthException implements Exception{}

//register exceptions

class WeakPasswordAuthExceptions implements Exception{}

class EmailAlreadyInUseAuthException implements Exception{}

class InvalidEmailAuthException implements Exception{}

//genericAuthExceptions

class GenericAuthException implements Exception{}

class UserNotLoggedInAuthException implements Exception{}

//database exceptions

class DatabaseAlreadyOpenException implements Exception{}
class UnableToGetDocumentsDirectoryException implements Exception{}
class DatabaseIsNotOpenedException implements Exception{}
class CouldNotDeleteUserException implements Exception{}
class UserAlreadyExistsException implements Exception{}
class CouldNotFindUserException implements Exception{}
class CouldNotDeleteListException implements Exception{}
class CouldNotFindListException implements Exception{}
class CouldNotUpdateListException implements Exception{}



