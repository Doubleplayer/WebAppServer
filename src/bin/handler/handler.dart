import 'dart:convert';
import 'dart:io';
import '../manager/FileManager.dart';

void safeResponse(var msg, HttpRequest req) {
  try {
    req.response
      ..write(jsonEncode(msg))
      ..close();
  } catch (e) {
    return;
  }
}

void HandleStatic(HttpRequest req) {
  var path = req.uri.path;
  var pathGroup = path.split('/');
  var filterpath =
      '/' + pathGroup.sublist(pathGroup.lastIndexOf('static')).join('/');
  FileManager.sendFile(req, '/webApp/build' + filterpath);
}

void ServerWebApp(HttpRequest req) {
  FileManager.sendFile(req, '/webApp/build/index.html');
}

void HandleNotFound(HttpRequest req) {
  safeResponse({'msg': '找不到页面～～～'}, req);
}
