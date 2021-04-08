import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../imports.dart';
import '../utils/logger.dart';

AppConfigs get appConfigs => Get.find();

class AppConfigs {
  final String termsURL;
  final String agoraAppID;
  final String privacyURL;
  final String giphyApiKey;
  final int imageCompressQuality;
  final int maxVideoDuration; //In Minutes
  final int maxSoundDuration; //In Minutes
  AppConfigs({
    @required this.termsURL,
    @required this.agoraAppID,
    @required this.privacyURL,
    @required this.giphyApiKey,
    @required this.imageCompressQuality,
    @required this.maxVideoDuration,
    @required this.maxSoundDuration,
  });

  static Future<void> init() async {
    var config = AppConfigs.fromMap({});
    try {
      final doc = await FirebaseFirestore.instance.doc('app/configs').get();
      if (!doc.exists) {
        doc.reference.set(config.toMap());
      } else {
        config = AppConfigs.fromMap(doc.data());
      }
    } catch (e) {
      logError('Make sure you deloyed firebase configs');
    }
    Get.put(config);
  }

  Map<String, dynamic> toMap() {
    return {
      'termsURL': termsURL ?? 'https://google.com',
      'agoraAppID': agoraAppID ?? '76b8071d6a604028bf448810757c4e39',
      'privacyURL': privacyURL ?? 'https://google.com',
      'giphyApiKey': giphyApiKey ?? 'XXXXXXXXX',
      'imageCompressQuality': imageCompressQuality ?? 80,
      'maxVideoDuration': maxVideoDuration ?? 5,
      'maxSoundDuration': maxSoundDuration ?? 5,
    };
  }

  factory AppConfigs.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AppConfigs(
      termsURL: '${map['termsURL'] ?? ''}',
      agoraAppID: '${map['agoraAppID'] ?? ''}',
      privacyURL: '${map['privacyURL'] ?? ''}',
      giphyApiKey: '${map['giphyApiKey'] ?? ''}',
      imageCompressQuality:
          int.tryParse('${map['imageCompressQuality'] ?? ''}') ?? 80,
      maxVideoDuration: int.tryParse('${map['maxVideoDuration'] ?? ''}') ?? 5,
      maxSoundDuration: int.tryParse('${map['maxSoundDuration'] ?? ''}') ?? 5,
    );
  }
}
