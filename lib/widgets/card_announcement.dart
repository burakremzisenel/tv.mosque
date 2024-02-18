import 'package:auto_size_text/auto_size_text.dart';
import 'package:float_column/float_column.dart';
import 'package:flutter/material.dart';
import 'package:tv_mosque/Service/http/http_service.dart';

class AnnoCard extends StatefulWidget {
  AnnoCard({super.key,
    this.backgroundImageFilename,
    this.imageFilename,
    required this.body,
    required this.title,
    required this.maxHeight,
    required this.maxWidth,
  });

  final String? backgroundImageFilename;
  final String? imageFilename;
  final String body;
  final String title;
  final double maxHeight;
  final double maxWidth;

  @override
  State<AnnoCard> createState() => _AnnoCardState();
}

class _AnnoCardState extends State<AnnoCard> {
  @override
  Widget build(BuildContext context) {
    bool isVerticalLayout = MediaQuery.of(context).orientation == Orientation.portrait;
    double maxWidthPercentage = 1;
    EdgeInsetsDirectional imagePadding = const EdgeInsetsDirectional.only(bottom: 12);
    FCFloat fcFloat = FCFloat.start;
    int maxLinesBodyWithImg = 6;
    int maxLinesBodyWithOutImg = 12;
    if(!isVerticalLayout){
      maxWidthPercentage = 0.5;
      imagePadding = const EdgeInsetsDirectional.only(end: 12);
      fcFloat = FCFloat.left;
      maxLinesBodyWithOutImg = 28;
    }

    final scale = (((widget.maxWidth / 600.0) - 1.0) * 0.6) + 1.0;
    Widget annoWidget;
    if (widget.imageFilename != null) {
      /// image on the left side
      /// no background
      /// text on the right side
      annoWidget = FloatColumn(
          children: [
            /// Image
            Floatable(
                float: fcFloat,
                clear: FCClear.both,
                maxWidthPercentage: maxWidthPercentage,
                padding: imagePadding,
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: widget.maxHeight/2),
                    child: HttpService().fetchImageByID(
                      imageID: widget.imageFilename!
                    ),
                  ),
                )
            ),
            /// Title
            WrappableText(
                text: TextSpan(
                    text: widget.title,
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold
                    )
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                padding: const EdgeInsets.only(bottom: 5)
            ),
            /// Body
            WrappableText(
                text: TextSpan(
                    text: widget.body+((1==0)?'lkjhlkjhkj kjhlkjhl kkjhlkjh jhjkljkjh lkjh lkjh lkjh lkjh lkjhlk hlkjhlkjhkjh lkhlkh kjhkjh kjhk jhkjhk j':''),
                    style: const TextStyle(fontSize: 32)
                ),
                textAlign: TextAlign.start,
                textScaleFactor: scale,
                overflow: TextOverflow.ellipsis,
                maxLines: maxLinesBodyWithImg,
                margin: const EdgeInsets.only(left: 10)
            ),
        ]
      );
    } else {
      /// container with / without background
      annoWidget = Container(
        //height: widget.maxHeight,
        padding: const EdgeInsets.only(top: 16, left: 12, right: 12, bottom: 5),
        decoration: (widget.backgroundImageFilename != null)
            /// use background
            ? BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    HttpService().directusImgUri(widget.backgroundImageFilename),
                  ),
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                ),
              )
            : null,
        child: Column(
          children: [
            AutoSizeText(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: AutoSizeText(
                  widget.body+
                      ((1==0)?
                      'lökjlkj lkj kjh kjkjhjkhkjh kjhkj kjhkjhkj kjh kjhk jh kjhkjsdfsd fsdf sdf sdfs df sdf sdfsdfsdf sdfsdfs dfs df sdf':''),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 32
                  ),
                  //minFontSize: 16,
                  maxLines: maxLinesBodyWithOutImg,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        )
      );
    }

    return Card(
      margin: const EdgeInsets.only(top: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white70,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: annoWidget,
    );
  }
}

class FlowLayoutDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    var offsetX = 0.0;
    var offsetY = 0.0;

    for (var i = 0; i < context.childCount; i++) {
      var childSize = context.getChildSize(i);

      if (childSize != null) {
        if (offsetX + childSize.width > context.size.width) {
          offsetX = 0.0;
          offsetY += childSize.height;
        }

        context.paintChild(
          i,
          transform: Matrix4.translationValues(offsetX, offsetY, 0.0),
        );

        offsetX += childSize.width;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  bool shouldRepaint(FlowLayoutDelegate oldDelegate) {
    return false;
  }
}
