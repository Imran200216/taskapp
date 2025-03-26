class AppValidator {
  /// Validate email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  /// Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  /// Validate confirm password
  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Confirm password is required";
    } else if (password != confirmPassword) {
      return "Passwords do not match";
    }
    return null;
  }

  /// Validate name (optional)
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    } else if (value.length < 3) {
      return "Name must be at least 3 characters long";
    }
    return null;
  }
}
