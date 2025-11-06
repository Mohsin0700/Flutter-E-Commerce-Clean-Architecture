import 'package:get/get.dart';

class MainController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  // Agar specific tab par navigate karna ho
  void navigateToTab(int index) {
    currentIndex.value = index;
  }
}
