import 'package:ride_app/widgets/stars.dart';

stars({int? votes, double? rating}) {
  if (votes == 0) {
    return StarsWidget(
      numberOfStars: 0,
    );
  } else {
    double finalRate = (rating ?? 10) / (votes ?? 4);
    return StarsWidget(
      numberOfStars: finalRate.floor(),
    );
  }
}
