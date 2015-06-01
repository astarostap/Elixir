function showDiv(divID) {
	console.log(divID)
   if (document.getElementById(divID).style.display == "none") {
   	document.getElementById(divID).style.display = "block";
   } else {
   	document.getElementById(divID).style.display = "none"
   }
}
;
