import 'package:date_place/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double sunSize = 60;
  double sunPosition = 125;
  double hillOnePosition = 150;
  double hillTwoPosition = 150;
  double hillThreePosition = 210;
  double placePosition = 210;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            hexToColor('#EC9F05'),
            hexToColor('#FF4E00'),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'SUNSET',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: Icon(Icons.menu),
        ),
        body: NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification == true) {
              setState(() {
                sunPosition -= notification.scrollDelta / 5;
                sunSize -= notification.scrollDelta / 8;
                hillOnePosition -= notification.scrollDelta / 4;
                hillTwoPosition -= notification.scrollDelta / 3;
                hillThreePosition -= notification.scrollDelta / 2.8;
                placePosition -= notification.scrollDelta / 1;
              });
            }
            // just to avoid the jittery line
            return true;
          },
          child: Stack(
            children: <Widget>[
              ParalaxWidget(
                left: MediaQuery.of(context).size.width / 2 + 30,
                position: this.sunPosition,
                image: SvgPicture.asset(
                  'assets/sun.svg',
                  width: this.sunSize,
                  color: hexToColor('#f9e6bf'),
                ),
              ),
              ParalaxWidget(
                left: 0,
                position: this.hillOnePosition,
                image: SvgPicture.asset(
                  'assets/hill1.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              ParalaxWidget(
                left: 0,
                position: this.hillTwoPosition,
                image: SvgPicture.asset(
                  'assets/hill2.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              ParalaxWidget(
                left: 0,
                position: this.hillThreePosition,
                image: SvgPicture.asset(
                  'assets/hill3.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              ParalaxWidget(
                left: 0,
                position: this.placePosition,
                image: SvgPicture.asset(
                  'assets/place.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Container(
                    height: 320,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    color: hexToColor('#64147e'),
                    child: ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Icontext(
                              icon: Icons.train,
                              iconColor: hexToColor('#e22b5a'),
                              iconSize: 20,
                              spaceBetween: 8,
                              text: 'REMOTE PLACES',
                              textColor: hexToColor('#f8e124'),
                              fontSize: 20,
                              textfontWeight: FontWeight.w400,
                              iconTopPadding: 2,
                            ),
                            Icontext(
                              icon: Icons.location_on,
                              iconColor: hexToColor('#e22b5a'),
                              iconSize: 16,
                              spaceBetween: 5,
                              text: '13',
                              textColor: hexToColor('#f8e124'),
                              fontSize: 16,
                              textfontWeight: FontWeight.bold,
                              iconTopPadding: 0,
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.white60,
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                          children: <Widget>[
                            PlaceItem(
                              address: 'SAN FRANCISCO-CALIFORNIA, USA',
                              locationName: 'HELMET ROCK',
                              description:
                                  'This place has unique atmosphere at the sunset. You can observe setting sun, lit ocean and city lights.',
                              views: 1208,
                              fav: 498,
                              comments: 643,
                            ),
                            PlaceItem(
                              locationName: 'BALDWIN HILLS',
                              address: 'lOS ANGELES-CALIFORNIA, USA',
                              description:
                                  'Want to see everything and be a part of the city? Baldwin HIlls is what you are looking for as it gives great overview on the night city and won\'t...',
                              views: 2485,
                              fav: 970,
                              comments: 681,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParalaxWidget extends StatelessWidget {
  final double position;
  final double left;
  final Widget image;

  ParalaxWidget({
    Key key,
    @required this.position,
    @required this.left,
    @required this.image,
  })  : assert(position != null),
        assert(left != null),
        assert(image != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position,
      left: left,
      child: Container(
        child: this.image,
      ),
    );
  }
}

class Icontext extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final double fontSize;
  final String text;
  final Color iconColor;
  final Color textColor;
  final FontWeight textfontWeight;
  final double spaceBetween;
  final double iconTopPadding;

  Icontext({
    @required this.icon,
    @required this.iconSize,
    @required this.text,
    @required this.iconColor,
    @required this.textColor,
    @required this.fontSize,
    @required this.textfontWeight,
    @required this.spaceBetween,
    @required this.iconTopPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: this.iconTopPadding,
          ),
          child: Icon(
            this.icon,
            color: this.iconColor,
            size: this.iconSize,
          ),
        ),
        SizedBox(
          width: this.spaceBetween,
        ),
        Text(
          '${this.text}',
          style: TextStyle(
            color: this.textColor,
            fontSize: this.fontSize,
            fontWeight: this.textfontWeight,
          ),
        ),
      ],
    );
  }
}

class PlaceItem extends StatelessWidget {
  final String locationName;
  final String address;
  final String description;
  final int views;
  final int fav;
  final int comments;

  PlaceItem({
    @required this.address,
    @required this.locationName,
    @required this.description,
    @required this.views,
    @required this.fav,
    @required this.comments,
  })  : assert(locationName != null),
        assert(address != null),
        assert(views != null),
        assert(fav != null),
        assert(comments != null),
        assert(description != null);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(5, 0, 5, 15),
      children: <Widget>[
        ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              child: Text(
                '${this.locationName}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.none),
              ),
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: hexToColor('#e22b5a'),
                  size: 16,
                ),
                Container(
                  padding: EdgeInsets.only(left: 2),
                  child: Text(
                    '${this.address}',
                    style: TextStyle(
                      color: hexToColor('#f8e124'),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            '${this.description}',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton.icon(
              padding: EdgeInsets.only(right: 0, left: 0),
              onPressed: null,
              icon: Icon(
                Icons.visibility,
                color: hexToColor('#e22b5a'),
              ),
              label: Text(
                '${this.views}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            FlatButton.icon(
              padding: EdgeInsets.only(right: 0, left: 0),
              onPressed: null,
              icon: Icon(
                Icons.favorite_border,
                color: hexToColor('#e22b5a'),
              ),
              label: Text(
                '${this.fav}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            FlatButton.icon(
              padding: EdgeInsets.only(right: 0, left: 0),
              onPressed: null,
              icon: Icon(
                Icons.chat_bubble_outline,
                color: hexToColor('#e22b5a'),
              ),
              label: Text(
                '${this.comments}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
