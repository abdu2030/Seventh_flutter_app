import 'package:favorite_places/model/place.dart';
import 'package:flutter/material.dart';

class NewPlace extends StatefulWidget {
  const NewPlace({super.key});

  @override
  State<NewPlace> createState() => _NewPlacesState();
}

class _NewPlacesState extends State<NewPlace> {
  var _enterdPlace = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new place')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 40,
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) {
                  _enterdPlace = value!;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.save();
                      Navigator.of(
                        context,
                      ).pop(Places( name: _enterdPlace));
                    },
                    child: Center(child: Text('Add Place')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
