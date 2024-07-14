import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/constants.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());


  Future<void> register({required String email,required String password}) async{
    emit(RegisterLoading());
    try{
       await registerUser(email,password,);
      emit(RegisterSuccess());
      //showSnackBar(context, 'success');
      //Navigator.pop(context);
    }on FirebaseAuthException catch (e){
      if(e.code =='weak-password'){
        emit(RegisterError(errorMassage: 'weak password'));
        //showSnackBar(context,'Weak password');
      }else if(e.code=='email-already-in-use'){
        emit(RegisterError(errorMassage: 'email already in use'));
        //showSnackBar(context, 'email already in use');
      }
    }catch(e){
      emit(RegisterError(errorMassage: 'there was an error'));
      //showSnackBar(context, 'there was an error');
    }
  }
}
