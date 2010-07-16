function disableEnterKey(e)
{
  var key;
  if(window.event)
    key = window.event.keyCode; //IE
  else
    key = e.which; //firefox
  if(key == 13) {
    alert("Please click the button");
    return false; }
  else
    return true;
}