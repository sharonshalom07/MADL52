import 'package:flutter/material.dart';

void main() => runApp(const MoodLifterApp());

class MoodLifterApp extends StatelessWidget {
  const MoodLifterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mood Lifter',
      home: const MoodCard(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 11, 112, 87),
      ),
    );
  }
}

class MoodCard extends StatefulWidget {
  const MoodCard({super.key});

  @override
  State<MoodCard> createState() => _MoodCardState();
}

class _MoodCardState extends State<MoodCard> {
  bool isHappy = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => setState(() => isHappy = !isHappy),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(20),
            height: isHappy ? 300 : 250,
            width: isHappy ? 250 : 220,
            decoration: BoxDecoration(
              color: isHappy ? Colors.tealAccent.shade100 : Colors.deepPurple.shade200,
              borderRadius: BorderRadius.circular(isHappy ? 40 : 16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: const AssetImage('assets/profile.jpg'),
                ),
                const SizedBox(height: 16),
                AnimatedOpacity(
                  opacity: isHappy ? 1.0 : 0.5,
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    "Sharon Shalom",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isHappy ? Colors.blue : Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Icon(
                  isHappy ? Icons.sentiment_very_satisfied : Icons.sentiment_dissatisfied,
                  size: 40,
                  color: Colors.black87,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
