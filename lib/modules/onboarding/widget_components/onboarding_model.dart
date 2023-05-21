class OnboardingModel {
  final String title;
  final String describtion;
  final String imagePath;

  OnboardingModel(this.title, this.describtion, this.imagePath);
}

List<OnboardingModel> onBoardInfo = [
  OnboardingModel(
    'Choose Product',
    'You Can Easily Find The Product You Want From Our Various Products!',
    'assets/images/i.png',
  ),
  OnboardingModel('Choose a Payment Method',
      'We Have Many Payment Methods Supported!', 'assets/images/ii.png'),
  OnboardingModel(
    'Get Your Order',
    'Open The Doors, Your Order is Now Ready For You!',
    'assets/images/iii.png',
  ),
];
