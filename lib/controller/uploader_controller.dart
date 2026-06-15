// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// class UploaderController extends GetxController {
//   final ImagePicker _picker = ImagePicker();

//   var imageOne = Rxn<File>();
//   var imageTwo = Rxn<File>();
//   var imageThree = Rxn<File>();
//   var imageFour = Rxn<File>();
//   var logo = Rxn<File>();
//   var cover = Rxn<File>();

//   RxList<String> _images = <String>[].obs;

//   List<String> get images => _images;

//   set setImages(String newValue) {
//     _images.add(newValue);
//   }
//   RxString _imageOneUrl = ''.obs;
//   RxString _imageTwoUrl = ''.obs;
//   RxString _imageThreeUrl = ''.obs;
//   RxString _imageFourUrl = ''.obs;
//   RxString _logoUrl = ''.obs;
//   RxString _coverUrl = ''.obs;

//   String get imageOneUrl => _imageOneUrl.value;

//   String get imageTwoUrl => _imageTwoUrl.value;

//   String get imageThreeUrl => _imageThreeUrl.value;

//   String get imageFourUrl => _imageFourUrl.value;

//   String get logoUrl => _logoUrl.value;

//   String get coverUrl => _coverUrl.value;

//   set setLogoUrl(String newValue) {
//     _logoUrl.value = newValue;
//     images.add(newValue);
//   }

//    set setCoverUrl(String newValue) {
//     _coverUrl.value = newValue;
//     images.add(newValue);
//   }

//   set setImageOneUrl(String newValue) {
//     _imageOneUrl.value = newValue;
//     images.add(newValue);
//   }

//   set setImageTwoUrl(String newValue) {
//     _imageTwoUrl.value = newValue;
//     images.add(newValue);
//   }

//   set setImageThreeUrl(String newValue) {
//     _imageThreeUrl.value = newValue;
//     images.add(newValue);
//   }

//   set setImageFourUrl(String newValue) {
//     _imageFourUrl.value = newValue;
//     images.add(newValue);
//   }

//   Future<void> pickImage(String type) async {
//     final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       if (type == "one") {
//         imageOne.value = File(pickedImage.path);
//         uploadImageToFirebase("one");
//         return;
//       } else if (type == "two") {
//         imageTwo.value = File(pickedImage.path);
//         uploadImageToFirebase("two");
//         return;
//       } else if (type == "three") {
//         imageThree.value = File(pickedImage.path);
//         uploadImageToFirebase("three");
//         return;
//       } else if (type == "four") {
//         imageFour.value = File(pickedImage.path);
//         uploadImageToFirebase("four");
//         return;
//       } else if (type == "logo") {
//         logo.value = File(pickedImage.path);
//         uploadImageToFirebase("logo");
//         return;
//       } else if (type == "cover") {
//         cover.value = File(pickedImage.path);
//         uploadImageToFirebase("cover");
//         return;
//       }
//     }
//   }

//   Future<void> uploadImageToFirebase(String type) async {
//     if (type == "one") {
//       try {
//         String filename =
//             "images/${DateTime.now().millisecondsSinceEpoch}_${imageOne.value!.path.split('/').last}";
//         TaskSnapshot snapshot = await FirebaseStorage.instance
//             .ref()
//             .child(filename)
//             .putFile(imageOne.value!);
//         setImageOneUrl = await snapshot.ref.getDownloadURL();
//         print("imageUrlOne: $imageOneUrl ");

//         // if (snapshot.state == TaskState.success) {
//         //   final String downloadUrl = await snapshot.ref.getDownloadURL();
//         // }
//       } catch (e) {
//         debugPrint(e.toString());
//       }
//     } else if (type == "two") {
//       try {
//         String filename =
//             "images/${DateTime.now().millisecondsSinceEpoch}_${imageTwo.value!.path.split('/').last}";
//         TaskSnapshot snapshot = await FirebaseStorage.instance
//             .ref()
//             .child(filename)
//             .putFile(imageTwo.value!);
//         setImageTwoUrl = await snapshot.ref.getDownloadURL();

//         // if (snapshot.state == TaskState.success) {
//         //   final String downloadUrl = await snapshot.ref.getDownloadURL();
//         // }
//       } catch (e) {
//         debugPrint(e.toString());
//       }
//     } else if (type == "three") {
//       try {
//         String filename =
//             "images/${DateTime.now().millisecondsSinceEpoch}_${imageThree.value!.path.split('/').last}";
//         TaskSnapshot snapshot = await FirebaseStorage.instance
//             .ref()
//             .child(filename)
//             .putFile(imageThree.value!);
//         setImageThreeUrl = await snapshot.ref.getDownloadURL();

//         // if (snapshot.state == TaskState.success) {
//         //   final String downloadUrl = await snapshot.ref.getDownloadURL();
//         // }
//       } catch (e) {
//         debugPrint(e.toString());
//       }
//     } else if (type == "four") {
//       try {
//         String filename =
//             "images/${DateTime.now().millisecondsSinceEpoch}_${imageFour.value!.path.split('/').last}";
//         TaskSnapshot snapshot = await FirebaseStorage.instance
//             .ref()
//             .child(filename)
//             .putFile(imageFour.value!);
//         setImageFourUrl = await snapshot.ref.getDownloadURL();

