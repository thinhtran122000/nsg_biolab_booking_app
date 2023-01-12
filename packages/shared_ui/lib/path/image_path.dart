enum ImagePath {
  alertIcon('packages/shared_ui/assets/images/alert_icon.png'),
  checkIcon('packages/shared_ui/assets/images/check_icon.png'),
  eyePassClose('packages/shared_ui/assets/images/eye_pass_close.png'),

  filterIcon('packages/shared_ui/assets/images/filter_icon.png'),

  image('packages/shared_ui/assets/images/image.png'),
  infoIcon('packages/shared_ui/assets/images/info_icon.png'),
  infoIconOutline('packages/shared_ui/assets/images/info_icon_outline.png'),

  polygon1('packages/shared_ui/assets/images/polygon_1.png'),
  polygon2('packages/shared_ui/assets/images/polygon_2.png'),
  polygon3('packages/shared_ui/assets/images/polygon_3.png'),
  polygon4('packages/shared_ui/assets/images/polygon_4.png'),

  homeIconOutline('packages/shared_ui/assets/images/home_icon_outline.png'),
  homeIconFilled('packages/shared_ui/assets/images/home_icon_filled.png'),
  favoriteIconOutline('packages/shared_ui/assets/images/favorite_icon_outline.png'),
  favoriteIconFilled('packages/shared_ui/assets/images/favorite_icon_filled.png'),
  profileIconOutline('packages/shared_ui/assets/images/profile_icon_outline.png'),
  profileIconFilled('packages/shared_ui/assets/images/profile_icon_filled.png'),

  splashScreen('packages/shared_ui/assets/images/splash_screen.png'),
  noImage(
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQH0r7JbMd9Y66TYBQsdVLkEYKJBHNWHaPmeg&usqp=CAU'),
  ;

  const ImagePath(this.assetName);
  final String assetName;
}
