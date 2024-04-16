import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///
class FormValidation {
  static final int _minimumPasswordLength = 100;
  static final int _minimumPhoneLength = 7;
  static final int _maximumPhoneLength = 15;

  // static RegExp onlyNumbers = RegExp(r"^([0-9])");

  /// Validator genèric per a inputs amb valors de text. Només comprova que el value
  /// no sigui buit.
 /* static String? validateText(String value, BuildContext context) {
    if (value.isEmpty) {
      return AppLocalizations.of(context)!.getString("form_validation_empty");
    }
    return null;
  }*/

  ///COntrolar que hi hagi valors numérics o que estigui buit
  /*static String? validateNumericOrEmpty(String value, BuildContext context) {
    RegExp onlyNumbers = RegExp(r"^[0-9]*$");
    print(value);
    if (value.isEmpty) {
      return null;
    } else {
      if (onlyNumbers.hasMatch(value.split(" ")[0])) {
        return null;
      }
    }
    return AppLocalizations.of(context)!.getString("form_validation_numbers");
  }*/


  /// Comprova que només hi hagi valors numèrics
 /* static String? validateNumeric(String value, BuildContext context) {
    RegExp onlyNumbers = RegExp(r"^[0-9]*$");
    print(value);
    if (value.isEmpty) {
      return AppLocalizations.of(context)!.getString("form_validation_empty");
    } else {
      if (onlyNumbers.hasMatch(value.split(" ")[0])) {
        return null;
      }
    }
    return AppLocalizations.of(context)!.getString("form_validation_numbers");
  }*/

  ///Comprova numéric max 2 decimals i amb un [. o ,]
  /*static String? validateNumericWithDecimals(String value, BuildContext context) {
    RegExp priceRegex = RegExp(r"^[0-9]*[.,]?[0-9]{0,2}$");
    print(value);
    if (value.isEmpty) {
      return AppLocalizations.of(context)!.getString("form_validation_empty");
    } else {
      if (priceRegex.hasMatch(value)) {
        return null;
      }
    }
    return AppLocalizations.of(context)!.getString("form_validation_numbers_decimals");
  }*/



  static String? validateEmail(String value, BuildContext context) {
    if (value.isNotEmpty) {
      RegExp regex = new RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

      if (!regex.hasMatch(value))
        return "El formato del correo es incorrecto";
    } else {
      return "El correo esta vacio";
    }
    return null;
  }

  ///Valida una password
  ///es pot controlar la length [_minimumPasswordLength]
  ///Descomenta el text per controlar
  static String? validatePassword(String value, BuildContext context) {
    if (value.isEmpty) {
      return AppLocalizations.of(context)!.empty_password_validate;
    }
    if (value.length < 4) {
      return AppLocalizations.of(context)!.short_password;
    }
    return null;
  }

  static String? validateUsername(String value, BuildContext context) {
    if (value.isEmpty) {
      return AppLocalizations.of(context)!.empty_username;
    }
    return null;
  }

  ///Validat un teléfon entre [_minimumPhoneLength] i [_maximumPhoneLength]
  // static String? validatePhone(String value, BuildContext context) {
  //   if (value.isNotEmpty) {
  //     if (value.length < _minimumPhoneLength ||
  //         value.length > _maximumPhoneLength) {
  //       return AppLocalizations.of(context)!.getString(
  //           "form_validation_invalid_format");
  //     }
  //   } else {
  //     return AppLocalizations.of(context)!.getString("form_validation_empty");
  //   }
  //
  //   return null;
  // }

  // static String? validateWebPage(String value, BuildContext context) {
  //   if (value.isNotEmpty) {
  //     RegExp regex = RegExp(r'^(http(s)?://)?([\w-]+\.)+[\w-]+(/[\w- ;,./?%&=]*)?$');
  //     if (!regex.hasMatch(value)) {
  //       return AppLocalizations.of(context)!.getString(
  //           "form_validation_invalid_format");
  //     }
  //   } else {
  //     return AppLocalizations.of(context)!.getString("form_validation_empty");
  //   }
  //   return null;
  // }

  // static String? validateCIF(String value, BuildContext context) {
  //   if (value.isNotEmpty) {
  //     RegExp regex =  RegExp(r'([a-z]|[A-Z])[0-9]{8}$');
  //
  //     if (!regex.hasMatch(value)) {
  //       return AppLocalizations.of(context)!.getString(
  //           "form_validation_invalid_format");
  //     }
  //   } else {
  //     return AppLocalizations.of(context)!.getString("form_validation_empty");
  //   }
  //   return null;
  // }

  // static String? validateNIF(String value, BuildContext context) {
  //   if (value.isNotEmpty) {
  //     RegExp regex = RegExp(r'[0-9]{8}([a-z]|[A-Z])$');
  //
  //     if (!regex.hasMatch(value)) {
  //       return AppLocalizations.of(context)!.getString(
  //           "form_validation_invalid_format");
  //     }
  //   } else {
  //     return AppLocalizations.of(context)!.getString("form_validation_empty");
  //   }
  //   return null;
  // }

}

///Comprova que no es puguin tenir mes de dos decimals i només un punt
///Per a controlar valors amb decimals
class PriceCheck extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    String pattern = ".";
    if(newValue.text.contains(",")){
      pattern=",";
    }
    List<String> value = newValue.text.split(pattern);
    if (value.length > 2) {
      return oldValue;
    }
    if (value.length > 1) {
      if (newValue.text.split(pattern)[1].length > 2) {
        return oldValue;
      }
    }
    return newValue;
  }
}
