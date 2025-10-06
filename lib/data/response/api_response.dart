import '../../utils/enums.dart';

class ApiResponse<T>{
  T? data;
  Status? status;
  String? message;
  ApiResponse({ this.data,this.status,this.message});
  ApiResponse.loading():status=Status.loading;
  ApiResponse.completed(this.data):status=Status.completed;
  ApiResponse.error(this.message):status=Status.error;

  @override
  String toString(){
    return 'status $status \n Message $message \n Data $data';
  }
}