import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var devicesize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.orange, Colors.red, Colors.deepPurple],
          )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                Container(
                  height: devicesize.height * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   height: 90,
                      //   width: 90,
                      //   child: Image.asset("assets/images/ins.png"),
                      // ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        "Insta Stores",
                        style: TextStyle(
                            fontFamily: 'Grand',
                            fontSize: 66,
                            //  fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "All your Instagram stores at one place.",
                        style: TextStyle(
                            fontFamily: 'Fredoka',
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Divider(
                //   color: Colors.white,
                // ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  //  borderRadius: BorderRadius.circular(15)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.white),
                                filled: true,
                                labelText: "Enter your email",
                                labelStyle: TextStyle(
                                    color: Colors.white, fontFamily: 'Ubuntu'),
                                fillColor: Colors.transparent),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  //  borderRadius: BorderRadius.circular(15)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                prefixIcon: Icon(Icons.password_outlined,
                                    color: Colors.white),
                                filled: true,
                                labelText: "Enter your password",
                                labelStyle: TextStyle(
                                    color: Colors.white, fontFamily: 'Ubuntu'),
                                fillColor: Colors.transparent),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(400, 50),
                                primary: Colors.black54,
                                elevation: 1),
                            onPressed: () {},
                            child: Text(
                              "SIGNUP",
                              style: TextStyle(
                                fontFamily: "Ubuntu",
                                fontSize: 18,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 1,
                                //  width: devicesize.width * 0.3,
                                color: Colors.black54,
                              ),
                              Container(
                                // color: Colors.blue,
                                child: Center(
                                  child: Text(
                                    "OR",
                                    style: TextStyle(
                                        fontFamily: "Ubuntu",
                                        fontSize: 15,
                                        color: Colors.white
                                        //fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                width: devicesize.width * 0.3,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.google,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              FaIcon(
                                FontAwesomeIcons.facebook,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              FaIcon(
                                FontAwesomeIcons.instagram,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
