class User {
  static const String PassionCooking = 'cooking';
  static const String PassionHiking = 'hiking';
  static const String PassionTraveling = 'traveling';

  String firstName = '';
  String lastName = '';
  String password = '';

  Map<String, bool> passions = {
    PassionCooking: false,
    PassionHiking: false,
    PassionTraveling: false
  };
  bool gender = false;

  save() {
    print('saving user using a web service');
  }
}
