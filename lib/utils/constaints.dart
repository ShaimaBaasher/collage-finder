
import 'package:collage_finder/models/admission_model.dart';

import 'firebase/firebase.dart';

final UNIVERSITIES_REF = fireStore.collection('universities');
final UNIVERSITY_CATEGORY_REF = fireStore.collection('university-category');
final UNIVERSITY_SECTOR_REF = fireStore.collection('university-sector');
final COLLAGES_REF = fireStore.collection('collages');
final DEPARTMENT_REF = fireStore.collection('department');
final GENDER_REF = fireStore.collection('gender');
final TOTAL_REF = fireStore.collection('total');
final RATE_REF = fireStore.collection('rates');
final SUPERLATIVE_REF = fireStore.collection('superlative');
final ADMISSION_REF = fireStore.collection('universities-admission-rate');
final AREA_REF = fireStore.collection('area');
final STORAGE_REF = fireStorage.ref().child('yallabook-user-profile-images');
