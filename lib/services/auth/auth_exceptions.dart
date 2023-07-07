//login excepitons
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

//register exception
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

//generic exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

//empty field
class EmptyFieldAuthException implements Exception {}
