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
  DateTime _pickedDate;
  DateTime _dateTime;
  int _genderValue;
  bool _autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  int selectedRadio;
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    _pickedDate = DateTime.now();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildName() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              decoration:InputDecoration(
                hintText: 'Name',
                icon: const Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: const Icon(Icons.person, color: Colors.teal)),
                
              ),
              maxLength: 10,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Name is Required';
                }
              },
              onSaved: (String value) {
                _user.name = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Email',
                icon: const Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: const Icon(Icons.email, color: Colors.teal)),
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Email id is Required';
                }
                if (!RegExp(
                        r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              onSaved: (String value) {
                _user.email = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              obscureText: passwordVisible,
              controller: _pass,
              decoration: InputDecoration(
                hintText: 'Password',
                icon: const Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: const Icon(Icons.lock, color: Colors.teal)),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility_off : Icons.visibility,
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
              validator: (val) => val.length < 6 ? 'Password too short.' : null,
              onSaved: (val) => _user.password = val,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPassword() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
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
          ),
        ],
      ),
    );
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  Widget _buildPhoneNumber() {
    return Container(
      child: Row(
        children: <Widget>[
          /* Icon(
            Icons.phone,
            color: Colors.teal,
          ), */
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Phone No.',
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
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSex() {
    return Container(
      child: Row(
        children: <Widget>[
          Text('Gender',style: TextStyle(color:Colors.grey[700],fontSize: 16)),

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

  Widget _buildDate() {
    return Container(
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
            child: IconButton(
              icon: Icon(Icons.arrow_drop_down_circle),
              color: Colors.teal,
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate:
                            _dateTime == null ? DateTime.now() : _dateTime,
                        firstDate: DateTime(1980),
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
    );
  }

  Widget _buildAgree() {
    return Container(
        child: CheckboxListTile(
      title: Row(
        children: <Widget>[Padding(padding: EdgeInsets.only(right:0.11),
         child: Text("I have accepted the",
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ))),
          InkWell(
            onTap: () {
              _createDialogueBox(context, TC_DLG_TITLE, TC_DLG_MSG, "TC_Link");
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
            child: Padding(
              padding: const EdgeInsets.only(right: 0.11),
              child: Text(
                " Terms & Condition",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
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
    ));
  }

  Widget _buildButton(bool _isSelected) {
    return Column(
      children: <Widget>[
        Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) => _isSelected == false,
            widgetBuilder: (BuildContext context) => const RaisedButton(
                  onPressed: null,
                  child: Text('SignUp', style: TextStyle(fontSize: 20)),
                ),
            fallbackBuilder: (BuildContext context) => RaisedButton(
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    _user.save();
                    _createDialogueBox(
                        context, SAVE_DLG_TITLE, SAVE_DLG_MSG, "Save");
                  } else {
                    setState(() {
                      _autoValidate = true;
                    });
                  }
                },
                child: Text('Submit', style: TextStyle(color:Colors.teal ,fontSize: 20)))),
      ],
    );
  }

  Widget _switchLogin() {
    return Padding(
      padding: const EdgeInsets.only(left: 60),
      child: Row(children: <Widget>[
        Text("Already have an account?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            )),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: Text(
            " Login!!",
            style: TextStyle(color: Colors.teal, fontSize: 16,fontStyle: FontStyle.italic ),
          ),
        )
      ]),
    );
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

  _onReset() {
    setState(() {
      _isSelected = false;
      _genderValue = 1;
      _autoValidate = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("SIGN UP")),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildSex(),
                SizedBox(
                  height: 10,
                ),
                _buildDate(),
                SizedBox(
                  height: 10,
                ),
                _buildPhoneNumber(),
                SizedBox(
                  height: 10,
                ),
                _buildEmail(),
                SizedBox(
                  height: 10,
                ),
                _buildPassword(),
                SizedBox(
                  height: 10,
                ),
                _buildConfirmPassword(),
                SizedBox(
                  height: 30,
                ),
                _buildAgree(),
                SizedBox(
                  height: 10,
                ),
                _buildButton(_isSelected),
                SizedBox(height: 10),
                _switchLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
