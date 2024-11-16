import 'package:favourite_place/screens/map_screen.dart';
import 'package:flutter/material.dart';

import '../model/place.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final Place place;
  const PlaceDetailsScreen({super.key, required this.place});

  String get locationImage {
    final lat = place. location.latitude;
    final lng = place.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$lng&key=YOUR_API_KEY';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
        ),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  MapScreen(location: place.location,isSelecting: false,)));
                    },
                    child: CircleAvatar(

                      radius: 70,
                      backgroundImage: NetworkImage(locationImage),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.transparent,
                            Colors.black54
                          ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                          )
                        ),

                        child: Text(
                          place.location.address,
                          textAlign:  TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
