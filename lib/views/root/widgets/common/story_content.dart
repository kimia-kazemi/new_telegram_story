import 'package:flutter/material.dart';

class ImageFrame extends StatelessWidget {
  const ImageFrame({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Colors.grey[300]!, Colors.grey],
          ),
        ),
        child: Center(
          child: Image.network(
            url,
            fit: BoxFit.contain,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              // Show loading spinner if loadingProgress is not null
              if (loadingProgress == null) {
                return child; // return the image itself when loading is complete
              } else {
                // show a progress indicator while the image is loading
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 50),
                  SizedBox(height: 10),
                  Text('Failed to load the image', style: TextStyle(color: Colors.red)),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger rebuild to retry the image loading
                      (context as Element).markNeedsBuild();
                    },
                    child: Text('Retry'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
