import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/modules/shop_login/shop_login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
var pageController = PageController();
bool last =false;
List<BoardModel> onBoard =[
  BoardModel(title: 'Anything you need',body: 'You will find anything you need',image: 'assets/images/onboarding1.png'),
  BoardModel(title: 'Electronics',body: 'Computers,smartphones and more',image: 'assets/images/onboarding2.png'),
  BoardModel(title: 'Sports',body: 'All you need to be fit',image: 'assets/images/onboarding3.png')
];
void skipOnBoarding(){
  CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
    if(value){
    pushToAndFinish(context, ShopLogin());}
  });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [TextButton(onPressed:(){
           skipOnBoarding();
        }, child:Text('Skip',style : GoogleFonts.aladin(fontSize: 30)))],

      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Text("Welcome",style: GoogleFonts.aladin(fontSize: 80,color: Colors.black),),
            Expanded(child: PageView.builder(controller: pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index){
              if(index==onBoard.length-1){
                setState(() {
                  last=true;
                });
              }else{
                setState(() {
                  last=false;
                });
              }
              },
              itemBuilder: (context,index)=>onBoardItem(onBoard[index]),itemCount: onBoard.length,)),
            Row(children: [
              SmoothPageIndicator(count: onBoard.length,
                controller: pageController,
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  dotWidth: 10,
                  expansionFactor: 4,
                  activeDotColor: Colors.green
                ),
              ),
              const Spacer(),
              FloatingActionButton(onPressed: (){
                if(last){
                   skipOnBoarding() ;
                }else{
                  pageController.nextPage(duration:const Duration(seconds: 1), curve: Curves.fastLinearToSlowEaseIn);
                }

              },child: const Icon(Icons.arrow_forward_ios,),)
            ],)
          ],
        ),
      )
    );
  }
}
Widget onBoardItem(BoardModel model)=>Column(
  crossAxisAlignment: CrossAxisAlignment.start ,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Image(image: AssetImage(model.image),),
    const SizedBox(height: 40,),
    Text("${model.title} ",style: GoogleFonts.aladin(fontSize: 40,color: Colors.black),),
    const SizedBox(height: 20,),
    Text("${model.body} ",style: GoogleFonts.aladin(fontSize: 25,color: Colors.black))

  ],);
class BoardModel{
  late final String title;
  late final String body;
  late final String image;
  BoardModel({required this.title,required this.body,required this.image});
}

