//Fire
//ase authentication error handling
// Take error code from firebase and display meaningful message to the user

class AuthErrors {
  static String getErrorText(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Invalid Email address.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'user-not-found':
        return 'User with this email doesn\'t exist.';
      case 'user-disabled':
        return 'User with this email has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Try again later.';
      case 'email-already-in-use':
        return 'The email is already in use by another account.';
      case 'operation-not-allowed':
        return 'Signing in with Email and Password is not enabled.';
      case 'weak-password':
        return 'The password must be 6 characters long or more.';
      default:
        return 'An undefined Error happened.';
    }
  }
}
