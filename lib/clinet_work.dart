/*
import 'dart:io';
import 'package:dice_app/video_upload.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ExpandableFabMenu extends StatefulWidget {
  @override
  _ExpandableFabMenuState createState() => _ExpandableFabMenuState();
}

class _ExpandableFabMenuState extends State<ExpandableFabMenu> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isExpanded = false;
  Offset _fabPosition = Offset(300, 500); // Initial position for drag
  File? _selfieThumbnail;
  File? _videoThumbnail;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _animationController.forward() : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content goes here...

          // Drag & Drop FAB with menu
          Positioned(
            left: _fabPosition.dx,
            top: _fabPosition.dy,
            child: Draggable(
              feedback: _buildFab(),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  _fabPosition = details.offset;
                });
              },
              child: _buildFab(),
            ),
          ),

          // Expanded action buttons
          if (_isExpanded)
            Positioned(
              left: _fabPosition.dx - 150, // Adjust position for buttons
              top: _fabPosition.dy - 50, // Adjust position for proper display
              child: Container(
                width: 250, // Limit the width of the buttons container
                child: Wrap(
                  direction: Axis.horizontal, // Wrap horizontally first
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  runSpacing: 10,
                  children: _buildActionButtons(), // Moved the list to a separate method
                ),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // FAB with 'add' icon
  Widget _buildFab() {
    return FloatingActionButton(
      backgroundColor: _isExpanded ? Colors.red : Colors.blue,
      onPressed: _toggleMenu,
      child: Icon(Icons.add), // Changed to "add" icon
    );
  }

  // Build all 10 action buttons
  List<Widget> _buildActionButtons() {
    return [
      ActionButton(
        icon: Icons.camera_alt,
        onPressed: _takeSelfie,
        label: 'Selfie',
        thumbnail: _selfieThumbnail,
      ),
      ActionButton(
        icon: Icons.videocam,
        onPressed: _takeVideo,
        label: 'Video',
        thumbnail: _videoThumbnail,
      ),
      ActionButton(
        icon: Icons.location_on,
        onPressed: _getLocation,
        label: 'Location',
      ),
      ActionButton(
        icon: Icons.document_scanner_outlined,
        onPressed: _takeSelfie,
        label: 'Prep',
        thumbnail: _selfieThumbnail,
      ),
      ActionButton(
        icon: Icons.more_horiz,
        onPressed: _takeVideo,
        label: 'More..',
        thumbnail: _videoThumbnail,
      ),
      ActionButton(
        icon: Icons.chat,
        onPressed: _getLocation,
        label: 'Chat',
      ),
      ActionButton(
        icon: Icons.location_pin,
        onPressed: _takeSelfie,
        label: 'Location',
        thumbnail: _selfieThumbnail,
      ),
      ActionButton(
        icon: Icons.help,
        onPressed: _takeVideo,
        label: 'Help',
        thumbnail: _videoThumbnail,
      ),
      ActionButton(
        icon: Icons.restart_alt,
        onPressed: _getLocation,
        label: 'Begin',
      ),
      ActionButton(
        icon: Icons.more,
        onPressed: () {
          print("More actions");
        },
        label: 'More',
      ),
    ];
  }

  // Implement selfie functionality
  void _takeSelfie() {
    print("Taking selfie...");
  }

  // Implement video functionality
  void _takeVideo() async {
    // You can add any logic here if you need to handle video selection or recording
    print('Navigating to UploaderDemo...');

    // Navigate to UploaderDemo page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UploaderDemo()),
    );
  }


  // Get current location using Geolocator
  void _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("Location: ${position.latitude}, ${position.longitude}");
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String label;
  final File? thumbnail;


  ActionButton({required this.icon, required this.onPressed, required this.label, this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          onPressed: onPressed,
          heroTag: label, // To avoid tag conflict with multiple FABs
          child: (thumbnail != null)
              ? CircleAvatar(backgroundImage: FileImage(thumbnail!))
              : Icon(icon),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
*/
