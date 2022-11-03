import '../../models/login_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

/// login
class LoginLoadingStates extends AppStates {}
class LoginSuccessStates extends AppStates {
  final LoginModel loginModel;
  LoginSuccessStates(this.loginModel);
}
class LoginErrorStates extends AppStates {}


/// home
class GetGalleryLoadingStates extends AppStates {}
class GetGallerySuccessStates extends AppStates {}
class GetGalleryErrorStates extends AppStates {}

/// upload
class UploadLoadingStates extends AppStates {}
class UploadSuccessStates extends AppStates {}
class UploadErrorStates extends AppStates {}

class ImagePickedSuccessState extends AppStates {}
class CameraPickedSuccessState extends AppStates {}