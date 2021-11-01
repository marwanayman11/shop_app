import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegister extends StatelessWidget {
  final emailCont = TextEditingController();
  final passCont = TextEditingController();
  final nameCont = TextEditingController();
  final phoneCont = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ShopRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterShopCubit(),
      child: BlocConsumer<RegisterShopCubit, RegisterShopStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              if (state.registerModel.status!) {
                CacheHelper.saveData(
                        key: 'token', value: state.registerModel.data!.token)
                    .then((value) {
                  token = CacheHelper.getData(key: 'token');
                  pushToAndFinish(context, const ShopLayout());
                });
              } else {
                showToast(
                    message: '${state.registerModel.message}',
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
                            "Register",
                            style: GoogleFonts.aladin(
                                fontSize: 50, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Register now to browse our products",
                            style: GoogleFonts.aladin(
                                fontSize: 30, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultForm(
                              controller: nameCont,
                              type: TextInputType.name,
                              label: "Name",
                              prefix: Icons.person,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Name can\'t be empty';
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultForm(
                              controller: emailCont,
                              type: TextInputType.emailAddress,
                              label: "Email Address",
                              prefix: Icons.email_outlined,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Email can\'t be empty';
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
                              isPassword: RegisterShopCubit.get(context).passVis,
                              suffix:RegisterShopCubit.get(context).passVis
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              suffixPressed: () {
                                RegisterShopCubit.get(context).changePassVis();
                              },
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Password can\'t be empty';
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultForm(
                              controller: phoneCont,
                              type: TextInputType.phone,
                              label: "Phone",
                              prefix: Icons.phone,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Phone can\'t be empty';
                                }
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          state is RegisterLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : defaultButton(
                                  text: 'register',
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      RegisterShopCubit.get(context).register(
                                          name: nameCont.text,
                                          phone: phoneCont.text,
                                          email: emailCont.text,
                                          password: passCont.text);
                                    }
                                  },
                                  isUpper: true,
                                  color: Colors.green),
                        ],
                      ),
                    ),
                  ),
                ),
              ))),
    );
  }
}
