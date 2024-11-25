import 'package:flutter_developer_test/common/api/api_client.dart';
import 'package:flutter_developer_test/common/utils/app_constants.dart';
import 'package:flutter_developer_test/controller/product_controller.dart';
import 'package:get/get.dart';
class Global {
  static Future<void> init()async{
    
    
    Get.put(ProductController(apiClient: ApiClient(appBaseUrl: AppConstant.BASE_URL)));
  }
}