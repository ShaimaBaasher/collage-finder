part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const splash = _Paths.splash;
  static const formview = _Paths.formview;
  static const universityDetailsView = _Paths.universityDetailsView;
}

abstract class _Paths {
  static const splash = '/splash';
  static const formview = '/form-table-view';
  static const universityDetailsView = '/university-details-view';
}
