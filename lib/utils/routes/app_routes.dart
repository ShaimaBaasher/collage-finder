part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const splash = _Paths.splash;
  static const formview = _Paths.formview;
  static const universityDetailsView = _Paths.universityDetailsView;
  static const admissionView = _Paths.admissionView;
  static const collageView = _Paths.collageView;
  static const departmentView = _Paths.departmentView;
  static const rateView = _Paths.rateView;
  static const universityView = _Paths.universityView;
  static const adviceView = _Paths.adviceView;
}

abstract class _Paths {
  static const splash = '/splash';
  static const formview = '/form-table-view';
  static const universityDetailsView = '/university-details-view';
  static const admissionView = '/admission-view';
  static const collageView = '/collage-view';
  static const departmentView = '/department-view';
  static const rateView = '/rate-view';
  static const universityView = '/university-view';
  static const adviceView = '/advice-view';
}
