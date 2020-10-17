
bool regexMatches(String regex, String value) {
  final regexp = RegExp(regex);
  return regexp.hasMatch(value);
}

String hostAddress(String value) {
  value = value.trim();
  if (value.isEmpty)
    return 'A host address is required';
  // ?TODO: Better host address validation
  return null;
}

String displayName(String value) {
  value = value.trim();
  if (value.isEmpty)
    return 'Display name must not be empty';
  return null;
}

String email(String value) {
  value = value.trim();
  if (value.isEmpty)
    return 'An email address is required';
  final emailRegex = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+$)';
  if (!regexMatches(emailRegex, value))
    return 'An invalid email address was provided';
  return null;
}

String password(String value) {
  value = value.trim();
  if (value.isEmpty)
    return 'A password is required';

  if (!regexMatches(r'\d', value))
    return 'A password must have at least 1 digit';
  if (!regexMatches(r'[A-Z]', value))
    return 'A password must have at least 1 uppercase character';
  if (!regexMatches(r'[a-z]', value))
    return 'A password must have at least 1 lowercase character';
  final String symbolRegex = r"[ !@#$%&'()*+,-./[\\\]^_`{|}~<>" + r'"]';
  if (!regexMatches(symbolRegex, value)) {
    return 'A password must have at least 1 symbol';
  }
  return null;
}

String cost(String value) {
  value = value.trim();
  if (value.isEmpty)
    return 'A cost is required';
  if (!regexMatches(r'^\d*(?:\.\d{2})?$', value)) {
    return 'Invalid cost provided';
  }
  return null;
}