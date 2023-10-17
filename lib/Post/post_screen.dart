import 'package:flutter/material.dart';
class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen>
    with SingleTickerProviderStateMixin {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedBorrowImage;
  File? _selectedLendImage;
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController borrowTitleController = TextEditingController();
  final TextEditingController borrowBodyController = TextEditingController();
  final TextEditingController lendTitleController = TextEditingController();
  final TextEditingController lendBodyController = TextEditingController();
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HamMenu(),
      backgroundColor: const Color(0xFF0A2647),
      appBar: AppBar(
        title: Text(
          "Post A Request",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF144272),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => ChatsList()),
              );
            },
            icon: SvgPicture.asset('assets/chats.svg'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 12, 8, 12),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF113962),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                child: TabBar(

                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  indicatorColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  controller: _tabController,
                  tabs: [
                    Tab(text: "लेन"),
                    Tab(text: "देन"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildBorrowRequestTab(),
                    _buildLendRequestTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => LendScreen()),
            );
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => BorrowScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildBorrowRequestTab() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF0A2647),
              ),
              child: TextField(
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 8,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(4.0),
                  border: InputBorder.none,
                  labelText: "Item Title (Keep it short).......",
                ),
                controller: borrowTitleController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF0A2647),
              ),
              child: TextField(
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 6,
                ),
                decoration: InputDecoration(
                  labelText: "Item Description.........",
                  contentPadding: EdgeInsets.all(4.0),
                  border: InputBorder.none,
                ),
                controller: borrowBodyController,
              ),
            ),
          ),
          SizedBox(
            height: 48,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF0A2647),
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Upload your Image',
                    style: GoogleFonts.poppins(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Maximum 100 KB image size allowed',
                    style: GoogleFonts.poppins(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.0),
                  _selectedBorrowImage != null
                      ? Image.file(
                    _selectedBorrowImage!,
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  )
                      : Column(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/cloud.svg',
                          height: 25,
                          width: 25,
                        ),
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                        },
                      ),
                      Text(
                        'Select image to upload',
                        style: GoogleFonts.poppins(
                          fontSize: 4.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'OR',
                        style: GoogleFonts.poppins(
                          fontSize: 4.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFBB400),
                        ),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/camera.svg',
                            color: Colors.white,
                            height: 25,
                            width: 25,
                          ),
                          onPressed: () {
                            _pickImage(ImageSource.camera);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF0D9393))),
            onPressed: () async {
              String? imageUrl =
              await uploadImage(_selectedBorrowImage!, user!.uid) as String;
              if (imageUrl != null) {
                postBorrowRequest(
                  title: borrowTitleController.text,
                  body: borrowBodyController.text,
                  imageUrl: imageUrl,
                  username: user!.displayName ?? "User",
                  profilePicUrl: user!.photoURL ?? "",
                  userId: user!.uid,
                );
              }
            },
            child: Text(
              "POST",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLendRequestTab() {
    String selectedRentOrSell = "Rent";
    void updateSelectedRentOrSell(String newValue) {
      setState(() {
        print('inppost screen'+newValue);
        selectedRentOrSell = newValue;
        print('changed rent/sell ='+selectedRentOrSell);
      });
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF0A2647),
              ),
              child: TextField(
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 8,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(4.0),
                  border: InputBorder.none,
                  labelText: "Item Title (Keep it short).......",
                ),
                controller: lendTitleController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFF0A2647),
              ),
              child: TextField(
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 6,
                ),
                decoration: InputDecoration(
                  labelText: "Item Description.........",
                  contentPadding: EdgeInsets.all(4.0),
                  border: InputBorder.none,
                ),
                controller: lendBodyController,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Post the item for:',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              CustomDropdownButton(onChanged: updateSelectedRentOrSell,),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF0A2647),
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Upload your Image',
                    style: GoogleFonts.poppins(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Maximum 100 KB image size allowed',
                    style: GoogleFonts.poppins(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.0),
                  _selectedLendImage != null
                      ? Image.file(
                    _selectedLendImage!,
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  )
                      : Column(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/cloud.svg',
                          height: 25,
                          width: 25,
                        ),
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                        },
                      ),
                      Text(
                        'Select image to upload',
                        style: GoogleFonts.poppins(
                          fontSize: 4.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'OR',
                        style: GoogleFonts.poppins(
                          fontSize: 4.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFBB400),
                        ),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/camera.svg',
                            color: Colors.white,
                            height: 25,
                            width: 25,
                          ),
                          onPressed: () {
                            _pickImage(ImageSource.camera);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF0D9393))),
            onPressed: () async {
              String? imageUrl =
              await uploadImage(_selectedLendImage!, user!.uid) as String;
              if (imageUrl != null) {
                postLendRequest(
                  title: lendTitleController.text,
                  body: lendBodyController.text,
                  imageUrl: imageUrl,
                  rentOrSell: selectedRentOrSell,
                  username: user!.displayName ?? "User",
                  profilePicUrl: user!.photoURL ?? "",
                  userId: user!.uid,
                );
              }
            },
            child: Text(
              "POST",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        if (_tabController?.index == 0) {
          _selectedBorrowImage = File(pickedFile.path);
        } else {
          _selectedLendImage = File(pickedFile.path);
        }
      });
    }
  }
}
