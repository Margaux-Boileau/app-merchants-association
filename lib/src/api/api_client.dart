import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../model/forums.dart';
import '../model/post.dart';
import '../utils/helpers/user_helper.dart';
import 'api_routes.dart';

class ApiClient{

  /// Instancia de [Dio] que se utilizará para realizar las peticiones a la API.
  /// Se configura con un [BaseOptions] que contiene la URL base de la API y
  /// los tiempos de espera de conexión y recepción de datos.
  /// Se configura también para recibir datos cuando el estado de la respuesta es un error.
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://172.23.6.211:8000",
    connectTimeout: const Duration(milliseconds: 20000),
    receiveTimeout: const Duration(milliseconds: 20000),
    receiveDataWhenStatusError: true,
  ));


  /// [signIn] se encarga de realizar el login de un usuario.
  /// Devuelve un booleano que indica si el login ha sido correcto o no.
  /// [username] es el nombre de usuario
  /// [password] es la contraseña
  Future signIn(String username, String password) async {
    Map<String, dynamic> params = {
      "username": username,
      "password": password,
    };

    try{
      var response = await _requestPOST(
          needsAuth: false, path: routes["login"], formData: params, show: true);
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

  /// [getUsernameData] se encarga de obtener los datos de un usuario.
  /// Devuelve un objeto [Map<String, dynamic>] con los datos del usuario
  /// [username] es el nombre de usuario
  Future<Map<String, dynamic>> getUsernameData(String username) async {
    var response = await _requestGET(path: "${routes["accounts"]}/$username/", show: true);
    return response;
  }

  /// [getShopData] se encarga de obtener los datos de una tienda.
  /// Devuelve un objeto [Map<String, dynamic>] con los datos de la tienda
  /// [shopId] es el id de la tienda
  /// [show] es un booleano que indica si se quiere mostrar el resultado por consola
  /// [connectionError] es un booleano que indica si se quiere mostrar el error de conexión
  Future<Map<String, dynamic>> getShopData(int shopId) async {
    var response = await _requestGET(path: "${routes["shops"]}/$shopId/", show: true);
    return response;
  }

  /// [getShopForums] se encarga de obtener los foros de una tienda.
  /// Devuelve una lista de objetos [Forums]
  /// [shopId] es el id de la tienda
  Future<List<Forums>> getShopForums(int shopId) async {
    var response = await _requestGET(
        path: "${routes["shopForums"]}$shopId${routes["forums"]}", show: true);

    if (response is List) {
      return response.map((json) => Forums.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load forums');
    }
  }

  /// La función esta encargada de obtener los post de un foro.
  /// Devuelve una lista de objetos [Post]
  /// [forumId] es el id del foro
  /// [page] es la página de la que se quieren obtener los post
  Future<List<Post>> getForumPosts(int forumId, int page) async {
    print("Get Forum Post");
    var response = await _requestGET(
        path: "${routes["forums"]}$forumId${routes["posts"]}${routes["format_page"]}$page", show: true);

    print("Response -> $response");
    if (response is Map) {
      var results = response['results'];
      if (results is List) {
        return results.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } else {
      throw Exception('Unexpected response format');
    }
  }

  /// Esta función se encargara de obtener los foros de la aplicación
  /// y devolverlos en una lista de objetos [Forums]
  /// [page] es la página de la que se quieren obtener los foros
  Future<Post> getPostDetail(int forumId, int postId) async {
    var response = await _requestGET(
        path: "${routes["forums"]}/$forumId${routes["posts"]}$postId/", show: true);

    if (response != null) {
      return Post.fromJson(response);
    } else {
      throw Exception('Failed to load post detail');
    }
  }

  /// [getShopImage] se encarga de obtener la imagen de una tienda.
  /// Devuelve un String con la url de la imagen de la tienda
  /// [shopId] es el id de la tienda
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

  Future<dynamic>? editShop(
      {required String? name, required String? address, required String? bio,required String? schedule, required String? phone, required String? instagram, required String? facebook, required String? webpage, required String? mail, required int? shopId}) async {
    Map<String, dynamic> params = {
      "name": name,
      "bio": bio,
      "address": address,
      "schedule": schedule,
      "phone": phone,
      "instagram": instagram,
      "facebook": facebook,
      "webpage": webpage,
      "mail": mail
    };

    try{
      var response = await _requestPUT(
        params: params, path: "${routes["shops"]}$shopId/",
      );

      return response;

    }catch(e){
      print(".:Error at edit shop: $e");
    }
    return null;

  }

  /// [getShopEmployees] se encarga de obtener los empleados de una tienda.
  /// Devuelve una lista de String con los nombres de los empleados
  /// [shopId] es el id de la tienda
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

  /// [registerEmployer] se encarga de registrar un empleador.
  /// Devuelve un booleano que indica si el registro ha sido correcto o no.
  /// [username] es el nombre de usuario
  /// [password] es la contraseña
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

  /// [deleteEmployer] se encarga de eliminar un empleador.
  /// Devuelve un booleano que indica si la eliminación ha sido correcta o no.
  /// [username] es el nombre de usuario
  /// [shopId] es el id de la tienda
  Future deleteEmployer(String username, int shopId) async {
    Map<String, dynamic> params = {
      "worker": username,
    };

    try{
      var response = await _requestDELETE(
          path: "${routes["shops"]}$shopId${routes["employees"]}", formData: params);
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

  /// [publishComment] se encarga de publicar un comentario en un post.
  /// Devuelve un booleano que indica si la publicación ha sido correcta o no.
  /// [forumId] es el id del foro
  /// [postId] es el id del post
  /// [content] es el contenido del comentario
  Future publishComment({required int forumId, required int postId, required String content}) async {
    try{
      Map<String, dynamic> params = {
        "content": content,
      };

      var response = await _requestPOST(
          path: "${routes["forums"]}/$forumId${routes["posts"]}$postId/${routes["comments"]}", show: true, formData: params);
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

  /// [getComments] se encarga de obtener los comentarios de un post.
  /// Devuelve una lista de comentarios en formato dinámico.
  /// [forumId] es el id del foro
  /// [postId] es el id del post
  /// [page] es la página de la que se quieren obtener los comentarios
  Future<List<dynamic>?> getComments({required int forumId, required int postId, required int page}) async {
    try{
      var response = await _requestGET(
          path: "${routes["forums"]}/$forumId${routes["posts"]}$postId/${routes["comments"]}?page=$page", show: true);
      if(response != null && response is Map){
        var results = response['results'];
        if (results is List) {
          return results;
        }
      }
    }catch(e){
      print(e);
    }
    return null;
  }


  /// [createForumPost] se encarga de crear un post en un foro.
  /// Devuelve un booleano que indica si la creación ha sido correcta o no.
  /// [forumPk] es el id del foro
  /// [title] es el título del post
  /// [description] es la descripción del post
  /// [mediaContents] es una lista de strings con las imágenes en formato base64
  Future<bool> createForumPost(int forumPk, String title, String description, List<String> mediaContents) async {

    Map<String, dynamic> params = {
      "title": title,
      "body": description,
      "medias": mediaContents
    };

    try {
      var response = await _requestPOST(
          path: "${routes["forums"]}$forumPk${routes["posts"]}", formData: params,show: true);

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

  Future sendDeviceToken(Map<String, dynamic> deviceInfo) async {

    try {
      var response = await _requestPOST(
          path: "${routes["token"]}", formData: deviceInfo, show: true);


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

  /// REQUESTS CONFIGURATION [DIO]

  ///  Estas funciones se encargan de realizar las peticiones a la API.
  ///  Se encargan de realizar las peticiones GET, POST, PUT, PATCH y DELETE.
  ///  [needsAuth] indica si la petición necesita autenticación.
  ///  [path] es la ruta de la petición.
  ///  [params] son los parámetros de la petición.
  ///  [show] indica si se quiere mostrar la respuesta por consola.
  ///  [connectionError] indica si se quiere mostrar el error de conexión.
  ///  [extend] indica si se quiere extender el tiempo de espera de la petición.

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
        data: formData,
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