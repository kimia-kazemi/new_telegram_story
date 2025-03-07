import 'package:get/get.dart';
import '../../../controllers/root/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RootController());
  }
}