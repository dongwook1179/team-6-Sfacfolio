import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:team_7_sfacpolio/pocketbase/data.dart';
import 'package:team_7_sfacpolio/screen/community_list.dart';
import 'package:team_7_sfacpolio/screen/project.dart';
import 'package:team_7_sfacpolio/screen/search.dart';
import 'package:team_7_sfacpolio/widgets/common/bottom_nav_bar.dart';

class CommuityPage extends StatefulWidget {
  @override
  State<CommuityPage> createState() => _CommuityPageState();
}

class _CommuityPageState extends State<CommuityPage> {
  int selectedButton = -1;

  bool isLateSelected = false;
  bool isPopularSelected = false;
  bool isLikedSelected = false;
  int page_num = 0;
  Map<String, dynamic> data = {};
  bool page_load = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Load_data();
  }

  void Load_data() async {
    Map<String, dynamic> newData = await PocketBaseData().Community();
    setState(() {
      data = newData;
      page_load = true;
    });
  }

  void _showSortingOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 235,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xFFCCCCCC),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextButton('최신순', isLateSelected),
                    Divider(),
                    buildTextButton('조회순', isPopularSelected),
                    Divider(),
                    buildTextButton('좋아요순', isLikedSelected),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTextButton(String buttonText, bool isSelected) {
    return TextButton(
      onPressed: () {
        setState(() {
          switch (buttonText) {
            case '최신순':
              isLateSelected = !isLateSelected;
              break;
            case '조회순':
              isPopularSelected = !isPopularSelected;
              break;
            case '좋아요순':
              isLikedSelected = !isLikedSelected;
              break;
          }
        });
      },
      child: Row(
        children: [
          Text(
            buttonText,
            style: TextStyle(
              color: Color(0xFF020202),
              fontSize: 15,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 220),
          if (isSelected)
            Icon(
              Icons.check,
              color: Colors.black,
              size: 18,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> buttonData = [
      {'text': '전체', 'image': null},
      {'text': '스터디', 'image': null},
      {'text': '자유', 'image': null},
      {'text': '질문', 'image': null},
    ];

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        title: Container(
          width: 360,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DefaultTabController(
                length: 2,
                child: Container(
                  width: 180,
                  height: 50,
                  child: TabBar(
                    indicatorColor: Colors.black,
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: 1,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    tabs: [
                      Tab(
                        text: '커뮤니티',
                      ),
                      Tab(
                        text: '프로젝트',
                      ),
                    ],
                    onTap: (value) {
                      setState(() {
                        page_num = value;
                      });
                    },
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Search(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => Search(),
              //       ),
              //     );
              //   },
              //   icon: Icon(
              //     Icons.search,
              //     size: 24,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: page_num == 0
          ? page_load
              ? Container(
                  width: 360,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children:
                                    List.generate(buttonData.length, (index) {
                                  // double buttonWidth =
                                  //     buttonData[index]['text'].length * 25.0;
                                  return Container(
                                    width: 48,
                                    height: 32,
                                    margin: EdgeInsets.all(5),
                                    child: OutlinedButton(
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              buttonData[index]['text'],
                                              style: TextStyle(
                                                color: selectedButton == index
                                                    ? Color(0xFF0059FF)
                                                    : Color(0xFF7F7F7F),
                                                fontSize: 12,
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.all(5),
                                          side: BorderSide(
                                            width: 1,
                                            color: Color(0xFFB3B3B3),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        )),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Text(
                              '${data.length}개의 최신글',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '최신순',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _showSortingOptionsModal(context);
                              },
                              icon: Icon(
                                Icons.expand_more,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: InfiniteScrollPage(data)),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF0059FF),
                  ),
                )
          : Project(),
    );
  }
}
