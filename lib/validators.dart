import 'package:spejder_app/model/rank.dart';
import 'package:spejder_app/model/user_profile.dart';

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

  static String? validateDateNotNull(DateTime? field) {
    if (field == null) {
      return 'Udfyld venligst';
    }
    return null;
  }

  //Use for number fields
  static String? validateIsOnlyIntAndNotNull(String? field, param1) {
    if (field != null && field.isNotEmpty && !field.contains(RegExp(r'^[0-9]*$'))) {
      return 'Udfyld venligst kun tal';
    }
    if (field == null || field.isEmpty) {
      return 'Udfyld venligst';
    }
    return null;
  }

  //Use for årstjerner
  static String? validateIsOnlyIntAndNotNullAndOnlyMax2Chars(String? field, param1) {
    if (field != null && field.isNotEmpty && !field.contains(RegExp(r'^[0-9]*$'))) {
      return 'Udfyld venligst kun tal';
    }
    if (field == null || field.isEmpty) {
      return 'Udfyld venligst';
    }
    if (field.length > 2) {
      return 'Udfyld venligst kun 2 tal';
    }
    return null;
  }

  static String? validateUserNotNull(UserProfile? field) {
    if (field == null || field.id.isEmpty) {
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

  static String? validateRankNotNull(Rank? field) {
    if (field == null || field.id.isEmpty) {
      return 'Vælg venligst';
    }
    return null;
  }

  static String? validateGroupNotNull(String? field) {
    if (field == null || field.isEmpty) {
      return 'Vælg venligst';
    }
    return null;
  }
}
