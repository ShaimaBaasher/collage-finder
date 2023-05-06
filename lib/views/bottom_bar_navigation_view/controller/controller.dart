import 'package:get/get.dart';

class VisaExaminerController extends GetxController {

  var isLoading = false.obs;

  var selectedChipItemIndex = 0;
  var isSwitched = false.obs;

  final chipList = ['tourist', 'journalist', 'limited-stay'];

  // final wishModelList = <WishModel>[].obs;
  void isItemSelected(int index) {
    selectedChipItemIndex = index;
    update();
  }

  Future getWishList() async {
    isLoading(true);

    // wishModelList.clear();
    // wishModelList
    //     .add(WishModel(name: 'Favorite', saveplaces: 18, imgs: chipList));

    isLoading(false);

  }

  void toggleSwitch(bool switchValue) async {
    if (switchValue == true) {
      // check(switchValue, onFailure: (value) {
      //   EasyLoading.showError(value, duration: const Duration(seconds: 2));
      // });
    } else {
      // check(switchValue, onFailure: (value) {
      //   EasyLoading.showError(value, duration: const Duration(seconds: 2));
      // });
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}