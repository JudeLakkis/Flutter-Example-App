// Import Area
import 'package:flutter/material.dart'; // Calls the material design widgets
import './random_words.dart';

// Dart is an object oriented/class based language
void main() => runApp(MyApp());

// Stateless Widgets can't be altered during run time
// MyApp overrides StatelessWidget in this case
class MyApp extends StatelessWidget {
  // States the override but isn't required
  @override
  // Scaffold is a higher level widget, working as a container
  // Widget tree, creating hierarchy
  Widget build(BuildContext context) {
    return MaterialApp(
        // "theme" parameter takes ThemeData parameter
        theme: ThemeData(primaryColor: Colors.purple),
        // Calls class from random_words.dart file
        home: RandomWords());
  }
}
