bool isRequired(String? value) {
  if (value != null && value.isNotEmpty) {
    return true;
  }

  return false;
}

bool minChars(String value, int min) {
  return value.length >= min;
}