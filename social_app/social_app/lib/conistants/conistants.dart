import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/styles/icon_broken.dart';


Widget defaultFormField({
  @required controller,
  hint = '',
  @required type,
  Function onType,
  isPassword = false,
  @required validate,
  @required prefix

}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: TextFormField(
        controller: controller,
        validator: validate,
        keyboardType: type,
        obscureText: isPassword,
        onChanged: onType,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          prefix: prefix,
        ),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  double r = 10.0,
  @required String text,
  bool isUpper = true,
  Color back = Colors.blue,
  @required Function function
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        color: back,
        borderRadius: BorderRadius.circular(
          r,
        ),
      ),
      child: ElevatedButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void showToast({
  @required String text,
  @required ToastColors color,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: setToastColor(color),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastColors {
  SUCCESS,
  ERROR,
  WARNING,
}

Color setToastColor(ToastColors color) {
  Color c;

  switch (color) {
    case ToastColors.ERROR:
      c = Colors.red;
      break;
    case ToastColors.SUCCESS:
      c = Colors.green;
      break;
    case ToastColors.WARNING:
      c = Colors.amber;
      break;
  }

  return c;
}

/*Widget buildListProduct(model, context, {bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:[ Image(image: NetworkImage(model.image),
            width: 120.0,
            height: 120.0,

          ),
            if(model.discount != 0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  height: 1.1,
                  fontSize: 14.0,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.blue,
                    ),
                  ),
                  Spacer(),
                  if(model.discount != 0 && isOldPrice)
                    Text(
                      '${model.oldPrice.round()}',
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model.id);
                      print(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favorites[model.id] ? Colors.blue : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);*/

/*void signOut(context)
{
  CashHelper.removeData(key: 'token').then((value) => (value) {
    if (value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    }
  });
}*/

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Widget defaultSeparator() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);

Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) => AppBar(
  leading: IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left_2,
      color: Colors.black,
    ),
  ),
  title: Text(
      title,
    style: TextStyle(
      color: Colors.black,
    ),
  ),
  actions: actions,
  backgroundColor: Colors.white,
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
);

String uId = '';