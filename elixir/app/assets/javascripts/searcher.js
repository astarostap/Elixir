function Searcher (searchInputID, resultDivID, urlToSendGetRequest) {
	this.searchBox = document.getElementById(searchInputID);
	var obj = this;
	this.searchBox.onkeyup = function(event){
		var key = event.keyCode;
		obj.getResultsForQuery(obj);
	}
	this.resultDiv = document.getElementById(resultDivID);
	this.url = urlToSendGetRequest;
	this.xhr = new XMLHttpRequest();
	this.xhr.onreadystatechange = function(event) {
  		if (obj.xhr.readyState==4 && obj.xhr.status==200) {
    		obj.resultDiv.innerHTML = obj.xhr.responseText;
		}
  	}
}

Searcher.prototype.getResultsForQuery = function(obj) {
	var completeURL = this.url + "/" + this.searchBox.value;
	obj.xhr.open("GET", completeURL);
	obj.xhr.send();
}
