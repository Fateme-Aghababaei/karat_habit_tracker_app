import 'package:get/get.dart';

import '../model/entity/statistics_model.dart';
import '../model/repositories/statistics_repository.dart';
import '../view/components/Sidebar/SideBarController.dart';

class StatisticsViewModel extends GetxController {
  final StatisticsRepository repository=StatisticsRepository();

  final SideBarController sideBarController =Get.find<SideBarController>();
  var statisticsList = <Statistics>[].obs;
  var isLoading = false.obs;
  final RxBool fetchError = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    await loadStatistics();


  }
  Future<void> loadStatistics() async {
    try {
      isLoading(true);
      var stats = await repository.fetchStatistics();
      if (stats != null) {
        statisticsList.assignAll(stats);
      } else {
        fetchError(true);
      }
    } catch (e) {
      fetchError(true);
    } finally {
      isLoading(false);
    }
  }
}
