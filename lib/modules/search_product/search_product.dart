import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/homemodel.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/search.dart';
import 'package:shop_app/modules/shop_login/shop_login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SearchDetails extends StatelessWidget {
  final SearchProductsDataModel model;
  const SearchDetails({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
            ),

            body: productDetails(context, model),
          );
        });
  }
}
Widget productDetails(context,SearchProductsDataModel model)=>SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child:   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(imageUrl: model.image,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          width: double.infinity,
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
          ],
        ),
        SizedBox(height: 20 ,),
        Text('${model.description}',style: GoogleFonts.aladin(fontWeight: FontWeight.bold,fontSize: 20),),
      ],
    ),
  ),
) ;
