/*
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_uploader/video_uploader.dart';

const primaryColor = Color(0xFFFA5B30);
const secondaryColor = Color(0xFFFFB39E);

class UploaderDemo extends StatelessWidget {
  const UploaderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Uploader Example'),
        ),
        body: const UploaderPage(),
      ),
    );
  }
}

class UploaderPage extends StatefulWidget {
  const UploaderPage({Key? key}) : super(key: key);

  @override
  UploaderPageState createState() => UploaderPageState();
}

class UploaderPageState extends State<UploaderPage> {
  final _tokenTextController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  double _progressValue = 0;
  bool _hasUploadStarted = false;
  VideoPlayerController? _videoPlayerController; // Video player controller
  String? _uploadedVideoPath; // To store uploaded video path

  void setProgress(double value) {
    setState(() {
      _progressValue = value;
    });
  }

  @override
  void dispose() {
    _tokenTextController.dispose();
    _videoPlayerController?.dispose(); // Dispose the video controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 52),
            TextField(
              cursorColor: primaryColor,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2.0),
                ),
                hintText: 'Your upload token',
              ),
              controller: _tokenTextController,
            ),
            MaterialButton(
              color: primaryColor,
              child: const Text(
                "Pick Video",
                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                var source = ImageSource.gallery;
                XFile? videoFile = await _picker.pickVideo(source: source);
                if (videoFile != null) {
                  setState(() {
                    _hasUploadStarted = true;
                    _uploadedVideoPath = videoFile.path; // Store the path of the uploaded video
                    _videoPlayerController = VideoPlayerController.file(File(videoFile.path))
                      ..initialize().then((_) {
                        setState(() {}); // Refresh to show video player
                      });
                  });
                  try {
                    var video = await ApiVideoUploader.uploadWithUploadToken(
                      _tokenTextController.text,
                      videoFile.path,
                      onProgress: (progress) {
                        log("Progress :$progress");
                        setProgress(progress);
                      },
                    );
                    log("VideoId : ${video.videoId}");
                    log("Title : ${video.title}");
                    showSuccessSnackBar(context, "Video ${video.videoId} uploaded");
                  } on Exception catch (e) {
                    log("Failed to upload video: $e");
                    showErrorSnackBar(context, "Failed to upload video: ${e.message}");
                  } catch (e) {
                    log("Failed to upload video: $e");
                    showErrorSnackBar(context, "Failed to upload video $e");
                  }
                }
              },
            ),
            if (_hasUploadStarted)
              LinearProgressIndicator(
                color: primaryColor,
                backgroundColor: secondaryColor,
                value: _progressValue,
              ),
            if (_hasUploadStarted)
              MaterialButton(
                color: primaryColor,
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  try {
                    await ApiVideoUploader.cancelAll();
                  } catch (e) {
                    log("Failed to cancel video: $e");
                  }
                },
              ),
            // Display the uploaded video
            if (_uploadedVideoPath != null && _videoPlayerController != null && _videoPlayerController!.value.isInitialized)
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: VideoPlayer(_videoPlayerController!), // Video player widget
                  ),
                  VideoProgressIndicator(
                    _videoPlayerController!,
                    allowScrubbing: true,
                    */
/*colors: VideoProgressIndicatorColors(
                      playedColor: primaryColor,
                      bufferedColor: secondaryColor,
                      backgroundColor: Colors.black54,
                    ),*//*

                  ),
                  IconButton(
                    icon: Icon(
                      _videoPlayerController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    onPressed: () {
                      setState(() {
                        _videoPlayerController!.value.isPlaying
                            ? _videoPlayerController!.pause()
                            : _videoPlayerController!.play();
                      });
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    showSnackBar(context, message, backgroundColor: Colors.green);
  }

  void showErrorSnackBar(BuildContext context, String message) {
    showSnackBar(context, message,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 60),
        showCloseIcon: true);
  }

  void showSnackBar(BuildContext context, String message,
      {Color? backgroundColor,
        Duration duration = const Duration(seconds: 4),
        bool showCloseIcon = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
        showCloseIcon: showCloseIcon,
      ),
    );
  }
}

extension ErrorExtension on Exception {
  String get message {
    if (this is PlatformException) {
      return (this as PlatformException).message ?? "Unknown error";
    }
    return toString();
  }
}
*/
