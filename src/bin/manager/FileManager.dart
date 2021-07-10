import 'dart:io';
import 'package:http_server/http_server.dart' as http_server;
import 'package:path/path.dart';

String myPath = dirname(Platform.script.toFilePath());

class FileManager {
  static void sendHtml(HttpRequest request) {
    http_server.VirtualDirectory staticFiles =
        new http_server.VirtualDirectory('.');
    staticFiles.serveFile(
        new File(myPath + r'/../webApp/index.html'), request); //win系统使用该代码
  }

  static void sendFile(HttpRequest request, String pathFromSrc) async {
    http_server.VirtualDirectory staticFiles =
        new http_server.VirtualDirectory('.');
    String filepath = myPath + r'/..' + pathFromSrc;
    staticFiles.serveFile(new File(filepath), request); //win系统使用该代码
  }
}
