class LoginFailureException {
  final String message;

  const LoginFailureException([this.message = "An unknown error occurred."]);

  factory LoginFailureException.code(String code) {
    switch (code) {
      case 'weak-password':
        return const LoginFailureException('Please enter a strong password');
      case 'invalid-email':
        return const LoginFailureException(
            'Email is not valid or badly formatted');
      case 'email-already-in-user':
        return const LoginFailureException(
            'An account already exists for that email');
      case 'operation-not-allowed':
        return const LoginFailureException(
            'Operation not allowed. Please contact support for help.');
      case 'user-disabled':
        return const LoginFailureException(
            'This user has been disabled. Please contact support for help.');
      default:
        return const LoginFailureException();
    }
  }
}
