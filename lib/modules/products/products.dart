import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/homemodel.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          if (ShopCubit.get(context).homeModel == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return productsBuilder(ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel, context);
          }
        },
        listener: (context, state) {});
  }
}

Widget productsBuilder(HomeModel? model, CategoriesModel? model1, context) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model!.data.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                initialPage: 0,
                height: 200,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Categories',
              style: GoogleFonts.aladin(fontSize: 40, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    categoriesBuilder(model1!.data.data[index]),
                separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                itemCount: model1!.data.data.length),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'New products',
              style: GoogleFonts.aladin(fontSize: 40, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.count(
              childAspectRatio: 1 / 1.55,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                  model.data.products.length,
                  (index) =>
                      gridProductsBuilder(model.data.products[index], context)),
            ),
          )
        ],
      ),
    );
Widget gridProductsBuilder(ProductsDataModel model, context) => Card(
      color: Colors.white,
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                      color: Colors.red,
                      child: Text(
                        'Discount',
                        style: GoogleFonts.aladin(
                            color: Colors.white, fontSize: 20),
                      )),
              ],
            ),
            Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.aladin(color: Colors.black),
            ),
            Row(
              children: [
                Text(
                  '${model.price}',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.aladin(color: Colors.blue),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (model.discount != 0)
                  Text(
                    '${model.oldPrice}',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.aladin(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            ShopCubit.get(context).favorites[model.id]
                                ? Colors.green
                                : Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        )))
              ],
            ),
          ],
        ),
      ),
    );
Widget categoriesBuilder(DataModel model) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          fit: BoxFit.cover,
          width: 150,
          height: 150,
        ),
        Container(
            width: 150,
            color: Colors.black.withOpacity(0.6),
            child: Text(
              model.name,
              style: GoogleFonts.aladin(color: Colors.white, fontSize: 20),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ))
      ],
    );
