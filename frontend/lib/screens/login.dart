import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding
import 'welcome.dart'; // Import the WelcomeScreen
import 'set_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // To show loading indicator
  String? _errorMessage; // To display error message

  // Function to handle login
  Future<void> _handleLogin() async {
    final String apiUrl = 'http://127.0.0.1:8000/api/token/';

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': _usernameController.text, // Changed to 'username'
          'password': _passwordController.text,
        }),
      );

      // Check response status
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String accessToken = data['access'];

        // Print the token (optional)
        print('Access Token: $accessToken');

        // Navigate to WelcomeScreen if login is successful
        Navigator.pushNamed(context, '/welcome');
      } else {
        // Login failed, show error message
        setState(() {
          _errorMessage = 'Invalid username or password';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Username Input Field
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Enter your username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Password Input Field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Forgot Password Button
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetPasswordScreen()),
                );
              },
              child: const Text('Forgot Password?'),
            ),

            const SizedBox(height: 24),

            // Error Message Display
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),

            // Log In Button
            ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
