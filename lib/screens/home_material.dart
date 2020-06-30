import 'package:flutter/material.dart';
import 'package:ibs_signup/models/user.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class HomeMaterial extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();
}

enum Gender { Male, Female }
 final _formKey = GlobalKey<FormState>();
bool passwordVisible = true;

@override
  void initState() {
    passwordVisible = true;
  }

class _HomeMaterialState extends State<HomeMaterial> {
  final _user = User();
   bool _obscureText = true;
 
  bool _isSelected = false;
  DateTime _dateTime;

  Gender _gender = Gender.Male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('Profile')),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name',
                  icon: const Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: const Icon(Icons.supervised_user_circle))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your first name';
                    }
                  },
                  onSaved: (val) => setState(() => _user.firstName = val),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email',
                  icon: const Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: const Icon(Icons.email))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your e-mail';
                    }
                    if(!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$").hasMatch(value)){
                  return 'Please enter a valid email address';

                }
                return null;
              
                  },
                  onSaved: (val) => setState(() => _user.lastName = val),
                ),
                TextFormField(
                  obscureText: !passwordVisible,
              decoration: InputDecoration(
                        
                        labelText: 'Password',
       hintText: 'Enter your password',
       icon: const Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: const Icon(Icons.lock)),
       suffixIcon: IconButton(
            icon: Icon(
              passwordVisible
               ? Icons.visibility
               : Icons.visibility_off,
               color: Theme.of(context).primaryColorDark,
               ),
               onPressed: () {
                
               // Update the state i.e. toogle the state of passwordVisible variable
               setState(() {
                 _toggle();
                   passwordVisible = passwordVisible;
               });
               },
       ),
              ),
              
              validator: (val) => val.length < 6 ? 'Password too short.' : null,
              onSaved: (val) => _user.password = val,
            ),
           
            Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Male'),
                      leading: Radio(
                        value: Gender.Male,
                        groupValue: _gender,
                        onChanged: (Gender value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Female'),
                      leading: Radio(
                        value: Gender.Female,
                        groupValue: _gender,
                        onChanged: (Gender value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                    Text(_dateTime == null
                        ? 'Select Your Date Of Birth'
                        : _dateTime.toString()),
                    RaisedButton(
                      child: Text('Pick a date'),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: _dateTime == null
                                    ? DateTime.now()
                                    : _dateTime,
                                firstDate: DateTime(2001),
                                lastDate: DateTime(2021))
                            .then((date) {
                          setState(() {
                            _dateTime = date;
                          });
                        });
                      },
                    ),
                  ],
                ),
                LabeledCheckbox(
                  label: 'I Accept the terms & Conditions',
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  value: _isSelected,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isSelected = newValue;
                    });
                  },
                ),

            

                Column(
                      
                      children: <Widget>[
                      Conditional.single(
                        context: context,
                              conditionBuilder: (BuildContext context) => _isSelected == false,
                              widgetBuilder: (BuildContext context) => const RaisedButton(
            onPressed: null,
            child: Text('Save', style: TextStyle(fontSize: 20)),
          ),
                              fallbackBuilder: (BuildContext context) => 
           RaisedButton(
                                  onPressed: () {
                                    final form = _formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                      _user.save();
                                      _createDialogueBox(context);
                                    }
                                  },
                                  child: Text('Save'))
                        ),
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

 

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
