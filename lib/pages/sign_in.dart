import 'package:alulatrail/blocs/sign_in_bloc.dart';
import 'package:alulatrail/config/config.dart';
import 'package:alulatrail/pages/done.dart';
import 'package:alulatrail/services/app_service.dart';
import 'package:alulatrail/utils/next_screen.dart';
import 'package:alulatrail/utils/snacbar.dart';
import 'package:alulatrail/widgets/language.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';



class SignInPage extends StatefulWidget {

  final String? tag;
  SignInPage({Key? key, this.tag}) : super(key: key);

  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool googleSignInStarted = false;


  var scaffoldKey = GlobalKey<ScaffoldState>();


  handleSkip (){
    final sb = context.read<SignInBloc>();
    sb.setGuestUser();
    nextScreen(context, DonePage());
    
  }


  handleGoogleSignIn() async{
    final sb = context.read<SignInBloc>();
    setState(() => googleSignInStarted = true);
    await AppService().checkInternet().then((hasInternet)async{
      if(hasInternet == false){
        openSnacbar(scaffoldKey, 'check your internet connection!'.tr());
      }else{
        await sb.signInWithGoogle().then((_){
        if(sb.hasError == true){
          openSnacbar(scaffoldKey, 'something is wrong. please try again.'.tr());
          setState(() =>googleSignInStarted = false);

        }else {
          sb.checkUserExists().then((value){
          if(value == true){
            sb.getUserDatafromFirebase(sb.uid)
            .then((value) => sb.saveDataToSP()
            .then((value) => sb.guestSignout())
            .then((value) => sb.setSignIn()
            .then((value){
              setState(() =>googleSignInStarted = false);
              afterSignIn();
            })));
          } else{
            sb.getJoiningDate()
            .then((value) => sb.saveToFirebase()
            .then((value) => sb.increaseUserCount())
            .then((value) => sb.saveDataToSP()
            .then((value) => sb.guestSignout()
            .then((value) => sb.setSignIn()
            .then((value){
              setState(() => googleSignInStarted = false);
              afterSignIn();
            })))));
          }
            });
          
        }
      });
      }
    });
  }


  afterSignIn (){
    if(widget.tag == null){
      nextScreen(context, DonePage());
    }else{
      Navigator.pop(context);
    }
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          widget.tag != null
              ? Container()
              : TextButton(
                  onPressed: () => handleSkip(),
                  child: Text('skip',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )).tr()),

          IconButton(
            alignment: Alignment.center,
            padding: EdgeInsets.all(0),
            iconSize: 22,
            icon: Icon(Icons.language,),
            onPressed: (){
              nextScreenPopup(context, LanguagePopup());
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'welcome to اهلا بكم في',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey[700]),
                  ).tr(),
                  SizedBox(height: 5,),
                  Text(
                    '${Config().appName}',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey[700],
                      letterSpacing: -0.5,
                      wordSpacing: 1
                    ),
                  ),
                ],
              )),
          Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Text(
                      'Explore Al-Ula And its wonderful Places',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600]),
                    ).tr(),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 3,
                    width: MediaQuery.of(context).size.width * 0.50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ],
              )),
          Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: TextButton(
                        onPressed: () => handleGoogleSignIn(),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blueAccent),
                          shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          ))
                        ),
                        child: googleSignInStarted == false
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesome.google,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Sign In with Google',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )
                                ],
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                    backgroundColor: Colors.white),
                              )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.80,

                        ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05)
                ],
              )),
        ],
      ),
    );
  }



  
}
