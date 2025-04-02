import 'package:flutter/material.dart';
import 'package:grocify/widgets/product_details/product_card.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:grocify/providers/admin_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: (result) {
        setState(() {
          _searchQuery = result.recognizedWords;
        });
        _performSearch();
      },
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _performSearch() {
    final adminProvider = Provider.of<AdminProvider>(context, listen: false);
    adminProvider.searchProducts(_searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Search'),
        actions: [
          if (_searchQuery.isNotEmpty)
            IconButton(
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                });
                final adminProvider = Provider.of<AdminProvider>(
                  context,
                  listen: false,
                );
                adminProvider.clearSearch();
              },
              icon: const Icon(Icons.clear),
            ),
        ],
      ),
      floatingActionButton:
          _searchQuery.isNotEmpty
              ? FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  setState(() {
                    _searchQuery = '';
                  });
                  final adminProvider = Provider.of<AdminProvider>(
                    context,
                    listen: false,
                  );
                  adminProvider.clearSearch();
                },
                child: const Icon(Icons.clear, color: Colors.white),
              )
              : null,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                iconSize: 40,
                onPressed:
                    _speechEnabled
                        ? (_speechToText.isListening
                            ? _stopListening
                            : _startListening)
                        : null,
                icon: Icon(
                  _speechToText.isListening
                      ? Icons.mic
                      : Icons.mic_none_rounded,
                  color:
                      _speechEnabled
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : Colors.grey,
                ),
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Search results for "$_searchQuery"',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Expanded(
            child: Consumer<AdminProvider>(
              builder: (context, adminProvider, child) {
                final searchResults = adminProvider.searchResults;

                if (searchResults.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.mic, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Tap the microphone to search by voice',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final product = searchResults[index];
                    return ProductCard(product: product);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
