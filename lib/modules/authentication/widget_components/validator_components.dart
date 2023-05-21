String? validator(String? value) {
  if (value!.isEmpty) {
    return 'Please enter valid value';
  } else {
    return null;
  }
}
