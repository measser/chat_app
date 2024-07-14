import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../widgets/constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email,required String password}) async{
    emit(LoginLoading());
    try{
       await signIn(email,password);
      emit(LoginSuccess());
    }on FirebaseAuthException catch (e){
      if(e.code =='user-not-found'){
        emit(LoginError(errorMassage: 'no user found for that email'));
      }else if(e.code=='wrong-password'){
        print('wrong password provided for that user.');
        emit(LoginError(errorMassage: 'wrong password provided for that user.'));
      }
    }catch(e){
      emit(LoginError(errorMassage: 'there was an error'));
    }
  }
}
