import 'package:favourite_place/model/place.dart';
import 'package:favourite_place/provider/user_places.dart';
import 'package:favourite_place/widget/image_input.dart';
import 'package:favourite_place/widget/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImages;
  PlaceLocation? _selectedLocation;

  void _savePlaces(){
    final enteredTitle = _titleController.text;

    if( enteredTitle.isEmpty || _selectedImages == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('Enter a place name')));
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlaces(enteredTitle, _selectedImages!, _selectedLocation!);
    //print('the name of the place is $enteredTitle');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text('Place added successfully')));
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Places'),
      ),
      body: SingleChildScrollView(
        padding:const  EdgeInsets.all(12),
        child: Column(

          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                  labelText: 'Title', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            /// image input
             ImageInput(onPickImage: (image){
               _selectedImages = image;
             },),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 16,
            ),
             LocationInput(onSelectLocation: (location){
               _selectedLocation = location;

            },),

            ElevatedButton.icon(onPressed: (){
              _savePlaces();
            } , label: const Text('Add Places'), icon: const Icon(Icons.add),)
          ],
        ),
      ),
    );
  }
}
