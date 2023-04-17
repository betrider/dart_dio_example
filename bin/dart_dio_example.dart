import 'package:dio/dio.dart';

void main(List<String> arguments) async {
  var dio = Dio();

  dio.interceptors.add(LogInterceptor());

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      print('onRequest');
      return handler.next(options);
      // return handler.resolve(Response(requestOptions:options, data:'fake data'));
      // return handler.reject(DioError(requestOptions: options, message: 'error test'));
    },
    onResponse: (response, handler) {
      print('onResponse');
      return handler.next(response);
    },
    onError: (error, handler) {
      print('onError');
      return handler.next(error);
    },
  ));

  // 첫번째 방법
  try {
    final response = await dio.get('https://jsonplaceholder.typicode.com/comments?postId=1');
    print(response.statusCode);
    print(response.data);
  } on DioError catch (e) {
    print('error : ${e.message}' );
  }

  // 두번째 방법
  // final response2 = await dio.get('https://jsonplaceholder.typicode.com/comments', queryParameters: {'postId': 1});
  // print(response2);

  // // 세번째 방법
  // final response3 = await dio.request(
  //   'https://jsonplaceholder.typicode.com/comments',
  //   data: {'postId': 1},
  //   options: Options(method: 'GET'),
  // );
  // print(response3);

}
