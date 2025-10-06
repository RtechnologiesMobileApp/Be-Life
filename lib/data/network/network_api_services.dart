import 'dart:convert';
import 'package:http/http.dart'as http;
import '../exceptions/app_exceptions.dart';
import 'base_api_services.dart';
class NetworkApiService extends BaseApiService{
  @override
  Future<dynamic> getApi({required String url,String? token}) async{
    try{
      final response= await http.get(Uri.parse(url),  headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },);
      final responseResult= returnResponse(response);
      return responseResult;
    }catch(e){
      rethrow;
    }

  }

  @override
  Future<dynamic> postApi({required String url, data, String? token}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: data != null ? jsonEncode(data) : null,
      );
      final responseResult = returnResponse(response);
      return responseResult;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Future putApi({required String url, dynamic data,String? token}) async{
    try{
      final response= await http.put(Uri.parse(url),body: jsonEncode(data),  headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },);
      final responseResult= returnResponse(response);
      return responseResult;
    }catch(e){
      rethrow;
    }
  }

  @override
  Future deleteApi({required String url, data, String? token}) async{
    try{
      final response= await http.delete(Uri.parse(url),body: data != null ? jsonEncode(data) : null,  headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },);
      final responseResult= returnResponse(response);
      return responseResult;
    }catch(e){
      rethrow;
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);

      case 204:
        return null;

      case 400:
        final decoded = jsonDecode(response.body);
        throw BadRequestException(decoded['message']);

      case 401:
        final decoded = jsonDecode(response.body);
        throw UnauthorizedException(decoded['message']);

      case 403:
        throw ForbiddenException(response.body.toString());

      case 404:
        final decoded = jsonDecode(response.body);
        throw NotFoundException(decoded['message']);

      case 405:
        throw MethodNotAllowedException(response.body.toString());

      case 408:
        throw RequestTimeoutException(response.body.toString());

      case 409:
        throw ConflictException(response.body.toString());

      case 429:
        throw TooManyRequestsException(response.body.toString());

      case 500:
        throw InternalServerException(response.body.toString());

      case 502:
        throw BadGatewayException(response.body.toString());

      case 503:
        throw ServiceUnavailableException(response.body.toString());

      case 504:
        throw GatewayTimeoutException(response.body.toString());

      default:
        throw AppExceptions("Unexpected error", "Error: ");
    }
  }

}