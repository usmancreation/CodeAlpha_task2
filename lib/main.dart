import 'package:flutter/material.dart';
import 'dart:math'; // Random number generate karne ke liye
import 'package:google_fonts/google_fonts.dart'; // Professional fonts ke liye

void main() {
  runApp(const QuoteApp());
}

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const QuotePage(),
    );
  }
}

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  // Quotes ki list (Aap aur bhi add kar sakte hain)
  final List<Map<String, String>> quotes = [
    {"quote": "The only way to do great work is to love what you do.", "author": "Steve Jobs"},
    {"quote": "Life is what happens when you're busy making other plans.", "author": "John Lennon"},
    {"quote": "Get busy living or get busy dying.", "author": "Stephen King"},
    {"quote": "You only live once, but if you do it right, once is enough.", "author": "Mae West"},
    {"quote": "Success is not final, failure is not fatal: It is the courage to continue that counts.", "author": "Winston Churchill"},
    {"quote": "Believe you can and you're halfway there.", "author": "Theodore Roosevelt"},
    {"quote": "It does not matter how slowly you go as long as you do not stop.", "author": "Confucius"},
    {"quote": "Everything you can imagine is real.", "author": "Pablo Picasso"},
    {"quote": "Whatever you are, be a good one.", "author": "Abraham Lincoln"},
    {"quote": "Your time is limited, so don't waste it living someone else's life.", "author": "Steve Jobs"},
  ];

  // Variables jo change honge
  int currentIndex = 0;
  int randomImageId = 1; // Image change karne ke liye random number

  // Random Quote aur Image generate karne ka function
  void generateNewQuote() {
    setState(() {
      // Random index select karega (0 se list ki length tak)
      currentIndex = Random().nextInt(quotes.length);
      // Random number image URL change karne ke liye (taake har baar nayi image aaye)
      randomImageId = Random().nextInt(1000); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // LAYER 1: Background Image (Network se aayegi)
          Positioned.fill(
            child: Image.network(
              // Picsum ek free API hai jo random images deti hai
              'https://picsum.photos/seed/$randomImageId/800/1200',
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator(color: Colors.white));
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.black); // Agar net na ho to black background
              },
            ),
          ),

          // LAYER 2: Black Overlay (Taake text saaf nazar aaye)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // 50% dark overlay
            ),
          ),

          // LAYER 3: Main Content (Quote Card)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Glassmorphism Card
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2), // Transparent White
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        // Quote Icon
                        const Icon(Icons.format_quote, color: Colors.white70, size: 50),
                        const SizedBox(height: 20),
                        
                        // Quote Text
                        Text(
                          quotes[currentIndex]['quote']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato( // Google Font use kiya
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Author Name
                        Text(
                          "- ${quotes[currentIndex]['author']}",
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 50),

                  // Button
                  ElevatedButton.icon(
                    onPressed: generateNewQuote,
                    icon: const Icon(Icons.refresh),
                    label: const Text("New Quote"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal, // Text color
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 10,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}