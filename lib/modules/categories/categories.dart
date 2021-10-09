import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => catList(
                  ShopCubit.get(context).categoriesModel!.data.data[index]),
              separatorBuilder: (context, state) => const SizedBox(
                    height: 10,
                  ),
              itemCount:
                  ShopCubit.get(context).categoriesModel!.data.data.length);
        });
  }
}

Widget catList(DataModel model) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Image(
                image: NetworkImage(model.image),
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                model.name,
                style: GoogleFonts.aladin(fontSize: 30, color: Colors.black),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
