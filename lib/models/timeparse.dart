//string olarak gelen zamanı farklı formatlarda yazıya çeviren ve türkçe aylarda ekleyen bir çok fonksiyon bulunmaktadır.
//bu fonksiyonlar aşağıda sıralanmıştır.
//1. getFormattedDate
String getFormattedDate(DateTime dateTime) {
  return "${dateTime.day} ${getMonth(dateTime.month)} ${dateTime.year}";
}

//2. getFormattedDateWithDay
String getFormattedDateWithDay(DateTime dateTime) {
  return "${getDay(dateTime.weekday)}, ${dateTime.day} ${getMonth(dateTime.month)} ${dateTime.year}";
}

//3. getFormattedDateWithDayAndTime
String getFormattedDateWithDayAndTime(DateTime dateTime) {
  return "${getDay(dateTime.weekday)}, ${dateTime.day} ${getMonth(dateTime.month)} ${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
}

//4. getFormattedDateWithTime
String getFormattedDateWithTime(DateTime dateTime) {
  return "${dateTime.day} ${getMonth(dateTime.month)} ${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
}

//5. getMonth
String getMonth(int month) {
  switch (month) {
    case 1:
      return "Ocak";
    case 2:
      return "Şubat";
    case 3:
      return "Mart";
    case 4:
      return "Nisan";
    case 5:
      return "Mayıs";
    case 6:
      return "Haziran";
    case 7:
      return "Temmuz";
    case 8:
      return "Ağustos";
    case 9:
      return "Eylül";
    case 10:
      return "Ekim";
    case 11:
      return "Kasım";
    case 12:
      return "Aralık";
    default:
      return "Invalid month";
  }
}

String getDay(int day) {
  switch (day) {
    case 1:
      return "Pazartesi";
    case 2:
      return "Salı";
    case 3:
      return "Çarşamba";
    case 4:
      return "Perşembe";
    case 5:
      return "Cuma";
    case 6:
      return "Cumartesi";
    case 7:
      return "Pazar";
    default:
      return "Invalid day";
  }
}
