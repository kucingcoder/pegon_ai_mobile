import 'package:dio/dio.dart';
import '../data/variabels.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Variabels.baseUrl,
      validateStatus: (status) {
        return status != null;
      },
    ),
  );
}
