// Daily Motivation+ App - Flutter Version with Author Info
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Motivation+',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF02B368),
        scaffoldBackgroundColor: const Color(0xFFFFFBF0),
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      home: const MotivationPage(),
    );
  }
}

class MotivationPage extends StatefulWidget {
  const MotivationPage({super.key});

  @override
  State<MotivationPage> createState() => _MotivationPageState();
}

class _MotivationPageState extends State<MotivationPage> {
  List<dynamic> quotesList = [];
  Map<String, dynamic>? lastQuote;

  final Color cardColor = Color(0xFFFAFAFA); // soft neutral for readability

  @override
  void initState() {
    super.initState();
    loadQuotes();
  }

  Future<void> loadQuotes() async {
    final String jsonString = await rootBundle.loadString('assets/quotes.json');
    final List<dynamic> data = json.decode(jsonString);
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      quotesList = data;
      final saved = prefs.getString('lastQuote');
      if (saved != null) {
        lastQuote = json.decode(saved);
      }
    });
  }

  void acakQuote() async {
    if (quotesList.isEmpty) return;
    final random = Random();
    final terpilih = quotesList[random.nextInt(quotesList.length)];
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastQuote', json.encode(terpilih));

    setState(() {
      lastQuote = terpilih;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Daily Motivation+',
          style: GoogleFonts.nunito(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ElevatedButton.icon(
                onPressed: acakQuote,
                icon: const Icon(Icons.bolt),
                label: const Text('Tampilkan Motivasi Acak'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF02B368),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: const StadiumBorder(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (lastQuote != null) ...[
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  key: ValueKey(lastQuote!['teks']),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF02B368), Color(0xFFFED833)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text('💡', style: TextStyle(fontSize: 32)),
                      const SizedBox(height: 12),
                      Text(
                        (lastQuote!['teks'] ?? '').trim(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        (lastQuote!['arti'] ?? '').trim(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '- ${lastQuote!['author'] ?? 'Anonymous'}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton.icon(
                        onPressed: () {
                          final quoteText = (lastQuote!['teks'] ?? '').trim();
                          final arti = (lastQuote!['arti'] ?? '').trim();
                          final author = lastQuote!['author'] ?? 'Anonymous';

                          final fullText =
                              '"$quoteText"\n\n$arti\n\n- $author\n\n📲 via Daily Motivation+';
                          Share.share(fullText);
                        },
                        icon: const Icon(Icons.share, color: Colors.white),
                        label: Text(
                          "Bagikan quote ini",
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          shape: const StadiumBorder(),
                          backgroundColor: Colors.white.withOpacity(
                            0.0,
                          ), // invisible bg
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const Divider(height: 32),
            Text(
              "Kumpulan Motivasi:",
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: quotesList.length,
                itemBuilder: (context, index) {
                  final item = quotesList[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.format_quote_rounded,
                        color: Color(0xFF02B368),
                      ),
                      title: Text(
                        item['teks'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        '${item['arti'] ?? ''}\n- ${item['author'] ?? 'Anonymous'}',
                        style: const TextStyle(
                          height: 1.3,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
