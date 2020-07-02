import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:project_ibs/models/users.dart';

import 'package:intl/intl.dart';
import 'package:project_ibs/utils/constants.dart';

import 'login.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

enum Gender { Male, Female }
final _formKey = GlobalKey<FormState>();
final TextEditingController _pass = TextEditingController();
final TextEditingController _confirmPass = TextEditingController();

bool passwordVisible = true;
bool passwordVisible1 = true;

@override
void initState() {
  passwordVisible = false;
  passwordVisible1 = false;
}

class _SignupScreenState extends State<SignupScreen> {
  final _user = User();
  bool _obscureText = true;
  bool _obscureText1 = true;
  int _genderValue;

  DateTime _dateTime;
  Gender _gender = Gender.Male;
  int selectedRadio;
  bool _isSelected = false;
  bool _autoValidate = false;

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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Builder(
            builder: (context) => Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  //Name Widget
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Name',
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.person, color: Colors.teal)),
                      // border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0)),
                    ),
                    maxLength: 10,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your name';
                      }
                    },
                    onSaved: (val) => setState(() => _user.name = val),
                  ),
                  SizedBox(height: 10.0),

                  //Gender Widget
                  _createImageGenderButton(),
                  SizedBox(height: 10.0),

                  //Date of birth picker
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          _dateTime == null
                              ? 'Select Date Of Birth'
                              : DateFormat('yyyy-MM-dd').format(_dateTime),
                        ),
                        Ink(
                          /* decoration: ShapeDecoration(
                            color: Colors.teal,
                            shape: CircleBorder(),
                          ), */
                          child: IconButton(
                            icon: Icon(Icons.arrow_drop_down_circle),
                            color: Colors.teal,
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: _dateTime == null
                                          ? DateTime.now()
                                          : _dateTime,
                                      firstDate: DateTime(1990),
                                      lastDate: DateTime(2021))
                                  .then((date) {
                                setState(() {
                                  _dateTime = date;
                                });
                              });
                            },
                            
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),

                  //Email Widget
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Email',
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child:
                                const Icon(Icons.email, color: Colors.teal))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your e-mail';
                      }
                      if (!RegExp(
                              r"^(\s*[a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}\s*)$")
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (val) => setState(() => _user.email = val),
                  ),
                  SizedBox(height: 10.0),

                  //Password Widget
                  TextFormField(
                    obscureText: passwordVisible,
                    controller: _pass,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.lock, color: Colors.teal)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
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

                  //Confirm Password Widgets
                  TextFormField(
                    obscureText: passwordVisible1,
                    controller: _confirmPass,
                    decoration: InputDecoration(
                      hintText: ' Confirm Password',
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.lock, color: Colors.teal)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible1
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _toggle1();
                            passwordVisible1 = !passwordVisible1;
                          });
                        },
                      ),
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please Confirm password';
                      }
                      if (val != _pass.text) {
                        return 'Password does not Match';
                      } else
                        return null;
                    },
                    onSaved: (val) => _user.password = val,
                  ),
                  SizedBox(height: 10.0),

                  //Phone Number Widgets
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Phone',
                        icon: const Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child:
                                const Icon(Icons.phone, color: Colors.teal))),
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

                  //Terms and Condition Widgets
                  Container(
                      child: CheckboxListTile(
                    title: Row(
                      children: <Widget>[
                        Text("I have accepted the",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            )),
                        InkWell(
                          onTap: () {
                            _createDialogueBox(
                                context, TC_DLG_TITLE, TC_DLG_MSG, "TC_Link");
                          },
                          /* This can be used when valid url is present
                                    () async {
                                  String url = "https://wwww.google.com";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },*/
                          child: Text(
                            " Terms & Condition",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontStyle: FontStyle.italic,
                                color: Colors.blue[900],
                                fontWeight: FontWeight.w500),
                          ),
                        )
                        /*  Text(
                        " Terms & Condition",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.teal[500],
                            fontWeight: FontWeight.w500),
                       ),*/
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

                  //Sumbit Buttom Widget
                  Column(
                    children: <Widget>[
                      Conditional.single(
                          context: context,
                          conditionBuilder: (BuildContext context) =>
                              _isSelected == false,
                          widgetBuilder: (BuildContext context) =>
                              const RaisedButton(
                                onPressed: null,
                                child: Text('Signup',
                                    style: TextStyle(fontSize: 20)),
                              ),
                          fallbackBuilder: (BuildContext context) =>
                              RaisedButton(
                                  onPressed: () {
                                    final form = _formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                      _user.save();
                                      _createDialogueBox(context,
                                          SAVE_DLG_TITLE, SAVE_DLG_MSG, "Save");

                                      _onReset(value) {
                                        setState(() {
                                          _isSelected = false;
                                          value = 0;

                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()));
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        _autoValidate = true;
                                      });
                                    }
                                  },
                                   child: Text('Save'))),
                      )],
                  ),
                ],
              ),
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

  void _toggle1() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // ignore: unused_element
  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }

  _createImageGenderButton() {
    return Container(
      child: Row(
        children: <Widget>[
          Text('Gender'),
          SizedBox(
            width: 45,
          ),
          Container(
              height: 38,
              width: 38,
              color: _genderValue == 1 ? Colors.teal : Colors.transparent,
              child: GestureDetector(
                child: Image.asset('assets/man.png'),
                onTap: () {
                  setState(() => _genderValue = 1);
                },
              )),
          SizedBox(width: 35),
          Container(
              height: 38,
              width: 38,
              color: _genderValue == 2 ? Colors.teal : Colors.transparent,
              child: GestureDetector(
                child: Image.asset('assets/woman.png'),
                onTap: () {
                  setState(() => _genderValue = 2);

                  print(_genderValue);
                },
              )),
        ],
      ),
    );
  }

  _onReset() {
    setState(() {
      _isSelected = false;
      _genderValue = 1;
      _autoValidate = false;
    });
  }

  _createDialogueBox(
      BuildContext context, String title, String msg, String buttonName) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (buttonName == "Save") {
                  _formKey.currentState.reset();

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));

                  _onReset();
                }
              },
            )
          ],
        );
      },
    );
  }
}
