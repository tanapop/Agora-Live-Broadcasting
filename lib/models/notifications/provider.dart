import 'dart:async';

import 'package:guard/guard.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:streamer/data/notifications.dart';
import 'package:streamer/models/notifications/notification.dart';

import '../../imports.dart';

NotificationProvider get notificationProvider => guard(
      () => Get.find<NotificationProvider>(),
      Get.put(NotificationProvider()),
    );

class NotificationProvider {
  final refreshController = RefreshController();

  StreamSubscription<List<NotificationModel>> notListener;
  void init() {
    notListener = NotificationRepo.notsStream(2)
        .listen(NotificationRepo.checkIfToShowNotification);
  }

  final limit = 20.obs;
  Stream<List<NotificationModel>> get notsStream =>
      NotificationRepo.notsStream(limit());

  void onLoadMore() {
    limit.value += 20;
    refreshController.loadComplete();
  }

  void dispose() {
    notListener?.cancel();
    notListener = null;
  }
}
