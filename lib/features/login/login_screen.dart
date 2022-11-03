import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery_app/core/logic/cubit/app_cubit.dart';
import 'package:my_gallery_app/core/logic/cubit/app_states.dart';
import 'package:my_gallery_app/core/utilities/widgets/input_field.dart';
import '../../../../core/utilities/resources/screen_size.dart';
import '../../../../core/utilities/resources/font_style.dart';
import '../../../../core/utilities/resources/color_style.dart';
import '../../core/utilities/resources/constants.dart';
import '../../core/utilities/widgets/blur_container.dart';
import '../../core/utilities/widgets/main_elevated_button.dart';
import '../../core/utilities/widgets/svg_image.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizes.screenWidth = MediaQuery.of(context).size.width;
    ScreenSizes.screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          /// Background
          const SvgImage(svgName: 'login',fit: BoxFit.cover,),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              child: const SvgImage(
                svgName: 'cam',
                fit: BoxFit.fill,
              ),
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          Image.asset('assets/images/love.png'),

          /// Login Form
          BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {
              if (state is LoginSuccessStates) {
                navigateTo(
                  context,
                  const HomeScreen(),
                );
              }
            },
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              return Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 80),
                      Text(
                        'My\n Gallery',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: FontConstants.fontFamilyLogin,
                          fontSize: 46.rSp,
                          fontWeight: FontWeightManager.semiBold,
                          color: ColorStyle.mainColor,
                        ),
                      ),
                      SizedBox(
                        height: 40.rSp,
                      ),
                      BlurContainer(
                        width: 345.rSp,
                        height: 400.rSp,
                        radius: 32.rSp,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Text(
                                'LOG IN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FontConstants.fontFamilyLogin,
                                  fontSize: 30.rSp,
                                  fontWeight: FontWeightManager.semiBold,
                                  color: ColorStyle.mainColor,
                                ),
                              ),
                              SizedBox(
                                height: 40.rSp,
                              ),

                              /// username input
                              InputField(
                                controller: cubit.mailController,
                                inputType: TextInputType.emailAddress,
                                hintText: 'Email',
                              ),
                              SizedBox(
                                height: 40.rSp,
                              ),

                              /// password input
                              InputField(
                                controller: cubit.passwordController,
                                inputType: TextInputType.visiblePassword,
                                hintText: 'Password',
                              ),
                              SizedBox(
                                height: 40.rSp,
                              ),

                              /// submit button
                              MainElevatedButton(
                                loading: state is LoginLoadingStates,
                                onPressed: () {
                                  cubit.validateData();
                                },
                                color: ColorStyle.btnColor,
                                text: 'SUBMIT',
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
