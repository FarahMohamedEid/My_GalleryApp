import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery_app/core/logic/cubit/app_cubit.dart';
import 'package:my_gallery_app/core/logic/cubit/app_states.dart';
import 'package:my_gallery_app/core/utilities/resources/constants.dart';
import 'package:my_gallery_app/core/utilities/widgets/blur_container.dart';
import '../../core/network/local/cache_helper.dart';
import '../../core/utilities/resources/color_style.dart';
import '../../core/utilities/resources/font_style.dart';
import '../../core/utilities/resources/screen_size.dart';
import '../../core/utilities/widgets/image_item.dart';
import '../../core/utilities/widgets/show_dialog.dart';
import '../../core/utilities/widgets/svg_image.dart';
import '../login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizes.screenWidth = MediaQuery.of(context).size.width;
    ScreenSizes.screenHeight = MediaQuery.of(context).size.height;
    String username =CacheHelper.getData(key: 'username');
    AppCubit.get(context).getGallery();
    return Scaffold(
      body:Stack(
        children:[
          /// Background
          const SvgImage(svgName: 'home',fit: BoxFit.cover,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: BlocConsumer<AppCubit,AppStates>(
                listener: (context, state) {},
                builder: (context, state){
                  var cubit = AppCubit.get(context);
                  if(state is GetGallerySuccessStates){
                    return SafeArea(
                      child: Column(
                        children: [
                          /// user name
                          const SizedBox(height: 4,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Welcome\n $username',
                                textAlign: TextAlign.left,
                                style:TextStyle(
                                  fontFamily: FontConstants.fontFamilyHome,
                                  fontSize: 22.rSp,
                                  fontWeight: FontWeightManager.light,
                                  color: ColorStyle.mainColor,
                                ) ,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundImage: AssetImage('assets/images/profile.png'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50.rSp,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                /// logout
                                BlurContainer(
                                  width: 145.rSp,
                                  height: 46.rSp,
                                  radius: 16.rSp,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric( horizontal: 10.0 ,vertical: 4.0),
                                    child: InkWell(
                                      onTap: (){
                                        CacheHelper.saveData(key: 'goHome', value: false);
                                        CacheHelper.removeData(key: 'token');
                                        CacheHelper.removeData(key: 'username');
                                        navigateAndFinish(context, const LoginScreen());
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/logout.png',
                                            fit: BoxFit.none,
                                            alignment: Alignment.centerLeft,
                                          ),
                                          SizedBox(
                                            width: 10.rSp,
                                          ),
                                          Text('Log out',
                                            textAlign: TextAlign.center,
                                            style:TextStyle(
                                              fontFamily: FontConstants.fontFamilyHome,
                                              fontSize: 16.rSp,
                                              fontWeight: FontWeightManager.light,
                                              color: ColorStyle.mainColor,
                                            ) ,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.rSp,
                                ),
                                /// upload
                                BlurContainer(
                                  width: 145.rSp,
                                  height: 46.rSp,
                                  radius: 16.rSp,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric( horizontal: 10.0 ,vertical: 4.0),
                                    child: InkWell(
                                      onTap: (){
                                        showDialog(
                                            barrierColor: Colors.transparent,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const ShowDialog();
                                            });
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/upload.png',
                                            fit: BoxFit.none,
                                            alignment: Alignment.centerLeft,
                                          ),
                                          SizedBox(
                                            width: 10.rSp,
                                          ),
                                          Text('Upload',
                                            textAlign: TextAlign.center,
                                            style:TextStyle(
                                              fontFamily: FontConstants.fontFamilyHome,
                                              fontSize: 16.rSp,
                                              fontWeight: FontWeightManager.light,
                                              color: ColorStyle.mainColor,
                                            ) ,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height:30.rSp,
                          ),
                          /// list of images

                          if(state is GetGalleryLoadingStates)
                            const Center(child: CircularProgressIndicator(),),

                            if(cubit.galleryList.data!.images.isNotEmpty)
                            Expanded(
                            child: GridView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 24,
                              ),
                              children: [
                                for(var image in cubit.galleryList.data!.images)
                                  ImageItem(imagePath: image),
                              ],
                            ),
                          ),
                            if(cubit.galleryList.data!.images.isEmpty)
                             Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 60.0),
                                child: Text('No Images For Now !\n Please Upload Some Images',
                                  textAlign: TextAlign.center,
                                  style:TextStyle(
                                    fontFamily: FontConstants.fontFamilyHome,
                                    fontSize: 30.rSp,
                                    fontWeight: FontWeightManager.light,
                                    color: ColorStyle.mainColor,
                                  ) ,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }else{
                   return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
