    drawer: Drawer(
        child: Container(
          color: Colors.orange,
          padding: const EdgeInsets.only(top: 100, bottom: 10, left: 30),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      userProvider.getUser.photoUrl,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProvider.getUser.fullname,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userProvider.getUser.email,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const FeedScreen();
                      },
                    ),
                  );
                },
                leading: const Icon(Icons.newspaper),
                title: const Text(
                  'FeedScreen',
                  style: TextStyle(
                    color: Color.fromARGB(255, 47, 47, 47),
                    fontSize: 16.0,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const AddPostScreen();
                      },
                    ),
                  );
                },
                leading: const Icon(Icons.logout),
                title: const Text(
                  'Ad post',
                  style: TextStyle(
                    color: Color.fromARGB(255, 47, 47, 47),
                    fontSize: 16.0,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const SearchScreen();
                      },
                    ),
                  );
                },
                leading: const Icon(Icons.search),
                title: const Text(
                  'Search User',
                  style: TextStyle(
                    color: Color.fromARGB(255, 47, 47, 47),
                    fontSize: 16.0,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const SellScreen();
                      },
                    ),
                  );
                },
                leading: const Icon(Icons.shopping_cart),
                title: const Text(
                  'Buy a Product',
                  style: TextStyle(
                    color: Color.fromARGB(255, 47, 47, 47),
                    fontSize: 16.0,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const CartScreen();
                      },
                    ),
                  );
                },
                leading: const Icon(Icons.sell_rounded),
                title: const Text(
                  'Sell a Product',
                  style: TextStyle(
                    color: Color.fromARGB(255, 47, 47, 47),
                    fontSize: 16.0,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const MapScreen();
                      },
                    ),
                  );
                },
                leading: const Icon(Icons.map_rounded),
                title: const Text(
                  'Locate nearby Petshops',
                  style: TextStyle(
                    color: Color.fromARGB(255, 47, 47, 47),
                    fontSize: 16.0,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const BlogPage();
                      },
                    ),
                  );
                },
                leading: const Icon(Icons.message),
                title: const Text(
                  'Messaging',
                  style: TextStyle(
                    color: Color.fromARGB(255, 47, 47, 47),
                    fontSize: 16.0,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const BlogPage();
                      },
                    ),
                  );
                },
                leading: const Icon(Icons.article_sharp),
                title: const Text(
                  'Blogs',
                  style: TextStyle(
                    color: Color.fromARGB(255, 47, 47, 47),
                    fontSize: 16.0,
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
  
