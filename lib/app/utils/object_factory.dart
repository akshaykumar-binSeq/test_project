import 'package:user_data_from_api/app/utils/api_client.dart';

/// it is a hub that connecting pref,repo,client
/// used to reduce imports in pages
class ObjectFactory {
  static final _objectFactory = ObjectFactory._internal();

  ObjectFactory._internal();

  factory ObjectFactory() => _objectFactory;

  ///Initialisation of Objects
  final ApiClient _apiClient = ApiClient();

  ApiClient get apiClient => _apiClient;
}
