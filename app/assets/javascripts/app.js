function getNiceDate(date){
  return date.getDate() + "-" + date.getMonth() + "-" + date.getFullYear();
};

function getNicerDate(date){
  var m_names = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
  var curr_date = date.getDate();
  var sup = "";
  if (curr_date == 1 || curr_date == 21 || curr_date ==31)
     {
     sup = "st";
     }
  else if (curr_date == 2 || curr_date == 22)
     {
     sup = "nd";
     }
  else if (curr_date == 3 || curr_date == 23)
     {
     sup = "rd";
     }
  else
     {
     sup = "th";
     }

  var curr_month = date.getMonth();
  var curr_year = date.getFullYear();

  return curr_date + "<SUP>" + sup + "</SUP> " + m_names[curr_month] + " " + curr_year;
}


function getNiceTime(date){
  var a_p = "";
  
  var curr_hour = date.getHours();
  if (curr_hour < 12)
     {
     a_p = "AM";
     }
  else
     {
     a_p = "PM";
     }
  if (curr_hour == 0)
     {
     curr_hour = 12;
     }
  if (curr_hour > 12)
     {
     curr_hour = curr_hour - 12;
     }

  var curr_min = date.getMinutes();

  curr_min = curr_min + "";

  if (curr_min.length == 1)
     {
     curr_min = "0" + curr_min;
     }

  return curr_hour + ":" + curr_min + " " + a_p;
};