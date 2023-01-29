abstract class AppStates{}
class AppInitialState extends AppStates{}

class ChangeScreenState extends AppStates{}
class VisiblePasswordLogin extends AppStates{}

class LoadingLoginState extends AppStates{}
class SuccessLoginState extends AppStates{}
class ErrorLoginState extends AppStates{
  final String error;
  ErrorLoginState({required this.error});
}

class LoadingGetUserDate extends AppStates{}
class SuccessGetUserDate extends AppStates{}
class ErrorGetUserDate extends AppStates{
  final String error;
  ErrorGetUserDate({required this.error});
}

class SignOutState extends AppStates{}

class LoadingGetEmpDate extends AppStates{}
class SuccessGetEmpDate extends AppStates{}
class ErrorGetEmpDate extends AppStates{
  final String error;
  ErrorGetEmpDate({required this.error});
}

class LoadingPostTask extends AppStates{}
class SuccessPostTask extends AppStates{}
class ErrorPostTask extends AppStates{
  final String error;
  ErrorPostTask({required this.error});
}

class LoadingGetTask extends AppStates{}
class SuccessGetTask extends AppStates{}
class ErrorGetTask extends AppStates{
  final String error;
  ErrorGetTask({required this.error});
}

class LoadingPostReport extends AppStates{}
class SuccessPostReport extends AppStates{}
class ErrorPostReportState extends AppStates{}
class ErrorPostReport extends AppStates{
  final String error;
  ErrorPostReport({required this.error});
}

class LoadingGetReport extends AppStates{}
class SuccessGetReport extends AppStates{}
class ErrorGetReport extends AppStates{
  final String error;
  ErrorGetReport({required this.error});
}

class LoadingGetMosques extends AppStates{}
class SuccessGetMosques extends AppStates{}
class ErrorGetMosques extends AppStates{
  final String error;
  ErrorGetMosques({required this.error});
}
class LoadingGetDataMosque extends AppStates{}
class SuccessGetDataMosque extends AppStates{}
class ErrorGetDataMosque extends AppStates{
  final String error;
  ErrorGetDataMosque({required this.error});
}

class LoadingPostRate extends AppStates{}
class SuccessPostRate extends AppStates{}
class ErrorPostRate extends AppStates{
  final String error;
  ErrorPostRate({required this.error});
}

class ChangeImage1 extends AppStates{}
class ChangeImage2 extends AppStates{}
class ChangeImage3 extends AppStates{}
class AddRate extends AppStates{}

