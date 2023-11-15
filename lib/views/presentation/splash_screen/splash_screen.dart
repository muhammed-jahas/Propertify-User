import 'package:flutter/material.dart';
import 'package:propertify/blocs/payment_bloc/payment_bloc.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/views/presentation/navigation/navigation.dart';
import 'package:propertify/views/presentation/welcome_screen/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/home_bloc/home_bloc.dart';
import '../../../data/shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    validateUser();
    // getUserData();
  }

  @override
  Widget build(BuildContext context) {
     //context.read<HomeBloc>().add(getAllProperties());
    // context.read<PaymentRequestsBloc>().add(getAllPaymentRequestsEvent());
    BlocProvider.of<HomeBloc>(context).add(getAllProperties());
    BlocProvider.of<PaymentRequestsBloc>(context)
        .add(getAllPaymentRequestsEvent());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage(
                'assets/images/logo/propertify-logo.png',
              ),
              fit: BoxFit.cover,
              height: 140,
            ),
          )
        ],
      ),
    );
  }

  void validateUser() async {
    final userPhone = await SharedPref.instance.getUser();
    if (userPhone != null) {
      print('this is in splash: $userPhone');
      try {
        await gotoDashboard(context);
      } catch (e) {
        await gotoDashboard(context);
      }
    } else {
      await gotoWelcome(context);
    }
  }

  gotoDashboard(BuildContext ctx) async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (context) => NavigationItems()));
  }

  gotoWelcome(BuildContext ctx) async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }
}

// Future<UserModel> getUserData() async {
//   final userPhone = await SharedPref.instance.getUser();
//   UserModel user = UserModel(
//     usermobNo: userPhone,
//   );
//   return user;
// }
