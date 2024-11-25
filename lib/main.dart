import 'dart:convert';

import 'package:dictionar_search_app/dictionarySearch.dart';
import 'package:dictionar_search_app/searchPageBinarySearch.dart';
import 'package:dictionar_search_app/testMode/dictionaryUsingTrie.dart';
import 'package:dictionar_search_app/trie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<String> words = [];
Trie trie = Trie();


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  String jsonString = await rootBundle.loadString("assets/words_dictionary.json");
  Map result = jsonDecode(jsonString);

  words.addAll(result.keys.toList() as List<String>);

  // Insert all words into the Trie
  for (var word in words) {
    trie.insert(word);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DicitionaryUsingTrie(),
    );
  }
}