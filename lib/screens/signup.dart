import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:project_ibs/models/users.dart';


import 'package:intl/intl.dart';

import 'login.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

enum Gender { Male, Female }
final _formKey = GlobalKey<FormState>();
bool passwordVisible = true;

@override
void initState() {
  passwordVisible = false;
}

class _SignupScreenState extends State<SignupScreen> {
  final _user = User();
  bool _obscureText = true;

  DateTime _dateTime;
  Gender _gender = Gender.Male;
  int selectedRadio;
  bool _isSelected = false;

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    // _pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('SignUp'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Name',
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.person, color: Colors.teal))),
                  maxLength: 10,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your first name';
                    }
                  },
                  onSaved: (val) => setState(() => _user.firstName = val),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Gender'),
                    Radio(
                      value: 1,
                      groupValue: selectedRadio,
                      activeColor: Colors.teal,
                      onChanged: (value) {
                        print("Radio $value");
                        setSelectedRadio(value);
                      },
                    ),
                    new Text('Male'),
                    Radio(
                      value: 2,
                      groupValue: selectedRadio,
                      activeColor: Colors.teal,
                      onChanged: (value) {
                        print("Radio $value");
                        setSelectedRadio(value);
                      },
                    ),
                    new Text('Female')
                  ],
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Email',
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.email, color: Colors.teal))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your e-mail';
                    }
                    if (!RegExp(
                            r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (val) => setState(() => _user.lastName = val),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    icon: const Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: const Icon(Icons.lock, color: Colors.teal)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          _toggle();
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (val) =>
                      val.length < 6 ? 'Password too short.' : null,
                  onSaved: (val) => _user.password = val,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    hintText: ' Confirm Password',
                    icon: const Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: const Icon(Icons.lock, color: Colors.teal)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          _toggle();
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (val) =>
                      val.length < 6 ? 'Password too short.' : null,
                  onSaved: (val) => _user.password = val,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Phone',
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.phone, color: Colors.teal))),
                  keyboardType: TextInputType.phone,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Phone Number is Required';
                    }
                    if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(value)) {
                      return 'Please enter a valid Phone Number';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    _user.phoneNumber = value;
                  },
                ),
                SizedBox(height: 10.0),
                Padding(padding: new EdgeInsets.all(20.0)),
                RaisedButton(
                  color: Colors.teal,
                  child: Text(
                    _dateTime == null
                        ? 'Select Your Date Of Birth'
                        : DateFormat('yyyy-MM-dd').format(_dateTime),
                  ),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate:
                                _dateTime == null ? DateTime.now() : _dateTime,
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2021))
                        .then((date) {
                      setState(() {
                        _dateTime = date;
                      });
                    });
                  },
                ),
                SizedBox(height: 10.0),
                Container(
                    child: CheckboxListTile(
                  title: Row(
                    children: <Widget>[
                      Text("I have accepted the",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          )),
                      Text(
                        " Terms & Condition",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.teal[500],
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _isSelected,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isSelected = newValue;
                    });
                  },
                  activeColor: Colors.teal[200],
                  checkColor: Colors.black,
                )),
                SizedBox(height: 10.0),
                Column(
                  children: <Widget>[
                    Conditional.single(
                        context: context,
                        conditionBuilder: (BuildContext context) =>
                            _isSelected == false,
                        widgetBuilder: (BuildContext context) =>
                            const RaisedButton(
                              onPressed: null,
                              child:
                                  Text('Save', style: TextStyle(fontSize: 20)),
                            ),
                        fallbackBuilder: (BuildContext context) => RaisedButton(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if (form.validate()) {
                                form.save();
                                _user.save();
                                _createDialogueBox(context);

                                _onReset(value) {
                                  setState(() {
                                    _isSelected = false;
                                    value = 0;

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  });
                                }
                              }
                            },
                            child: Text('Save'))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // ignore: unused_element
  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}

_createDialogueBox(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Success"),
        content: Text("Registered Successfully"),
        actions: <Widget>[
          FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              _formKey.currentState.reset();
            },
          )
        ],
      );
    },
  );
}
