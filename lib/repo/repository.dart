import 'dart:convert';
import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:pixels/model/model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final String apikey =
      'eAe8sWTr9buEYiEgDqMpdv4j91r5ouTSAETArhvovCsc1oz0z5LtKgrg';
  final String baseUrl = 'https://api.pexels.com/v1/';

  Future<List<Images>> getImagesList({required int? pageNumber}) async {
    String url = '';
    if (pageNumber == null) {
      url = '${baseUrl}curated?per_page=80';
    } else {
      url = '${baseUrl}curated?per_page=80&page=$pageNumber';
    }

    // ignore: non_constant_identifier_names
    List<Images> ImageList = [];

    try {
      final response =
          await http.get(Uri.parse(url), headers: {'Authorization': apikey});

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final jsonData = json.decode(response.body);

        for (final json in jsonData['photos'] as Iterable) {
          final image = Images.fromJson(json);
          ImageList.add(image);
        }
      }
    } catch (_) {}
    return ImageList;
  }

  Future<Images> getImageById({required int id}) async {
    final url = '${baseUrl}photos/$id';
    Images image = Images.emptyConstructor();
    try {
      final response =
          await http.get(Uri.parse(url), headers: {'Authorization': apikey});
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final jsonData = json.decode(response.body);
        image = Images.fromJson(jsonData);
      }
    } catch (_) {}
    return image;
  }

  Future<List<Images>> getImageBySearch({required String query}) async {
    final url = '${baseUrl}search?query=$query&per_page=80';
    // ignore: non_constant_identifier_names
    List<Images> ImageList = [];

    try {
      final response =
          await http.get(Uri.parse(url), headers: {'Authorization': apikey});

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final jsonData = json.decode(response.body);

        for (final json in jsonData['photos'] as Iterable) {
          final image = Images.fromJson(json);
          ImageList.add(image);
        }
      }
    } catch (_) {}
    return ImageList;
  }

  Future<void> downloadImage(
      {required String imageUrl,
      required int imageId,
      required BuildContext context}) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final bytes = response.bodyBytes;
        final directory = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS);
        final file = File("$directory/$imageId.png");
        await file.writeAsBytes(bytes);

        MediaScanner.loadMedia(path: file.path);
        if (context.mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
              content: Text("File saved at : ${file.path}")));
        }
      }
    } catch (_) {}
  }
}
