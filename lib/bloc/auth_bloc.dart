import 'package:bloc/bloc.dart';
import 'package:chat_app/widgets/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {

      if(event is LoginAuth){
        emit(LoginLoading());
        try{
          await signIn(event.email,event.password);
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

      if (event is RegisterAuth){
        emit(RegisterLoading());
        try{
          await registerUser(event.email,event.password,);
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
    });

  }

}
