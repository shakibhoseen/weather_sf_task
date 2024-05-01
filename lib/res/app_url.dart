class AppUrls{
    final bool alert, aqi;
    final String location ;
    final int days;

   AppUrls({ this.alert = false, this.aqi = false,required this.location, this.days = 3});
   getUrl(){
      return 'http://api.weatherapi.com/v1/forecast.json?key=5a1303bfc0f34945bdb70135242804&q=$location&days=$days&aqi=no&alerts=no';
   }
}