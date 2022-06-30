import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_together/utils/constants.dart';
import 'package:map_together/widget/text_field_tags.dart';
import 'package:map_together/widget/text_field_tags_controller.dart';

class TagField extends StatelessWidget {

  final TextfieldTagsController tagsController;
  final Function(String)? onTagDelete;

  TagField({
    required this.tagsController,
    this.onTagDelete
  });
  
  @override
  Widget build(BuildContext context) {
    return TextFieldTags(
      validator: (tag) {
        if((tagsController.getTags ?? []).contains(tag)) {
          return '이미 존재하는 태그입니다.';
        }
        return null;
      },
      textfieldTagsController: tagsController,
      textSeparators: [' ', ','],
      inputfieldBuilder: (BuildContext context, TextEditingController controller, FocusNode focusNode, String? error, Function(String)? onChanged, Function(String)? onSubmitted) {
        return (BuildContext context, ScrollController scrollController, List<String> tags, Function(String) onDeleteTag) {
          return TextField(
            maxLength: 10,
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              counterText: '',
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: MtColor.paleGrey
                  )
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: MtColor.paleGrey
                  )
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: MtColor.signature
                  )
                ),
              hintText: tagsController.hasTags ? '' : '태그 추가',
              hintStyle: TextStyle(
                color: MtColor.grey
              ),
              errorText: error,
              prefixIconConstraints: BoxConstraints(maxWidth: Get.width * 0.75),
              prefixIcon: tags.isNotEmpty ? NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: tags.map(
                      (String tag) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: MtColor.signature
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16
                                  ),
                                ),
                                onTap: () {print("$tag selected");},
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                child: Icon(
                                  Icons.cancel,
                                  size: 20,
                                  color: MtColor.white
                                ),
                                onTap: () {
                                  onDeleteTag(tag);
                                  if(onTagDelete != null) onTagDelete!(tag);
                                },
                              )
                            ],
                          ),
                        );
                      }
                    ).toList()
                  ),
                ),
              )
            : null,
            ),
            onChanged: onChanged,
            onSubmitted: onSubmitted,
          );
        };
      }
    );
  }
}