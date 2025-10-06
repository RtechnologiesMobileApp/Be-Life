abstract class BaseApiService{
  Future<dynamic>getApi({required String url,String? token});
  Future<dynamic>postApi({required String url,dynamic data,String?token});
  Future<dynamic>putApi({required String url,dynamic data,String? token});
  Future<dynamic>deleteApi({required String url,dynamic data,String? token});
}