import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/shop_register/shop_register.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLogin extends StatelessWidget {
  final emailCont = TextEditingController();
  final passCont = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ShopLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginShopCubit, LoginShopStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = CacheHelper.getData(key: 'token');
                pushToAndFinish(context, const ShopLayout());
              });
            } else {
              showToast(
                  message: '${state.loginModel.message}',
                  state: toastStates.error);
            }
          }
        },
        builder: (context, state) => Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.aladin(
                              fontSize: 50, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Login now to browse our products",
                          style: GoogleFonts.aladin(
                              fontSize: 30, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultForm(
                            controller: emailCont,
                            type: TextInputType.emailAddress,
                            label: "Email Address",
                            prefix: Icons.email_outlined,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Email must not be empty';
                              }
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultForm(
                            controller: passCont,
                            type: TextInputType.visiblePassword,
                            label: "Password",
                            prefix: Icons.lock_outline,
                            isPassword: LoginShopCubit.get(context).passVis,
                            suffix: LoginShopCubit.get(context).passVis
                                ? Icons.visibility_off
                                : Icons.visibility,
                            suffixPressed: () {
                              LoginShopCubit.get(context).changePassVis();
                            },
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                LoginShopCubit.get(context).login(
                                    email: emailCont.text,
                                    password: passCont.text);
                              }
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Password must not be empty';
                              }
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        state is LoginLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : defaultButton(
                                text: 'Login',
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginShopCubit.get(context).login(
                                        email: emailCont.text,
                                        password: passCont.text);
                                  }
                                },
                                isUpper: true,
                                color: Colors.green),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account ?',
                                style: GoogleFonts.aladin()),
                            TextButton(
                                onPressed: () {
                                  pushTo(context, ShopRegister());
                                },
                                child: Text(
                                  'Register',
                                  style: GoogleFonts.aladin(),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
