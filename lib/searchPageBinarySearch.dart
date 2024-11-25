import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // List of items to search from
  List<String> items = [
    'Apple',
    'Banana',
    'Grapes',
    'Mango',
    'Orange',
    'Pineapple',
    'Strawberry',
    'Watermelon',
  ];

  // List to hold the filtered results based on search query
  List<String> filteredItems = [];

  // Controller to manage the search input
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Sort items for binary search
    items.sort();
    filteredItems = items; // Initially, show all items
  }

  // Binary search function
  List<String> binarySearch(List<String> list, String query) {
    int left = 0;
    int right = list.length - 1;
    List<String> results = [];

    while (left <= right) {
      int mid = (left + right) ~/ 2;
      int comparison = list[mid].toLowerCase().compareTo(query.toLowerCase());

      if (comparison == 0) {
        // If the exact match is found, add it to the results
        results.add(list[mid]);
        break; // Stop searching once we find an exact match
      } else if (comparison < 0) {
        left = mid + 1; // Look in the right half
      } else {
        right = mid - 1; // Look in the left half
      }
    }

    if (results.isEmpty) {
      // If no exact match, return the items that contain the query as substring
      results = list.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
    }

    return results;
  }

  // Function to filter the list based on the search query
  void _filterSearchResults(String query) {
    List<String> results = [];
    if (query.isEmpty) {
      results = items; // If query is empty, show all items
    } else {
      // Use binary search to find matching items
      results = binarySearch(items, query);
    }

    setState(() {
      filteredItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Search Bar with Binary Search'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Search Bar
            TextField(
              controller: _controller,
              onChanged: _filterSearchResults,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search for fruits...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // ListView of filtered items
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredItems[index]),
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