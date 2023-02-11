import 'package:TESTED/common_widgets/colors_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class HomePageShimmer extends StatelessWidget {
  const HomePageShimmer({Key? key}) : super(key: key);

  Widget _appBar() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0)),
      child: Container(
        height: 200,
        width: double.infinity,
        color: GREY_COLOR_GREY.shade100,
        child: Column(
          children: [
            SizedBox(
              height: 14,
            ),
            Expanded(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Hi, Ankit",style: TextStyle(
                        color: Colors.white,fontSize: 20
                    ),),
                  ),
                  Expanded(
                    child: Padding(
                      padding:EdgeInsets.only(bottom: 24.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Let's Test",style: TextStyle(
                              color: Colors.white,fontSize: 30
                          ),),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        // child: Row(
        //   children: [
        //     // InkWell(
        //     //   onTap: () {
        //     //     _key.currentState?.openDrawer();
        //     //   },
        //     //   child: Container(
        //     //       padding: const EdgeInsets.all(6),
        //     //       margin: const EdgeInsets.symmetric(horizontal: 10),
        //     //       decoration: const BoxDecoration(
        //     //           shape: BoxShape.circle, color: white_color),
        //     //       child: const Icon(Icons.menu)),
        //     // ),
        //     Column(
        //       children: [
        //         Text("Let's Test"),
        //         Text("make your future here")
        //       ],
        //     ),
        //     // InkWell(
        //     //   onTap: () {
        //     //     Navigator.push(context,
        //     //         MaterialPageRoute(builder: (context) => const WalletPage()));
        //     //   },
        //     //   child: Container(
        //     //       padding: const EdgeInsets.all(6),
        //     //       margin: const EdgeInsets.symmetric(horizontal: 10),
        //     //       decoration: const BoxDecoration(
        //     //           shape: BoxShape.circle, color: white_color),
        //     //       child: const Icon(Icons.account_balance_wallet_outlined)),
        //     // ),
        //   ],
        // ),
      ),
    );
  }

  Widget _courseData() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),

          staggeredTileBuilder: (int index)=>(index==0 ||index==3
              ? StaggeredTile.count(2, 2)
              : StaggeredTile.count(2, 3)
          ),
          crossAxisCount: 4,

          mainAxisSpacing: 8,
          crossAxisSpacing: 8,

          itemCount:4,
          itemBuilder: (context, i) {
            return Container(
              height: 80,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: GREY_COLOR_GREY.shade100,
                  border: Border.all(color:GREY_COLOR_GREY.shade100, width: 0.5),
                  borderRadius: BorderRadius.circular(10)),
            );
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _body() {
      return Column(
        children: [
          _appBar(),
          Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 30,
                  width: 100,
                  color: GREY_COLOR_GREY.shade100),
              const SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.only(top: 1),
                  height: 20,
                  width: 150,
                  color: GREY_COLOR_GREY.shade100),
              const SizedBox(
                height: 20,
              ),
              _courseData()
            ],
          )
        ],
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Shimmer.fromColors(
                  baseColor: GREY_COLOR_GREY.shade300,
                  highlightColor: GREY_COLOR_GREY.shade100,
                  child: _body()),
            ),
          ],
        ),
      ),
    );
  }
}

Widget title() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    height: 15,
    width: 100,
    color: Colors.white,
  );
}
