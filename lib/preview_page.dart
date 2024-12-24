import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixels/repo/repository.dart';

class PreviewPage extends StatefulWidget {
  final String imageUrl;
  final int imageID;
  const PreviewPage({super.key, required this.imageUrl, required this.imageID});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  Repository repository = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: CachedNetworkImage(
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        imageUrl: widget.imageUrl,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          repository.downloadImage(
              imageUrl: widget.imageUrl,
              imageId: widget.imageID,
              context: context);
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}
