class PasswordValidator {
  static String? validate(String value) {
    return value.length < 6 ? 'Password too short.' : null;
  }
}
