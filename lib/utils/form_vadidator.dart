extension FormValidator on String {

  bool get isValidEmail {
    final emailReg = RegExp('');
    return emailReg.hasMatch(this);
  }

  bool get isValidPassword {
    final emailReg = RegExp('');
    return emailReg.hasMatch(this);
  }

  bool get isValidContact {
    final emailReg = RegExp('');
    return emailReg.hasMatch(this);
  }

}