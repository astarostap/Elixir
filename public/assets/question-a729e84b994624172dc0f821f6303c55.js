var data = [
    {
        value: 300,
        color:"#F7464A",
        highlight: "#FF5A5E",
        label: "Red"
    },
    {
        value: 50,
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: "Green"
    },
    {
        value: 100,
        color: "#FDB45C",
        highlight: "#FFC870",
        label: "Yellow"
    }
];

var options = {
    legendTemplate : "<ul class=\"doughnut_legend\">" +
    					"<% for (var i=0; i<segments.length; i++){%>" +
    						"<li>" +
	    						"<span class=\"legend_span\" style=\"background-color:<%=segments[i].fillColor%>\"></span>" +
	    						"<%if(segments[i].label){%>" +
	    							"<%=segments[i].label%>" +
	    						"<%}%>" +
    						"</li>" +
    					"<%}%>" +
    				"</ul>"}

$(document).ready(function() {
	var ctx = $("#doc_canvas").get(0).getContext("2d");
	var chart = new Chart(ctx).Doughnut(data, options);
	var legend = chart.generateLegend();
	$("#doc_legend_div").append(legend);

	var ctx = $("#user_canvas").get(0).getContext("2d");
	var chart = new Chart(ctx).Doughnut(data, options);
	var legend = chart.generateLegend();
	$("#user_legend_div").append(legend);


});

function init_graphs() {
    var ctx = $("#doc_canvas").get(0).getContext("2d");
    var chart = new Chart(ctx).Doughnut(data, options);
    var legend = chart.generateLegend();
    $("#doc_legend_div").append(legend);

    var ctx = $("#user_canvas").get(0).getContext("2d");
    var chart = new Chart(ctx).Doughnut(data, options);
    var legend = chart.generateLegend();
    $("#user_legend_div").append(legend);
}

function display_doc_filters(val) {
    display_filter("doc_filter", val);
}

function display_user_filters(val) {
    display_filter("user_filter", val);
}

function display_filter(class_name, val) {
    var elems = $("." + class_name);
    for(var i = 0; i < elems.length; i++) {
        if(val == -1) {
            $(elems[i]).hide();
        } else {
            if(i != val) $(elems[i]).show();
            else  $(elems[i]).hide();
        }
    }
}

function show_add_div(index) {
    $("#add_comment_div_" + index).slideDown("slow", null);
    window.scrollBy(0, 120); //make it based on bottom of div on page
}

function hide_add_div(index) {
    $("#add_comment_div_" + index).slideUp("slow", null);
    $("#add_ta" +index).value = "";
}

function count_vote() {
    console.log("hi");
}
;
