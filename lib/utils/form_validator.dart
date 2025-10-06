
class FormValidator {
FormValidator._();
 static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return "Kindly enter First name";
    }
    return null;
  }
  static String? validatePhoneNo(String? value) {
    if (value == null || value.isEmpty) {
      return "Kindly enter Phone no";
    }
    return null;
  }
static String? validateUserName(String? value) {
  if (value == null || value.isEmpty) {
    return "Kindly enter username";
  }
  return null;
}
static String? validatePassword(String? value,String? value2) {
  if (value == null || value.isEmpty) {
    return "Password is required";
  }
  if (value.length < 8) {
    return "Password must be at least 8 characters long";
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return "Password must contain at least one uppercase letter";
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return "Password must contain at least one lowercase letter";
  }
  if (!RegExp(r'\d').hasMatch(value)) {
    return "Password must contain at least one number";
  }
  if (!RegExp(r'[!@#\$&*~%^()_\-+=<>?/\\|{}\[\]]').hasMatch(value)) {
    return "Password must contain at least one special character";
  }
  if (value2 == null || value2.isEmpty) {
    return "Kindly renter password";
  }
  if(value!=value2){
    return "Password mismatch";
  }

  return null; // valid password
}
 static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return "Kindly enter Last name";
    }
    return null;
  }
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Kindly enter email";
    }

    // Basic email regex pattern
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return "Please enter a valid email";
    }

    return null;
  }
}
