import 'package:flutter/material.dart';

Widget defaultTextFormField(
        {required TextEditingController controller,
        bool obscureText = false,
        required TextInputType textInputType,
        String? hintText,
        Widget? prefix,
        Widget? suffix,
        FormFieldValidator<String>? validate,
        ValueChanged<String>? onSubmit,
        ValueChanged<String>? onChange,
        void Function()? onTap,
        String? labelText,
        bool readOnly = false,
        FocusNode? focusNode,
        double borderRadius = 10.0,
        TextAlign textAlign = TextAlign.start}) =>
    TextFormField(
        textAlign: textAlign,
        focusNode: focusNode,
        readOnly: readOnly,
        onFieldSubmitted: onSubmit,
        onTap: onTap,
        onChanged: onChange,
        validator: validate,
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          suffixIcon: suffix,
          prefixIcon: prefix,
        ));

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget defaultMaterialButton({
  required String title,
  required void Function()? onPressed
}) => Container(

  height: 50,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20)
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: MaterialButton(
          color: Colors.blueAccent,
          onPressed: onPressed,
          child: 
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
      
        ),
  ),
);