//         // if (snapshot.state == TaskState.success) {
//         //   final String downloadUrl = await snapshot.ref.getDownloadURL();
//         // }
//       } catch (e) {
//         debugPrint(e.toString());
//       }
//     } else if (type == "cover") {
//       try {
//         String filename =
//             "images/${DateTime.now().millisecondsSinceEpoch}_${cover.value!.path.split('/').last}";
//         TaskSnapshot snapshot = await FirebaseStorage.instance
//             .ref()
//             .child(filename)
//             .putFile(cover.value!);
//         setCoverUrl = await snapshot.ref.getDownloadURL();

//         // if (snapshot.state == TaskState.success) {
//         //   final String downloadUrl = await snapshot.ref.getDownloadURL();
//         // }
//       } catch (e) {
//         debugPrint(e.toString());
//       }
//     } else if (type == "logo") {
//       try {
//         String filename =
//             "images/${DateTime.now().millisecondsSinceEpoch}_${logo.value!.path.split('/').last}";
//         TaskSnapshot snapshot = await FirebaseStorage.instance
//             .ref()
//             .child(filename)
//             .putFile(logo.value!);
//         setLogoUrl = await snapshot.ref.getDownloadURL();
//         print("logo url: ${logoUrl}");

//         // if (snapshot.state == TaskState.success) {
//         //   final String downloadUrl = await snapshot.ref.getDownloadURL();
//         // }
//       } catch (e) {
//         debugPrint(e.toString());
//       }
//     }
//   }
// }

// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:http/http.dart' as http;

class UploaderController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  var imageOne = Rxn<File>();
  var imageTwo = Rxn<File>();
  var imageThree = Rxn<File>();
  var imageFour = Rxn<File>();
  var logo = Rxn<File>();
  var cover = Rxn<File>();

  RxList<String> _images = <String>[].obs;

  List<String> get images => _images;

  set setImages(String newValue) {
    _images.add(newValue);
  }

  RxString _imageOneUrl = ''.obs;
  RxString _imageTwoUrl = ''.obs;
  RxString _imageThreeUrl = ''.obs;
  RxString _imageFourUrl = ''.obs;
  RxString _logoUrl = ''.obs;
  RxString _coverUrl = ''.obs;

  String get imageOneUrl => _imageOneUrl.value;
  String get imageTwoUrl => _imageTwoUrl.value;
  String get imageThreeUrl => _imageThreeUrl.value;
  String get imageFourUrl => _imageFourUrl.value;
  String get logoUrl => _logoUrl.value;
  String get coverUrl => _coverUrl.value;

  set setLogoUrl(String newValue) {
    _logoUrl.value = newValue;
    images.add(newValue);
  }

  set setCoverUrl(String newValue) {
    _coverUrl.value = newValue;
    images.add(newValue);
  }

  set setImageOneUrl(String newValue) {
    _imageOneUrl.value = newValue;
    images.add(newValue);
  }

  set setImageTwoUrl(String newValue) {
    _imageTwoUrl.value = newValue;
    images.add(newValue);
  }

  set setImageThreeUrl(String newValue) {
    _imageThreeUrl.value = newValue;
    images.add(newValue);
  }

  set setImageFourUrl(String newValue) {
    _imageFourUrl.value = newValue;
    images.add(newValue);
  }

  Future<void> pickImage(String type) async {
    try {
      // Wrapped the picker in a try-catch to handle iOS simulator/gallery bugs safely
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        File selectedFile = File(pickedImage.path);

        // 1. Assign the local file to update your UI instantly
        if (type == "one") {
          imageOne.value = selectedFile;
        } else if (type == "two") {
          imageTwo.value = selectedFile;
        } else if (type == "three") {
          imageThree.value = selectedFile;
        } else if (type == "four") {
          imageFour.value = selectedFile;
        } else if (type == "logo") {
          logo.value = selectedFile;
        } else if (type == "cover") {
          cover.value = selectedFile;
        }

        // 2. Trigger the Cloudinary upload
        await uploadImageToCloudinary(type, selectedFile);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");

      // Optional: Show a nice message to the user instead of crashing
      Get.snackbar(
        "Image Error",
        "Could not load this image. Please try selecting a different one.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> uploadImageToCloudinary(String type, File imageFile) async {
    const String cloudName = "djp9oxojg";
    const String uploadPreset = "chopnow_images";

    try {
      Uri url =
          Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");

      var request = http.MultipartRequest("POST", url);
      request.fields['upload_preset'] = uploadPreset;
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var jsonMap = jsonDecode(responseData.body);

        String downloadUrl = jsonMap['secure_url'];
        debugPrint("Successfully uploaded $type image: $downloadUrl");

        // 3. Assign the URL to the correct variable using your custom setters
        if (type == "one") {
          setImageOneUrl = downloadUrl;
        } else if (type == "two") {
          setImageTwoUrl = downloadUrl;
        } else if (type == "three") {
          setImageThreeUrl = downloadUrl;
        } else if (type == "four") {
          setImageFourUrl = downloadUrl;
        } else if (type == "cover") {
          setCoverUrl = downloadUrl;
        } else if (type == "logo") {
          setLogoUrl = downloadUrl;
        }
      } else {
        var errorData = await http.Response.fromStream(response);
        debugPrint(
            "Cloudinary upload failed: ${response.statusCode} - ${errorData.body}");
      }
    } catch (e) {
      debugPrint("Error uploading to Cloudinary: ${e.toString()}");
    }
  }
}
