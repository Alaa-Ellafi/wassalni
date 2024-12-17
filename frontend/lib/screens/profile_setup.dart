import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ProfileSetupScreen extends StatefulWidget {
  final Map<String, String> userData;

  ProfileSetupScreen({required this.userData});

  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? profileAvatarImage;
  bool allowEdit = true;

  String? _firstName;
  String? _lastName;
  String? _username;
  String? _phoneNumber;
  String? _cin;
  String? _birthdate;
  final TextEditingController _birthdateController = TextEditingController();

  Future<void> _saveProfileData() async {
    final data = {
      ...widget.userData,
      'first_name': _firstName,
      'last_name': _lastName,
      'username': _username,
      'phone_number': _phoneNumber,
      'CIN': _cin,
      'birth_date': _birthdate,
    };
    print(_birthdate);
    final url = Uri.parse('http://127.0.0.1:8000/core/register/');
    final body = jsonEncode(data);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      //  print(response.body); // Add this in your Flutter app to debug the error

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/intro');
      } else {
        final error = jsonDecode(response.body)['error'];
        _showError(error ?? 'Profile setup failed');
      }
    } catch (e) {
      _showError('An error occurred. Please try again.');
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Setup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ProfileAvatar(
                  image: profileAvatarImage,
                  radius: 50,
                  allowEdit: allowEdit,
                  addImageIcon: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.add_a_photo),
                    ),
                  ),
                  removeImageIcon: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.close),
                    ),
                  ),
                  onImageChanged: (image) {
                    setState(() {
                      profileAvatarImage = image;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'First Name'),
                  onChanged: (value) => _firstName = value,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Last Name'),
                  onChanged: (value) => _lastName = value,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  onChanged: (value) => _username = value,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _birthdateController,
                  decoration: InputDecoration(
                    labelText: 'Birthdate',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _birthdate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        _birthdateController.text = _birthdate!;
                      });
                    }
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        hint: Text('+216'),
                        items: [
                          DropdownMenuItem(
                            child: Text('+216'),
                            value: '+216',
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 5,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) => _phoneNumber = value,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'CIN'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _cin = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your CIN';
                    }
                    if (value.length != 8 ||
                        !RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'CIN must be exactly 8 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _saveProfileData();
                          }
                        },
                        child: Text('Save'),
                      ),
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
}

class ProfileInputField extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool obscureText;

  ProfileInputField({
    required this.label,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
