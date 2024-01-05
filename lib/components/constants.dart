RegExp emailRexExp = RegExp(r'^[\w-\.]{1,20}@[a-z\d-]{1,20}(\.[a-z]{2,4}){1,2}$');

RegExp passwordRexExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])\S{8,}$');

RegExp specialCharRexExp = RegExp(r'^(?=.*?[@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])');

RegExp israeliPhoneNumberRexExp = RegExp(r'^\+?(972|0)(\-)?0?(([23489]{1}\d{7})|[5]{1}\d{8})');

RegExp doubleRexExp = RegExp(r'^\d+\.\d+$');

String defaultAvater = 'https://banner2.cleanpng.com/20180410/bbw/kisspng-avatar-user-medicine-surgery-patient-avatar-5acc9f7a7cb983.0104600115233596105109.jpg';

List<String> workoutTypes = ['Abs', 'Arms', 'Back', 'Chest', 'FullBody', 'Glute', 'Legs', 'Shoulders'];