import 'package:flutter/material.dart';

class RideConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Map pin icon
              Icon(
                Icons.location_on,
                size: 300.0,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20),
              // Confirmation text
              const Text(
                'Booked! Your ride has been confirmed!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),
              // Thanks button
              ElevatedButton(
                onPressed: () {
                  // Add your button logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 50.0,
                  ),
                ),
                child: const Text(
                  'Thanks!',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
