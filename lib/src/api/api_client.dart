import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../model/forums.dart';
import '../model/post.dart';
import '../utils/helpers/user_helper.dart';
import 'api_routes.dart';

class ApiClient{

  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://172.23.6.211:8000",
    connectTimeout: const Duration(milliseconds: 20000),
    receiveTimeout: const Duration(milliseconds: 20000),
    receiveDataWhenStatusError: true,
      contentType: Headers.jsonContentType
  ));

  Future signIn(String username, String password) async {
    Map<String, dynamic> params = {
      "username": username,
      "password": password,
    };

    try{
      var response = await _requestPOST(
          needsAuth: false, path: routes["login"], formData: params, show: true);
      print("LOGIN RESPONSE: $response");
      if(response != null){
        String accessToken = response["token"];
        await UserHelper.saveTokenOnSharedPreferences(accessToken, response["user"]["username"]);
        //await UserHelper.setUser(response);
        return true;
      }else{
        return false;
      }
    }
    catch(e){
      print("Error at login: $e");
    }

  }

  Future<Map<String, dynamic>> getUsernameData(String username) async {
    var response = await _requestGET(path: "${routes["accounts"]}/$username/", show: true);
    return response;
  }

  /// Obtener los foros del usuario de la app
  Future<List<Forums>> getShopForums(int shopId) async {
    var response = await _requestGET(
        path: "${routes["shopForums"]}$shopId${routes["forums"]}", show: true);
    if (response is List) {
      return response.map((json) => Forums.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load forums');
    }
  }

  /// Obtener los post del foro seleccionado por el usuario
  Future<List<Post>> getForumPosts(int forumId) async {
    print("Get Froum Post");
    var response = await _requestGET(
        path: "${routes["forums"]}$forumId${routes["posts"]}", show: true);


    print("Response -> $response");
    if (response is List) {
      return response.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<String?> getShopImage(int shopId) async{
    try{
      var response = await _requestGET(path: "${routes["shops"]}$shopId${routes["image"]}");
      if(response != null){
        return response;
      }

    }catch(e){
      print("Error at get shop image $e");
    }
    return null;
  }

  Future<List<String>> getShopEmployees(int shopId) async {
    try{
      var response = await _requestGET(path: "${routes["shops"]}$shopId${routes["employees"]}");
      if(response != null){
        List<String> list = response.cast<String>();
        return list;
      }

    }catch(e){
      print("Error at get shop employees $e");
    }
    return [];
  }

  Future registerEmployer(String username, String password) async {
    Map<String, dynamic> params = {
      "username": username,
      "password": password,
    };

    try{
      var response = await _requestPOST(
          path: routes["registerEmployer"], formData: params, show: true);

      if(response != null){
        return true;
      }else{
        return false;
      }
    }catch(e){
      print(e);
      return null;
    }
  }

  Future deleteEmployer(String username, int shopId) async {
    Map<String, dynamic> params = {
      "worker": username,
    };

    try{
      var response = await _requestDELETE(
          path: "${routes["shops"]}$shopId${routes["employees"]}", formData: params);
      print("response delete");
      print(response);
      if(response != null){
        return true;
      }else{
        return false;
      }
    }catch(e){
      print(e);
      return null;
    }
  }

  /// Create POST
  Future<bool> createForumPost(int forumPk, String title, String description, List<String> mediaContents) async {
    Map<String, dynamic> params = {
      "title": title,
      "body": description,
      "medias": mediaContents,
    };

    try {
      var response = await _requestPOST(
          path: "${routes["forums"]}$forumPk${routes["posts"]}", formData: params, show: true);

      print("Response : $response");

      print("Params: ${params["medias"].runtimeType}");
      if (response != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// REQUESTS

  Future<dynamic> _requestGET(
      {bool needsAuth = true,
        String? path,
        Map<String, dynamic>? params,
        bool show = false,
        bool connectionError = true,
        bool extend = false}) async {
    try {
      if (extend) {
        _dio.options.receiveTimeout = Duration(seconds: 30);
      }
      // Realitzem la request
      Response response = await _dio.get(
        path ?? "",
        queryParameters: params,
        options: Options(
          headers: needsAuth
              ? {
            HttpHeaders.authorizationHeader:
            "Token ${UserHelper.accessToken}",
          }
              : null,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      // Comprovem status code de la response
      if (_checkResponseStatusCode(response.statusCode)) {
        // Comprovem si data no és null
        if (response.data != null) {
          return response.data;
        }

        return null;
      } else {
        // Si la request ha fallat, retornem [ApiException] en funció del valor
        // de  [response.statusCode].
        print(".: API STATUS CODE: ${response.statusCode}");
      }
    } on DioException catch (e) {
      _printDioError(e);
    } catch (e) {
      print(".:GET ERROR: $e");
    }
  }


  Future<dynamic> _requestPUT(
      {bool needsAuth = true,
        String? path,
        Map<String, dynamic>? params,
        bool show = false,
        bool extend = false}) async {
    try {
      if (extend) {
        _dio.options.receiveTimeout = Duration(seconds: 30);
      }
      // Realitzem la request
      Response response = await _dio.put(
        path ?? "",
        queryParameters: params,
        options: Options(
          headers: needsAuth
              ? {
            HttpHeaders.authorizationHeader:
            "Token ${UserHelper.accessToken}",
          }
              : null,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );
      // Comprovem status code de la response
      if (_checkResponseStatusCode(response.statusCode)) {
        // Comprovem si data no és null
        if (response.data != null) {
          return response.data;
        }

        return null;
      } else {
        // Si la request ha fallat, retornem [ApiException] en funció del valor
        // de  [response.statusCode].
        print(".: API STATUS CODE: ${response.statusCode}");
      }
    } on DioException catch (e) {
      _printDioError(e);
    } catch (e) {
      print(e);
    }
  }


  Future<dynamic> _requestPOST(
      {bool needsAuth = true,
        String? path,
        Map<String, dynamic>? formData,
        Map<String, dynamic>? getParams,
        bool connectionError = true,
        bool show = false}) async {
    try {
      // Realitzem la request
      Response response = await _dio.post(
        path ?? "",
        data: formData != null ? FormData.fromMap(formData) : null,
        queryParameters: getParams ?? null,
        options: Options(
          headers: needsAuth
              ? {
            HttpHeaders.authorizationHeader:
            "Token ${UserHelper.accessToken}",
          }
              : null,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );
      // Comprovem status code de la response
      if (_checkResponseStatusCode(response.statusCode)) {
        // Comprovem si data no és null
        if (response.data != null) {
          return response.data;
        }

        return null;
      } else {
        // Si la request ha fallat, retornem [ApiException] en funció del valor
        // de  [response.statusCode].
        print(".: API STATUS CODE: ${response.statusCode}");
      }
    } on DioException catch (e) {
      _printDioError(e);
    } on FormatException catch (e) {
      print("::.. on errorino");
    } catch (e) {
      print("::.. on errorinos : ${e}");
    }
  }

  /// Realitza una request PATCH a server.
  Future<dynamic> _requestPATCH({
    bool needsAuth = true,
    String? path,
    Map<String, dynamic>? formData,
    Map<String, dynamic>? getParams,
  }) async {
    try {
      // Realitzem la request
      Response response = await _dio.patch(
        path ?? "",
        data: formData != null ? FormData.fromMap(formData) : null,
        queryParameters: getParams ?? null,
        options: Options(
          headers: needsAuth
              ? {
            HttpHeaders.authorizationHeader:
            "Token ${UserHelper.accessToken}",
          }
              : null,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      // Comprovem status code de la response
      if (_checkResponseStatusCode(response.statusCode)) {
        // Comprovem si data no és null
        if (response.data != null) {
          return response.data;
        }

        return null;
      } else {
        // Si la request ha fallat, retornem [ApiException] en funció del valor
        // de  [response.statusCode].
        print(".: API STATUS CODE: ${response.statusCode}");
      }
    } on DioException catch (e) {
      _printDioError(e);
    } on FormatException catch (e) {
      print("::.. on errorino");
    } catch (e) {
      print("::.. on errorinos : ${e}");
    }
  }

  /// Realitza una request DELETE a server.
  Future<dynamic> _requestDELETE({
    bool needsAuth = true,
    String? path,
    Map<String, dynamic>? formData,
    Map<String, dynamic>? getParams,
  }) async {
    try {
      // Realitzem la request
      Response response = await _dio.delete(
        path ?? "",
        data: formData != null ? FormData.fromMap(formData) : null,
        queryParameters: getParams ?? null,
        options: Options(
          headers: needsAuth
              ? {
            HttpHeaders.authorizationHeader:
            "Token ${UserHelper.accessToken}",
          }
              : null,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      // Comprovem status code de la response
      if (_checkResponseStatusCode(response.statusCode)) {
        // Comprovem si data no és null
        if (response.data != null) {
          return response.data;
        }

        return null;
      } else {
        // Si la request ha fallat, retornem [ApiException] en funció del valor
        // de  [response.statusCode].
        print(".: API STATUS CODE: ${response.statusCode}");
      }
    } on DioException catch (e) {
      _printDioError(e);
    } on FormatException catch (e) {
      print("::.. on errorino");
    } catch (e) {
      print("::.. on errorinos : ${e}");
    }
  }


  void _printDioError(DioException e) {

    // Comprovem si la request té paràmetres, per fer print
    if (e.requestOptions.data != null) {
      //print(":.Params: ${e.requestOptions?.data}");
      print(
          ":.Params: ${jsonEncode(Map.fromIterable(e.requestOptions.data?.fields, key: (e) => e.key, value: (e) => e.value))}");
    }
    print(jsonEncode(e.response?.data));
  }

  void _printResponseDetails(Response r) {
    print(":.URL: ${r.realUri}");
    if (r.requestOptions.data != null) {
      //print(":.Params: ${r.requestOptions?.data}");
      print(
          ":.Params: ${jsonEncode(Map.fromIterable(r.requestOptions.data?.fields, key: (e) => e.key, value: (e) => e.value))}");
    }

    print(jsonEncode(r.data));
  }

  bool _checkResponseStatusCode(int? statusCode) {
    if (statusCode != null) {
      if (statusCode >= 200 && statusCode <= 299) {
        return true;
      }
    }
    return false;
  }


}