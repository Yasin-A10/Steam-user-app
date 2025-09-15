import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/utils/validators.dart';
import 'package:steam/core/widgets/button.dart';
import 'package:steam/core/widgets/inputs/input_form_feild.dart';
import 'package:image_picker/image_picker.dart';
import 'package:steam/features/auth/data/model/get_name_model.dart';
import 'package:steam/features/auth/presentation/bloc/get_name/get_name_bloc.dart';
import 'dart:io';

class GetNameScreen extends StatefulWidget {
  const GetNameScreen({super.key});

  @override
  State<GetNameScreen> createState() => _GetNameScreenState();
}

class _GetNameScreenState extends State<GetNameScreen> {
  GlobalKey<FormState> getNameFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleEditImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _pickedImage = file;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayImage = _pickedImage != null
        ? Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: FileImage(_pickedImage!),
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.myGrey5, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              HugeIcons.strokeRoundedUser02,
              color: AppColors.myGrey,
              size: 80,
            ),
          );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: -140,
                right: -140,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.orange,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: Container(
                      width: 250,
                      height: 250,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -140,
                left: -140,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blue,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: Container(
                      width: 250,
                      height: 250,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -160,
                right: -160,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.orange,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: Container(
                      width: 250,
                      height: 250,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -160,
                left: -160,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blue,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: Container(
                      width: 250,
                      height: 250,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 150),
                      displayImage, //! picked image
                      Transform(
                        transform: Matrix4.translationValues(0, -24, 0),
                        child: IconButton(
                          onPressed: () {
                            _handleEditImage();
                          },
                          icon: Icon(
                            HugeIcons.strokeRoundedPen01,
                            color: AppColors.myGrey,
                            size: 24,
                          ),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              AppColors.myGrey7,
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: AppColors.myGrey4,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.all(8),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 44),
                        child: Form(
                          key: getNameFormKey,
                          child: Column(
                            children: [
                              CustomInputField(
                                label: 'نام و نام خانوادگی',
                                controller: nameController,
                                icon: HugeIcons.strokeRoundedUser,
                                validator: (value) => AppValidator.userName(
                                  value,
                                  fieldName: 'نام و نام خانوادگی',
                                ),
                              ),
                              const SizedBox(height: 16),
                              BlocConsumer<GetNameBloc, GetNameState>(
                                listener: (context, state) {
                                  if (state is GetNameSuccess) {
                                    GoRouter.of(context).go('/');

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'اطلاعات با موفقیت آپدیت شد!',
                                        ),
                                        backgroundColor: AppColors.success200,
                                      ),
                                    );
                                  }
                                  if (state is GetNameError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(state.message),
                                        backgroundColor: AppColors.error200,
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return Button(
                                    width: double.infinity,
                                    label: 'ورود',
                                    textColor: AppColors.white,
                                    backgroundColor: AppColors.orange,
                                    onPressed: state is GetNameLoading
                                        ? null
                                        : () {
                                            if (!getNameFormKey.currentState!
                                                .validate()) {
                                              return;
                                            }

                                            final updatedUser = GetNameModel(
                                              fullName: nameController.text
                                                  .trim(),
                                              picture: _pickedImage,
                                            );

                                            BlocProvider.of<GetNameBloc>(
                                              context,
                                            ).add(
                                              SendNameEvent(
                                                userInfo: updatedUser,
                                              ),
                                            );
                                          },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
