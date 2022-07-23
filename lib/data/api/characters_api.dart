import 'package:dio/dio.dart';
import 'package:harry_potter/constant/string.dart';

class CharacterApi {
  late Dio dio;
  CharacterApi() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: 20 * 1000,
      connectTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(
        e.toString(),
      );
      return [];
    }
  }
}
