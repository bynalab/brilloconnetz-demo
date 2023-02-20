validatePhoneField(String value) {
  if (value.isEmpty) {
    return "Invalid Phone Number";
  } else if (value.length < 10) {
    return "Phone number must be 10 digit";
  } else {
    return null;
  }
}

validateField(String value, String field) {
  if (value.trim().isEmpty && value.trim().isEmpty) {
    return "$field is required";
  } else {
    return null;
  }
}

validateEmailOrPhone(String value) {
  final regex = RegExp(r'[0-9]');

  if (value.isEmpty) {
    return 'Email or Phone is required';
  }

  if (regex.hasMatch(value)) {
    return validatePhoneField(value);
  }

  return validateEmailField(value);
}

validateEmailField(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  if (email == "") {
    return "Email is required";
  } else if (!regex.hasMatch(email)) {
    return "Invalid  Email";
  } else {
    return null;
  }
}

validatePasswordField(String value, [String field = 'Password']) {
  if (value.isEmpty) {
    return "$field is required";
  } else if (value.trim().length <= 2) {
    return "$field should be at least 3 character(s)";
  }

  return null;
}
