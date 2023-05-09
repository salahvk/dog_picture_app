import 'package:dog_picture_app/components/color_manager.dart';
import 'package:dog_picture_app/components/styles_manager.dart';
import 'package:dog_picture_app/services/dogservice.dart';
import 'package:flutter/material.dart';

class DeleteDiologueBox extends StatefulWidget {
  const DeleteDiologueBox({
    Key? key,
  }) : super(key: key);

  @override
  State<DeleteDiologueBox> createState() => _DeleteDiologueBoxState();
}

class _DeleteDiologueBoxState extends State<DeleteDiologueBox> {
  bool loading = false;

  @override
  Widget build(context) {
    final size = MediaQuery.of(context).size;

    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: SizedBox(
          height: size.height * .2,
          width: size.width * .9,
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Delete Images",
                            style: getSemiBoldtStyle(
                                color: ColorManager.black, fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            "Are you sure you want to delete all the images",
                            textAlign: TextAlign.center,
                            style: getRegularStyle(
                                color: ColorManager.black, fontSize: 16),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () async {
                                      await DogService.clearBox();
                                      Navigator.pop(context, true);
                                    },
                                    child: const Text("Yes")),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(
                                        context,
                                      );
                                    },
                                    child: const Text("No")),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: ColorManager.black,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
