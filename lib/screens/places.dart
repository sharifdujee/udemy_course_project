import 'package:favourite_place/provider/user_places.dart';
import 'package:favourite_place/screens/add_place.dart';
import 'package:favourite_place/widget/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();

  }
  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPlaceScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _placesFuture, // Add your future here if needed
          builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : PlacesList(places: userPlaces),
        ),
      ),
    );
  }
}
