import 'package:get/get.dart';

import 'en.dart';
import 'ar.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}
