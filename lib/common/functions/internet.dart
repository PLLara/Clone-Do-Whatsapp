import 'dart:typed_data';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:palestine_console/palestine_console.dart';

class Internet {
  static final box = GetStorage();

  static getCachedImageBytes(String url) async {
    try {
      var rawCache = box.read(url).cast<int>();
      var cache = Uint8List.fromList(rawCache);
      if (rawCache == null) {
        var response = await http.get(Uri.parse(url));
        box.write(url, response.bodyBytes);
        return response.bodyBytes;
      } else {
        Print.green('Cached image found');
        return cache;
      }
    } catch (e) {
      Print.red("Error $e");
      var response = await http.get(Uri.parse(url));
      box.write(url, response.bodyBytes);
      return response.bodyBytes;
    }
  }
}
