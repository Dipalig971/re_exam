import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_exam/controller/auth_controller.dart';
import 'package:re_exam/helper/auth_services.dart';

import 'home_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(

          children: [
            const Text('Create an account',style: TextStyle(fontSize: 33),),
            const Text('connect your friend today',style: TextStyle(fontSize: 18)),

             Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 50),
              child: TextField(
                controller: authController.txtUserName,
                decoration: const InputDecoration(
                  hintText:'Enter UserName',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  )
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
              child: TextField(
                controller: authController.txtEmail,
                decoration: const InputDecoration(
                    hintText:'Enter Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    )
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
              child: TextField(
                controller: authController.txtPassword,
                decoration: const InputDecoration(
                    hintText:'Enter Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    )
                ),
              ),
            ),
            const SizedBox(height: 90,),
            GestureDetector(
              onTap: () async {
                String status = await AuthServices.authServices.createAccount(authController.txtEmail.text,  authController.txtPassword.text);
               if(status=='Success')
                 {
                   Get.to(()=>HomeScreen());
                   authController.txtEmail.clear();
                   authController.txtPassword.clear();
                 }

              },
              child: Container(
                height: 60,
                width: 300,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: const Center(child: Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
