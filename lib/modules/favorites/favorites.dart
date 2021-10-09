import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          if (ShopCubit.get(context).favoritesModel!.data.data1.isEmpty) {
            return Center(
                child: Text('No favorites products yet',
                    style:
                        GoogleFonts.aladin(fontSize: 40, color: Colors.black)));
          }
          if (state is ShopLoadingFavoritesDataState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => favoritesBuilder(
                    ShopCubit.get(context).favoritesModel!.data.data1[index],
                    context),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount:
                    ShopCubit.get(context).favoritesModel!.data.data1.length);
          }
        },
        listener: (context, state) {});
  }
}

Widget favoritesBuilder(FavoritesDataModel? model, context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: Colors.white,
        elevation: 10,
        child: Container(
          height: 150,
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image(
                      image: NetworkImage(model!.product.image),
                      width: 150,
                      height: 150,
                    ),
                    if (model.product.discount != 0)
                      Container(
                          color: Colors.red,
                          child: Text(
                            'Discount',
                            style: GoogleFonts.aladin(
                                color: Colors.white, fontSize: 20),
                          )),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      model.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.aladin(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.product.price}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aladin(color: Colors.blue),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (model.product.discount != 0)
                          Text(
                            '${model.product.oldPrice}',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.aladin(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavorites(model.product.id);
                            },
                            icon: CircleAvatar(
                                radius: 20,
                                backgroundColor: ShopCubit.get(context)
                                        .favorites[model.product.id]
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
            ],
          ),
        ),
      ),
    );
