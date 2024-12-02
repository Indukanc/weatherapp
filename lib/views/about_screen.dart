import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('App Info')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Weather App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'This app allows you to search for the current weather of any city using OpenWeatherMap API.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Powered By'),
            Image.asset('assets/images/lotus.png'),
          ],
        ),
      ),
    );
  }
}
