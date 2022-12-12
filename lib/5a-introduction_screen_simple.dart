import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroductionPage(),
    );
  }
}

// Introduction Page
class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Introduction Screen Page-1",
          body: "Welcome to the app! This is a description of how it works.",
          image: const Center(
            child: Icon(Icons.waving_hand, size: 100.0),
          ),
        ),
        PageViewModel(
          title: "Introduction Screen Page-2",
          body: "Welcome to the app! This is a description of how it works.",
          image: const Center(
            child: Icon(Icons.handshake, size: 100.0),
          ),
        ),
      ],
      showNextButton: false,
      done: const Text("Done"),
      onDone: () {
        // On button pressed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Introduction Screen"),
      ),
      body: Center(
        child: Text("Welcome To Home Page"),
      ),
    );
  }
}
