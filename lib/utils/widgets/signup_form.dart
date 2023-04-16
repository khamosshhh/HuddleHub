import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';

import '../constants/sizes.dart';
import '../constants/text_strings.dart';
import '../constants/validators.dart';
import '../controllers/signup_controller.dart';
import '../models/user_model.dart';
import '../repo/user_repository.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();

    String password = 'null';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight - 10),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Name
            TextFormField(
              controller: controller.firstName,
              decoration: const InputDecoration(
                label: Text(firstNamE),
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: emptyValidator,
            ),

            const SizedBox(height: formHeight - 20),

            // Last Name
            TextFormField(
              controller: controller.lastName,
              decoration: const InputDecoration(
                label: Text(lastNamE),
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: emptyValidator,
            ),

            const SizedBox(height: formHeight - 20),

            // Date of Birth
            TextFormField(
              controller: controller.dob,
              decoration: const InputDecoration(
                label: Text(dOb),
                prefixIcon: Icon(Icons.calendar_month_outlined),
              ),
              keyboardType: TextInputType.none,
              showCursor: false,
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
              validator: emptyValidator,
              onTap: (() async {
                DateTime? pickeddate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000, 1, 1),
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2007, 12, 31));

                if (pickeddate != null) {
                  setState(() {
                    controller.dob.text =
                        DateFormat('dd/MM/yyyy').format(pickeddate);
                  });
                }
              }),
            ),

            const SizedBox(height: formHeight - 20),

            // Email Address
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                label: Text(emaiL),
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: emailValidator,
            ),

            const SizedBox(height: formHeight - 20),

            // Phone Number
            TextFormField(
              controller: controller.phoneNo,
              decoration: const InputDecoration(
                label: Text(phoneNo),
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              validator: numberValidator,
            ),

            const SizedBox(height: formHeight - 20),

            // Password
            TextFormField(
              controller: controller.password,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text(passWord),
                prefixIcon: Icon(Icons.lock_outlined),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onChanged: (value) => password = value,
              validator: passwordValidator,
            ),

            const SizedBox(height: formHeight - 20),

            // Confirm Password
            TextFormField(
              controller: controller.passwordConfirm,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text(confPassWord),
                prefixIcon: Icon(Icons.lock_outlined),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              validator: (value) =>
                  MatchValidator(errorText: 'Passwords do not match')
                      .validateMatch(value!, password),
            ),

            const SizedBox(height: formHeight - 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Update Details in Firebase
                    UserRepository.instance.createUser(UserModel(
                        email: controller.email.text.trim(),
                        password: controller.password.text.trim(),
                        fullName:
                            "${controller.firstName.text.trim()} ${controller.lastName.text.trim()}",
                        firstName: controller.firstName.text.trim(),
                        lastName: controller.lastName.text.trim(),
                        dob: controller.dob.text.trim(),
                        phoneNo: controller.phoneNo.text.trim()));

                    // Register User
                    SignUpController.instance.registerUser(
                        context,
                        controller.email.text.trim(),
                        controller.password.text.trim());

                    //SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                    //Get.to(() => const OTPScreen());
                  }
                },
                child: Text(signUp.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
