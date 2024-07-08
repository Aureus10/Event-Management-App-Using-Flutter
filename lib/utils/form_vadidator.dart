extension FormValidator on String {
  //
  bool get isValidEmail {
    final emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailReg.hasMatch(this);
  }

  // one uppercase letter, one lowercase letter, one number, one special character, and a minimum length of 8 characters:
  bool get isValidPassword {
    final emailReg =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return emailReg.hasMatch(this);
  }

  bool get isValidAge {
    return int.parse(this) < 0 && int.parse(this) > 100;
  }

  bool get isValidContact {
    final emailReg = RegExp(r'^\d{10}$');
    return emailReg.hasMatch(this);
  }
}

String? Function(String?)? emptyValidator() => (String? value) {
  if (value == null || value.isEmpty) {
    return "Please fill out this field";
  }
  return null;
};


String? Function(String?)? emailValidator() => (String? value) {
  if (value == null || value.isEmpty) {
    return "Email is required";
  }
  if (!value.isValidEmail) {
    return "Invalid Email";
  }
  return null;
};

String? Function(String?)? passwordValidator() => (String? value) {
  if (value == null || value.isEmpty) {
    return "Password is required";
  }
  if (!value.isValidPassword) {
    return "Invalid Format (length of 8 with at least 1 lowercase letter, 1 uppercase letter, 1 numerical value, and 1 symbol)";
  }
  return null;
};

String? Function(String?)? ageValidator() => (String? value) {
  if (value == null || value.isEmpty) {
    return "Age is required";
  }
  if (!value.isValidAge) {
    return "Invalid Age";
  }
  return null;
};

String? Function(String?)? contactValidator() => (String? value) {
  if (value == null || value.isEmpty) {
    return "Contact Number is required";
  }
  if (!value.isValidContact) {
    return "Invalid Format (Numbers only)";
  }
  return null;
};



