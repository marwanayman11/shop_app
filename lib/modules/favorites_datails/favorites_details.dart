import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/homemodel.dart';

class FavoritesDetails extends StatelessWidget {
  final FavoritesProductsDataModel? model;
  const FavoritesDetails({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
            ),

            body: productDetails(context, model!),
          );
        });
  }
}
Widget productDetails(context,FavoritesProductsDataModel model)=>SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child:   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            CachedNetworkImage(imageUrl: model.image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: double.infinity,
            ),
            if (model.discount != 0)
              Container(
                  color: Colors.red,
                  child: Text(
                    'Discount',
                    style: GoogleFonts.aladin(
                        color: Colors.white, fontSize: 40),
                  )),
          ],
        ),
        SizedBox(height: 10,),
        Text('${model.name}',style: GoogleFonts.aladin(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
        SizedBox(height: 20 ,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Price: ',style: GoogleFonts.aladin(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.blue),),
            SizedBox(width: 10,),
            Text('${model.price}',style: GoogleFonts.aladin(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.blue),),
            SizedBox(width: 10,),
            if(model.discount>0)
              Text('${model.oldPrice}',style: GoogleFonts.aladin(fontWeight: FontWeight.bold,fontSize: 40,decoration: TextDecoration.lineThrough),),
          ],
        ),
        SizedBox(height: 20 ,),
        Text('${model.description}',style: GoogleFonts.aladin(fontWeight: FontWeight.bold,fontSize: 20),),
      ],
    ),
  ),
) ;
