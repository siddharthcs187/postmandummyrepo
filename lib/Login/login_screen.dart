import 'package:flutter/material.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: Scaffold(
        body: Builder(builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/loginbg.png'), fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset('assets/appstore.png'),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "BORROW",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 50),
                ),
                //font needs to be changed
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Log in to your Account",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                        onPressed: () async {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          await provider.GoogleLogin();
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                LendScreen(), // Replace with your screen
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                          Color(0xFF0A2647), // Set the background color
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/googlw.svg'),
                              Text(
                                "Login with google",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ])),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
