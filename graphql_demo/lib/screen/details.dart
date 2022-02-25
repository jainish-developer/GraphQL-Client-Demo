import 'package:flutter/material.dart';
import 'package:graphql_demo/constants/img_font_color_string.dart';
import 'package:graphql_demo/constants/text_style_decoration.dart';
import 'package:graphql_demo/provider/api_provider.dart';
import 'package:provider/provider.dart';

class DetailView extends StatefulWidget {
  String images = "";
  String name = "";
  int index = 0;
  DetailView({this.name = "", this.images = "", this.index = 0});
  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("${widget.name}",style: TextStyleConstants.textStyle,),
        ),
        body:
            Consumer<CharacterAPIProvider>(builder: (context, provider, child) {
          return Column(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("${widget.images}"),
                          fit: BoxFit.cover),
                    ),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                  )),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${widget.name}",
                    style: TextStyleConstants.textStyle1,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  const SizedBox(height: 10),
                  const Divider(),
                  Row(
                    children: [
                      Text(Constants.gender,
                          overflow: TextStyleConstants.textover,
                          style: TextStyleConstants.textStyle),
                          SizedBox(width: 10),
                      Text(
                          "${provider.characters?.toJson()["data"]["characters"]["results"][widget.index]["gender"]}",
                          overflow: TextStyleConstants.textover,
                          style: TextStyleConstants.textStyle)
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(Constants.status,
                          overflow: TextStyleConstants.textover,
                          style: TextStyleConstants.textStyle),
                           SizedBox(width: 10),
                      Text("${provider.characters?.toJson()["data"]["characters"]["results"][widget.index]["status"]}",
                          overflow: TextStyleConstants.textover,
                          style: TextStyleConstants.textStyle)
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(Constants.species,
                          overflow: TextStyleConstants.textover,
                          style: TextStyleConstants.textStyle),
                          SizedBox(width: 10),
                      Text("${provider.characters?.toJson()["data"]["characters"]["results"][widget.index]["species"]}",
                          overflow: TextStyleConstants.textover,
                          style: TextStyleConstants.textStyle)
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(Constants.created,
                          overflow: TextStyleConstants.textover,
                          style: TextStyleConstants.textStyle),
                          SizedBox(width: 10),
                      Text("${provider.characters?.toJson()["data"]["characters"]["results"][widget.index]["created"]}",
                          overflow: TextStyleConstants.textover,
                          style: TextStyleConstants.textStyle)
                    ],
                  )
                ]),
              )
            ],
          );
        }));
  }
}
