import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class DictionarySearch extends StatefulWidget {
  const DictionarySearch({super.key});

  @override
  State<DictionarySearch> createState() => _DictionarySearchState();
}

class _DictionarySearchState extends State<DictionarySearch> {

  late List searchedWord;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchedWord = words;
    // print(searchedWord[0]);
  }

  TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  void _clearSearch() {
    setState(() {
      searchedWord = words;
      _controller.clear();
      _isSearching = false; // Reset search state when the text is cleared
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
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 55),
                Text("Dictonary App", style: TextStyle(fontSize: 27, color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextField(
                    controller: _controller,
                    onChanged: (text) {
                      setState(() {
                        _isSearching = text.isNotEmpty; // Show cancel icon when there's text

                        searchedWord = words.where((tmp)=>tmp.startsWith(text)).toList();
                      });
                    },
                    decoration: InputDecoration(
                      // Background Color
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search...', // Hint text inside the search bar
                      prefixIcon: Icon(Icons.search), // Search icon
                      suffixIcon: _isSearching ? IconButton(icon: Icon(Icons.clear), onPressed: _clearSearch) : null, // Only show cancel icon if there's text
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
          //SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: searchedWord.length,
              itemBuilder: (BuildContext context, int index) {

                return Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text("${searchedWord[index]}",style: TextStyle(fontSize: 16),),
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}