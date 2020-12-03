class User1 {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User1({
    this.id,
    this.name,
    this.imageUrl,
    this.isOnline,
  });
}

// YOU - current user
final User1 currentUser = User1(
  id: 0,
  name: 'yuzhen',
  imageUrl: 'assets/images/liyan.jpg',
  isOnline: true,
);

// USERS
final User1 ironMan = User1(
  id: 1,
  name: 'liyan',
  imageUrl: 'assets/images/liyan.jpg',
  isOnline: true,
);
final User1 captainAmerica = User1(
  id: 2,
  name: 'amari',
  imageUrl: 'assets/images/amari.jpg',
  isOnline: true,
);
final User1 hulk = User1(
  id: 3,
  name: 'jasmine',
  imageUrl: 'assets/images/jasmine.jpg',
  isOnline: false,
);
final User1 scarletWitch = User1(
  id: 4,
  name: 'jiadian',
  imageUrl: 'assets/images/jiadian.jpg',
  isOnline: false,
);
final User1 spiderMan = User1(
  id: 5,
  name: 'marcus',
  imageUrl: 'assets/images/marcus.jpg',
  isOnline: true,
);
final User1 blackWindow = User1(
  id: 6,
  name: 'shuwen',
  imageUrl: 'assets/images/shuwen.jpg',
  isOnline: false,
);
final User1 thor = User1(
  id: 7,
  name: 'xy',
  imageUrl: 'assets/images/xy.jpg',
  isOnline: false,
);
final User1 captainMarvel = User1(
  id: 8,
  name: 'zy',
  imageUrl: 'assets/images/zy.jpg',
  isOnline: false,
);