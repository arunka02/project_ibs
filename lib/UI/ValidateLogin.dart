class ValidateLogin {
  String validateEmail(String value) {
    // This validator gets called by the formState(formKey) validate() function
    // return null if valid
    // otherwise string (with the error message) if in valid
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length < 6) {
      print(value.length);
      return 'Password must be more than 6 characters';
    }
    return null;
  }
}