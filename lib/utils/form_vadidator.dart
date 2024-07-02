extension FormValidator on String {

  //
  bool get isValidEmail {
    final emailReg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailReg.hasMatch(this);
  }

  // one uppercase letter, one lowercase letter, one number, one special character, and a minimum length of 8 characters:
  bool get isValidPassword {
    final emailReg = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return emailReg.hasMatch(this);
  }

  bool get isValidContact {
    final emailReg = RegExp(r'^\d{10}$');
    return emailReg.hasMatch(this);
  }

}