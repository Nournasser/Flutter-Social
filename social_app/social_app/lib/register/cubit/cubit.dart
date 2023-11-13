import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Register/cubit/states.dart';
import 'package:social_app/model/social_user_model.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,

  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user.email);
      print(value.user.uid);
      userCreate(
        uId: value.user.uid,
        name: name,
        email: email,
        phone: phone,
      );
    }).catchError((error){
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    @required String name,
    @required String email,
    @required String phone,
    @required String uId,

})
  {
    SocialUserModel model = SocialUserModel(
      phone: phone,
      email: email,
      name: name,
      uId: uId,
      bio: 'write your bio ...',
      cover: 'https://img.freepik.com/free-photo/adorable-looking-kitten-with-sunglasses_23-2150886412.jpg?t=st=1697994758~exp=1697998358~hmac=cd29f255211faf1054d10fb27e829936ddaabb4e595562865f54af19279c6bd3&w=1380',
      image: 'https://img.freepik.com/free-photo/view-3d-woman_23-2150709978.jpg?t=st=1697897822~exp=1697901422~hmac=5b7e3a5ae7c5fe4fe1ea1338fd3e2eb926ddddd0b253a36d1e8b4c4c58fd7cf7&w=740',
      isEmailVerified: false
    );
    FirebaseFirestore.instance.collection('user').doc(uId).set(model.toMap()).then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error){
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibiliy()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }

}