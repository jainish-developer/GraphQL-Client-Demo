import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/img_font_color_string.dart';
import '../constants/text_style_decoration.dart';
import '../model/character_model.dart';

class DetailView extends StatefulWidget {
  final Result result;
  const DetailView({required this.result});
  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            widget.result.name,
            style: TextStyleConstants.textStyle,
          ),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: widget.result.image,
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const SizedBox(height: 10),
            _buildInfoView(
                Constants.gender, (widget.result.gender?.name ?? "-")),
            const Divider(),
            const SizedBox(height: 10),
            _buildInfoView(
                Constants.status, (widget.result.status?.name ?? "-")),
            const Divider(),
            const SizedBox(height: 10),
            _buildInfoView(
                Constants.species, (widget.result.species?.name ?? "-")),
            const Divider(),
            const SizedBox(height: 10),
            _buildInfoView(
                Constants.type, (widget.result.type?.name ?? "-")),
            const Divider(),
            const SizedBox(height: 10),
            _buildInfoView(Constants.created, widget.result.created.toString())
          ]),
        )
      ],
    );
  }

  Widget _buildInfoView(String label, String content) {
    return Row(
      children: [
        Expanded(
          child: Text(label,
              overflow: TextStyleConstants.textover,
              style: TextStyleConstants.textStyle),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(content,
              overflow: TextStyleConstants.textover,
              style: TextStyleConstants.textStyle),
        )
      ],
    );
  }
}
