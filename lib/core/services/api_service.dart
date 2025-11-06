import 'package:dio/dio.dart';
import 'package:imr/app/config/app_config.dart';

class ApiService {
  final Dio _dio = Dio();

  // Resusable function for fetching data in all repositories

  Future<dynamic> getData(String endPoint) async {
    print('Get Data Function called from API Service');
    try {
      final response = await _dio.get(AppUrls.baseUrl + endPoint);
      print('Api has been hit');
      if (response.statusCode != 200) return null;
      print(
        'Fetched Data from API Service::::::::::::::::::::::::::::::::::${response.data}',
      );
      return response.data;
    } catch (e) {}
  }
}
