import 'package:favorite_places/model/place.dart';
import 'package:favorite_places/widget/new_place.dart';
import 'package:flutter/material.dart';

class FavoritePlaces extends StatefulWidget {
  const FavoritePlaces({super.key});

  @override
  State<FavoritePlaces> createState() => _FavoritePlacesState();
}

class _FavoritePlacesState extends State<FavoritePlaces> {
  final List<Places> _places = [];
  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  void _loadItem() {
    setState(() {
      _places.add(Places( name: 'Eiffel Tower'));
      _places.add(Places( name: 'Colosseum'));
    });
  }

  void _addItem() async {
    final newPlace = await Navigator.of(
      context,
    ).push<Places>(MaterialPageRoute(builder: (ctx) => NewPlace()));

    if (newPlace == null) {
      return;
    }
    setState(() {
      _places.add(newPlace);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No places added yet.'));

    if (_places.isNotEmpty) {
      content = ListView.builder(
        itemCount: _places.length,
        itemBuilder: (ctx, index) => ListTile(title: Text(_places[index].name)),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
            onPressed: () {
              _addItem();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
