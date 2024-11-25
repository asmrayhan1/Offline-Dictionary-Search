class TrieNode {
  Map<String, TrieNode> children = {};
  bool isEndOfWord = false;

  TrieNode();
}

class Trie {
  TrieNode root = TrieNode();

  // Insert a word into the Trie
  void insert(String word) {
    TrieNode node = root;
    for (int i = 0; i < word.length; i++) {
      String ch = word[i];
      if (!node.children.containsKey(ch)) {
        node.children[ch] = TrieNode();
      }
      node = node.children[ch]!;
    }
    node.isEndOfWord = true;
  }

  // Search for words that start with the given prefix
  List<String> searchWithPrefix(String prefix) {
    TrieNode node = root;
    List<String> wordsWithPrefix = [];

    // Traverse through the Trie to find the node corresponding to the prefix
    for (int i = 0; i < prefix.length; i++) {
      String ch = prefix[i];
      if (!node.children.containsKey(ch)) {
        return wordsWithPrefix; // No words with this prefix
      }
      node = node.children[ch]!;
    }

    // Perform DFS to collect all words starting with the prefix
    _collectWords(node, prefix, wordsWithPrefix);
    return wordsWithPrefix;
  }

  // Helper function to collect words from the Trie starting at the given node
  void _collectWords(TrieNode node, String prefix, List<String> words) {
    if (node.isEndOfWord) {
      words.add(prefix);
    }

    node.children.forEach((key, childNode) {
      _collectWords(childNode, prefix + key, words);
    });
  }
}
