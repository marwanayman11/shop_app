import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(builder: (context, state) {
      nameController.text = ShopCubit.get(context).profileModel!.data!.name!;
      emailController.text = ShopCubit.get(context).profileModel!.data!.email!;
      phoneController.text = ShopCubit.get(context).profileModel!.data!.phone!;
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (state is ShopLoadingUpdateDataState)
                  const LinearProgressIndicator(),
                const SizedBox(
                  height: 20,
                ),
                CachedNetworkImage(imageUrl:'${ShopCubit.get(context).profileModel!.data!.image}',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultForm(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    prefix: Icons.person,
                    validate: (value) {
                      if (formKey.currentState!.validate()) {
                        return 'name can\'t be empty';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                defaultForm(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email',
                    prefix: Icons.email_outlined,
                    validate: (value) {
                      if (formKey.currentState!.validate()) {
                        return 'email can\'t be empty';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                defaultForm(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone number',
                    prefix: Icons.phone,
                    validate: (value) {
                      if (formKey.currentState!.validate()) {
                        return 'phone can\'t be empty';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                    text: 'Update',
                    function: () {
                      ShopCubit.get(context).updateData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text);
                    },
                    color: Colors.green)
              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is ShopSuccessUpdateDataState) {
        if (state.model.status!) {
          showToast(
              message: '${state.model.message}', state: toastStates.success);
        } else {
          showToast(
              message: '${state.model.message}', state: toastStates.error);
        }
      }
    });
  }
}
