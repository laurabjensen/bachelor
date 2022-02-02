class Validators {
  static String? validateNotNull(
    String? field,
    param1,
  ) {
    if (field == null || field.isEmpty) {
      return 'Udfyld venligst';
    }
    return null;
  }

  static String? validateConfirmationPassword(String? password1, String? password2) {
    if (password1 != null && password2 != null) {
      if (password2.isEmpty) {
        return 'Kodeord påkrævet';
      } else if (password1 != password2) {
        return 'Kodeord ikke identiske';
      }
    }
    return null;
  }
}
