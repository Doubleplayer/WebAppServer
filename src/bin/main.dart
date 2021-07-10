import 'dart:convert';
import 'dart:io';
import './handler/handler.dart' as handler;

void main() async {
  {
    //创建服务器
    // var requestHttpsServer= await HttpServer.bindSecure(myHost, 9002, context)
    var requestServer = await HttpServer.bind('0.0.0.0', 9005);
    print('http服务启动起来');
    await for (HttpRequest req in requestServer) {
      try {
        handleRoute(req);
      } catch (e) {
        req.response
          ..write(jsonEncode({'msg': '系统开小差了'}))
          ..close();
        print(e);
      }
    }
  }
}

void handleRoute(HttpRequest req) async {
  //跨域配置
  var path = req.requestedUri.path;
  req.response.headers.add('Access-Control-Allow-Origin', '*');
  req.response.headers.add('Access-Control-Allow-Credentials', 'true');
  req.response.headers.add('Access-Control-Allow-Methods', '*');
  req.response.headers
      .add('Access-Control-Allow-Headers', 'Content-Type,Access-Token');
  req.response.headers.add('Access-Control-Expose-Headers', '*');

  try {
    if (req.method == 'OPTIONS') {
      req.response
        ..statusCode = 200
        ..write('')
        ..close();
      return;
    }
    if (path == '/') {
      handler.ServerWebApp(req);
    } else if (path.contains('static')) {
      handler.HandleStatic(req);
    } else if (path == '/favicon.ico') {
      handler.ServerWebApp(req);
    } else {
      handler.HandleNotFound(req);
    }
  } catch (e) {
    return;
  }
}
