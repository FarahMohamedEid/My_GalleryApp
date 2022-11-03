import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery_app/core/utilities/resources/constants.dart';
import '../../models/gallery_model.dart';
import '../../models/login_model.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/api_endpoints/end_point.dart';
import '../../network/remote/dio_helpers/dio_helper.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  /// login

  late LoginModel loginModel;
  var mailController = TextEditingController();
  var passwordController = TextEditingController();

  void validateData(){
    if (mailController.text.isEmpty) {
      showToast(
        message: 'Please enter your email',
        state: ToastStates.ERROR,
      );
    }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+")
        .hasMatch(mailController.text)){
      showToast(
        message: 'Invalid mail !!',
        state: ToastStates.ERROR,
      );
    }else if (passwordController.text.isEmpty) {
      showToast(
        message: 'Please enter your password',
        state: ToastStates.ERROR,
      );
    } else {
      userLogin();
    }
  }

  void userLogin() async {
    emit(LoginLoadingStates());

    DioHelper.postData(
      url: USERS_LOGIN,
      data: {
        'email': mailController.text,
        'password': passwordController.text,
      },
    ).then((value) {
      try {
        loginModel = LoginModel.fromJson(value!.data);
        CacheHelper.saveData(key: 'goHome', value: true);
        CacheHelper.saveData(key: 'token', value: loginModel.token);
        CacheHelper.saveData(key: 'username', value: loginModel.user!.name);
        showToast(message: 'LogIn successfully', state: ToastStates.SUCCESS);
        emit(LoginSuccessStates(loginModel));
      } catch (e) {
        showToast(message: value!.data.toString(), state: ToastStates.ERROR);
        emit(LoginErrorStates());
      }
    },
    ).catchError((error) {
      showToast(message: error.toString(), state: ToastStates.ERROR);
      emit(LoginErrorStates());
    });
  }


  /// home
  /// get gallery

  late GalleryModel galleryList;
void getGallery(){
  emit(GetGalleryLoadingStates());
  DioHelper.getData(
    url: MY_GALLERY,
    token: CacheHelper.getData(key: 'token'),
    // token: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYTE3MTBmNTA4MzFmY2NiNDYwNGExMzY0ODJmNDFiZjU5OTEzY2JkY2ZhZmU2ZDY1OWJmZmQ5OGVkODE1MDk5MTRmNTRmMjZmZDA2NGZjZDIiLCJpYXQiOjE2NjcyODk3ODUuMDMzMTk5LCJuYmYiOjE2NjcyODk3ODUuMDMzMjAzLCJleHAiOjE2OTg4MjU3ODUuMDI2MzI0LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.bWImC0xkzNQe8iKxL1Scg0tGGZGUy3vWsiX1vBzj1gLvynIMJcOqVkEVZc2C3MgSaCHjyqGkN7zWyqYVqLasAaKKFmj9JiQgXozvPcHJPoJCGQQvogt-gnM0DPeFMF-g_CVJPNZ3nUkXpOLl3Os5DhvW53OVT1n5pisoNyvsrEJURWTXxt1EIxwnmoj0An8y9kq2WSX4Zn2RoVGKe3QnL-KOGKksfv2ahj7hG-ZNwVYazI6TXCIxZBCYGoZtfvq9CjTrVUcCBSiGgdyaJzAZi0lNR2c2zcZxWGbBQ_QvfTFDZmmPyogScE5cgy4MGsnYe4Sw7qLmHIrSsrMaJxRgQ_b7xobq9ob1vDhw9O-VcPpiCllEFyjMkdKOFC8UffoYZB3bafp9KZB6Dr3tS7fo6f4ojAKnj-b8g6AigjuFb4FAYlC0vxT76mtvvYFm8MjH1kH2QmJ0HzvhBxv45K9Cdtuvr3DdrwyDaoROR4eZ6S-Xp-LYuCkZ-e4UenLJC4mDUu8u6xoyLHKul3FhNlAUMj-oScKZgJxRUYhbVxzXruHwaycKdlX284-Y6cfSAf3AjIvfaXYeB1ajGuuCtYceBVGM5tDxY4i9I7kthk3DNRjaRQPIl5c8GQlYV3I3p-RItB33Y-ECNiG92U2fgB8fAVw5urOuFX7pIZZ0NEc6VAY',
  ).then((value) {
    galleryList = GalleryModel.fromJson(value!.data);
    showToast(message: galleryList.message, state: ToastStates.SUCCESS);
    emit(GetGallerySuccessStates());
  },
  ).catchError((error) {
    emit(GetGalleryErrorStates());
  });
}


/// home
/// update image


  var picker = ImagePicker();
  File? image;

  Future<void> pikeImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery).then((value){
      image = File(value!.path);
      emit(ImagePickedSuccessState());
      if(image != null){
        uploadImage();
      }
    });
  }

  Future<void> pikeCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera).then((value){
      image = File(value!.path);
      emit(CameraPickedSuccessState());
      if(image != null){
        uploadImage();
      }
    });
  }


  Future<void> uploadImage() async {
    emit(UploadLoadingStates());
    DioHelper.postData(
      url: UPLOAD,
      token: CacheHelper.getData(key: 'token'),
        data: FormData.fromMap(
          {
            'img':  await MultipartFile.fromFile(
                image!.path,
              filename: Uri.file(image!.path).pathSegments.last),
          },
        )
    ).then((value) {
      getGallery();
      emit(GetGallerySuccessStates());
    },
    ).catchError((error) {
      emit(GetGalleryErrorStates());
    });
  }

}
