import 'package:flutter/material.dart';
import 'package:shop_app/shared_pref.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login_Screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel(this.image, this.title, this.body);
}

class OnBaordingScreen extends StatelessWidget {
  List<BoardingModel> boardings = [
    BoardingModel(
        'assets/images/onBoarding.PNG', 'Screen title 1', 'Sceeen body 1'),
    BoardingModel(
        'assets/images/onBoarding.PNG', 'Screen title 2', 'Sceeen body 2'),
    BoardingModel(
        'assets/images/onBoarding.PNG', 'Screen title 3', 'Sceeen body 3'),
  ];
  var pageController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    void sumbit() {
      SharedPref?.putData('onBoarding', true).then((value) {
        if (value) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
          print('onBoarding saved');
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                sumbit();
              },
              child: Text(
                'SKIP  ',
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                //physics: BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (index) {
                  if (index == boardings.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
                itemBuilder: (context, index) =>
                    onBoardingItem(boardings[index]),
                itemCount: boardings.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                //SmoothPageIndicator(
                // controller : pageController ,
                // effect)

                SmoothPageIndicator(
                  controller: pageController,
                  count: boardings.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.pink,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.pink,
                  onPressed: () {
                    if (isLast) {
                      sumbit();
                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget onBoardingItem(BoardingModel model) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage("${model.image}"),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "${model.title}",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "${model.body}",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
