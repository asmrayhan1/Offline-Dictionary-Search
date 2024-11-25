import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class DicitionaryUsingTrie extends StatefulWidget {
  const DicitionaryUsingTrie({super.key});

  @override
  State<DicitionaryUsingTrie> createState() => _DictionarySearchState();
}

class _DictionarySearchState extends State<DicitionaryUsingTrie> {
  List<String>? searchedWords; // Initially, searchedWords is null
  TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  // Clear the search and reset to null
  void _clearSearch() {
    setState(() {
      searchedWords = null; // Reset searchedWords to null
      _controller.clear();
      _isSearching = false; // Reset search state
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color(0xffbf0a3a),
            width: MediaQuery.of(context).size.width,
            height: 177,
            child: Column(
              children: [
                SizedBox(height: 55),
                Text("Dictionary App", style: TextStyle(fontSize: 27, color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: _controller,
                    onChanged: (text) {
                      setState(() {
                        _isSearching = text.isNotEmpty;
                        if (text.isEmpty) {
                          searchedWords = null; // When search text is empty, set searchedWords to null
                        } else {
                          // Use Trie to search for words that start with the current prefix
                          searchedWords = trie.searchWithPrefix(text);
                        }
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: _isSearching ? IconButton(icon: Icon(Icons.clear), onPressed: _clearSearch) : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: searchedWords == null || searchedWords!.isEmpty ? Center(child: Text('No results found', style: TextStyle(fontSize: 18))) // Show "No results" when no search or no matches
                : ListView.builder(
              itemCount: searchedWords!.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      color: Colors.yellowAccent,
                      child: Center(child: Text(searchedWords![index], style: TextStyle(fontSize: 16),)),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}