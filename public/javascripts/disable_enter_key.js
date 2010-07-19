function disableEnterKey(e)
{
  var key;
  if(window.event)
    key = window.event.keyCode; //IE
  else
    key = e.which; //firefox
  if(key == 13) {
    alert("กรุณาใช้เม้าส์คลิ้กที่ปุ่มเพื่อดำเนินการต่อ");
    return false; }
  else
    return true;
}