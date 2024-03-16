

String? validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    print('Please enter Email-id');
    return 'Please enter Email-id';
  } else {
    if (!regex.hasMatch(value)) {
      print('Enter valid Email-id');
      return 'Enter valid Email-id';
    } else {
      return null;
    }
  }
}
