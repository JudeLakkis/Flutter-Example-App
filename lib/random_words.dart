import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// Once again just overriding the StatefulWidget this time
class RandomWords extends StatefulWidget {
  @override
  // And the create the state here
  RandomWordsState createState() => RandomWordsState();
}

// This is the created state that extends the previous class
class RandomWordsState extends State<RandomWords> {
  // Self defined private variables
  /* "final" is used for single-assignment
     Once assigned a value, a final variable's value cannot be changed. However,
     it is decided upon once created during runtime
     "const" however is decided upon at compile time, and the object is frozen
  */
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  Widget _buildList() {
    /* "builder" is used to define pattern building
       and uses defined logic to create repeatable objects/widgets
    */
    return ListView.builder(
      // Padding Widget
      padding: const EdgeInsets.all(16.0),
      // itemBuilder is used to create dynamic content
      itemBuilder: (context, item) {
        if (item.isOdd) return Divider();
        // Ensures the divders aren't counted by the index
        // ~/ is equivalent to double slashy (full divide) in python
        final index = item ~/ 2;
        // Generates an extra 10 items to enable scrolling
        if (index >= _randomWordPairs.length) {
          // Specifically takes 10 new generated word pairs from the set,
          // and adds them to the stack
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_randomWordPairs[index]);
      },
    );
  }

  // Builds the row for each word pair
  Widget _buildRow(WordPair pair) {
    // Checks to see if the pair has been saved from above
    // Stores a boolean value for the tile that can be accessed from the set
    final alreadySaved = _savedWordPairs.contains(pair);
    return ListTile(
      // Writes the word from the wordpair
      title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0)),
      /* Creates the heart, with turnery to check if the heart icon and colour
         depending on the boolean value in the set */
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null),
      onTap: () {
        /* Upon tapping the tile, the state is changed
           adding/removing the tile from the set */
        setState(() {
          if (alreadySaved) {
            _savedWordPairs.remove(pair);
          } else {
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  // Navigator Function
  void _pushSaved() {
    // Pushes a list of saved word pairs onto the stack, built with builder func
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      // Passes the word pair to the savedwordpairs map
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
          title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0)),
        );
      });
      final List<Widget> divided =
          // Layers the wordpair tiles
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      // Regular Scaffold, just like before
      return Scaffold(
          appBar: AppBar(title: Text('Saved WordPairs')),
          body: ListView(children: divided));
    }));
  }

  Widget build(BuildContext context) {
    /* The scaffold needs to be returned here now as we removed the visuals
    and need to pass them through the new class*/
    return Scaffold(
        appBar: AppBar(
          title: Text('Wordpair Generator'),
          // Creates list button, which calls _pushSaved on press
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: _buildList());
  }
}
