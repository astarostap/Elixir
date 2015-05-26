/* ----------- */
/* Global Vars */
/* ----------- */
var votes = null;

var fake_votes = {
    "doctor" : [
        {"option": 1, "specialty": "Radiology", "YIP": 10, "rating": 83},
        {"option": 1, "specialty": "Pathology", "YIP": 5, "rating": 100},
        {"option": 2, "specialty": "Pathology", "YIP": 100, "rating": 93},
        {"option": 2, "specialty": "Cardiology", "YIP": 11, "rating": 95},
        {"option": 2, "specialty": "Cardiology", "YIP": 11, "rating": 95},
        {"option": 2, "specialty": "Cardiology", "YIP": 11, "rating": 95}
    ],
    "user" : [
        {"option": 1, "age": 20, "location": "West", "gender": "F"},
        {"option": 1, "age": 30, "location": "East", "gender": "M"},
        {"option": 2, "age": 25, "location": "Midwest", "gender": "M"},
        {"option": 2, "age": 41, "location": "South", "gender": "M"},
        {"option": 2, "age": 12, "location": "Outside U.S.", "gender": "M"},
        {"option": 1, "age": 77, "location": "West", "gender": "F"},
        {"option": 1, "age": 36, "location": "West", "gender": "F"},
    ]
};

var dropdown_options = {
    "doctor": {
        "criteria": ["doc_option_filter", "doc_specialty_filter", "doc_YIP_filter", "doc_rating_filter"],
        "doc_specialty_filter": ["Radiology", "Pathology", "Cardiology", "Pulmonary Medicine", "Obstetrics/ Gynecology", "Neurology"],
        "doc_option_filter": ["Option 1", "Option 2"],
        "doc_YIP_filter": ["0-5", "6-10", "11-15", "16-20", "21+"],
        "doc_rating_filter": ["< 51", "51-60", "61-70", "71-80", "81-90", "91-100"]
    },

    "user": {
        "criteria": ["user_age_filter", "user_location_filter", "user_gender_filter", "user_option_filter"],
        "user_option_filter": ["Option 1", "Option 2"],
        "user_age_filter": ["< 18", "18-24", "25-30", "31-40", "41-50", "51+"],
        "user_gender_filter": ["Male", "Female"],
        "user_location_filter": ["Eastern U.S.", "Western U.S.", "Midwest", "South", "Outside U.S."]
    }
};

var filter_options = {
    "doctor" : {
        "criteria": -1,
        "doc_option_filter": null,
        "doc_specialty_filter": null,
        "doc_YIP_filter": null,
        "doc_rating_filter": null
    },
    "user": {
        "criteria": -1,
        "user_age_filter": null,
        "user_location_filter": null,
        "user_gender_filter": null,
        "user_option_filter": null
    }
};

var charts = {
    "doctor": null,
    "user": null
};

var chart_options = {
    legendTemplate : "<ul class=\"doughnut_legend\" align=\"left\">" +
                        "<% for (var i=0; i<segments.length; i++){%>" +
                            "<li>" +
                                "<span class=\"legend_span\" style=\"background-color:<%=segments[i].fillColor%>\"></span>" +
                                "<%if(segments[i].label){%>" +
                                    "<%=segments[i].label%>" +
                                "<%}%>" +
                            "</li>" +
                        "<%}%>" +
                    "</ul>"
};

/* ----------------- */
/* Initialization JS */
/* ----------------- */
$(document).ready(function() {
    init_graphs();
    init_option_buttons();
    init_dropdown_options();
    get_votes();
});

function init_graphs() {
    var init_data = [{
        value: 1,
        color:"gray"
    }];

    var doc_ctx = $("#doctor_canvas").get(0).getContext("2d");
    var doc_chart = new Chart(doc_ctx).Doughnut(init_data, chart_options);
    charts["doctor"] = doc_chart;

    var user_ctx = $("#user_canvas").get(0).getContext("2d");
    var user_chart = new Chart(user_ctx).Doughnut(init_data, chart_options);
    charts["user"] = user_chart;
}

function init_option_buttons() {
    $('#option1').click(function() {option_vote(1);});
    $('#option2').click(function() {option_vote(2);});
}

function init_dropdown_options() {
    add_dropdown_options("doctor");
    add_dropdown_options("user");
}

function add_dropdown_options(type) {
    for(var name in dropdown_options[type]) {
        var elem = $("#" + name);
        var options = dropdown_options[type][name];
        for(var i = 0; i < options.length; i++) {
            var new_option = "<option value='" + i + "''>" + options[i] + "</option>";
            elem.append(new_option);
        }
    }
}

/*--------------------- */
/* Voting management JS */
/*--------------------- */
function option_vote(option_num) {
    var URL = "http://localhost:3000/questions/option_vote?option=" + option_num;
    $.post(URL);
}

function get_votes() {
    var URL = "http://localhost:3000/questions/query_votes" 
    this.xhr = new XMLHttpRequest();
    this.xhr.open("GET", URL);
    this.xhr.send();
    var obj = this;

    this.xhr.onreadystatechange = function(e) {
        if(this.readyState == 4) {
            if(this.status == 200) {
                votes = JSON.parse(obj.xhr.responseText);
                votes = fake_votes;
                display_all_votes();
            }
        }
    }
}

function get_counts(arr) {
    var count1 = 0;
    var count2 = 0;
    for(var i = 0; i < arr.length; i++) {
        if(arr[i]["option"] == 1) {
            count1 += 1;
        } else {
            count2 += 1;
        }
    }
    return [count1 / arr.length, count2 / arr.length];
}

function display_all_votes() {
    display_votes("user");
    display_votes("doctor");
}

function display_votes(name) {
    var percents = get_counts(votes[name]);
    var width = $("#" + name + "_votes").width();
    var height = $("#" + name + "_votes").height();

    var widths = [percents[0] * width, percents[1] * width];
    if(widths[0] + widths[1] < width) widths[0] += 1;

    var left_div = $("#" + name + "_vote_bar_left");
    left_div.width(widths[0]).height(height);
    left_div.css("background", "green");
    left_div.css("border-top-left-radius", "5px");
    left_div.css("border-bottom-left-radius", "5px");
    $("#" + name + "_left_percent").html(Math.round(percents[0] * 100) + "%");

    var right_div = $("#" + name + "_vote_bar_right");
    right_div.width(widths[1]).height(height);
    right_div.css("background", "red");
    right_div.css("border-top-right-radius", "5px");
    right_div.css("border-bottom-right-radius", "5px");
    $("#" + name + "_right_percent").html(Math.round(percents[1] * 100) + "%");
}

/* ------------------- */
/* Chart management JS */
/* ------------------- */

/* Doc filters */
function criteria_selected(val, type) {
    if(type == "doctor"){
        display_filter("doc_filter", val);
        reset_filter_option(filter_options["doctor"], dropdown_options["doctor"]["criteria"][val - 1]);
        filter_options[type]["criteria"] = val;
        if(val == -1) reset_all_filters(type);
    }
    redraw_chart(type);
}

function filter_selected(filter_id, filter_val) {
    filter_options["doctor"][filter_id] = dropdown_options["doctor"][filter_id][filter_val];
    redraw_chart("doctor");
}

/* User filters */
function display_user_filters(val) {
    display_filter("user_filter", val);
    reset_filter_options(user_filter_options);
}

/* Both filters */
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

function reset_all_filters(type) {
    for(var i = 0; i < dropdown_options[type]["criteria"].length; i++) {
        var id = dropdown_options[type]["criteria"][i];
        reset_filter_option(filter_options[type], id);
    }
}

function reset_filter_option(options, id) {
    options[id] = null;
    $("#" + id).val(-1);
}

function redraw_chart(type) {
    var chart = charts[type];
    var colors = ["red", "green", "blue", "yellow", "teal", "black"];
    chart.segments = [];
    chart.update();
    
    var data = generate_data(type, colors);
    if(data.length == 1) {
        chart.addData(data[0]);
        $("#" + type + "_legend_div").html("");
        return;
    }
    for(var i = 0; i < data.length; i++) {
        chart.addData(data[i]);
    }
    
    var legend = chart.generateLegend();
    $("#" + type + "_legend_div").html(legend);

    if(has_no_values(data)) {
        chart.segments = [];
        chart.addData({value:1, color:"gray", label: "No users match criteria"})
    }
}

function generate_data(type, colors) {
    var criteria_num = filter_options[type]["criteria"];
    if(criteria_num == -1) {
        return [{value: 1, color: "gray"}];
    }
    var criteria_name = dropdown_options[type]["criteria"][criteria_num - 1];
    var criteria_values = dropdown_options[type][criteria_name];
    var counts = count_entries(type, criteria_values, criteria_num);

    var data = [];
    for(var i = 0; i < counts.length; i++) {
        data.push({
            value: counts[i],
            color: colors[i],
            label: criteria_values[i]
        });
    }
    return data;
}

/* ------------------ */
/* Counting Functions */
/* ------------------ */

function count_entries(type, criteria_values, criteria_num) {
    var valid_entries = filter_list(type);
    if(criteria_num == 1) {
        return count_options(valid_entries, criteria_values);
    } else if (criteria_num == 2) {
        return count_specialty(valid_entries, criteria_values);
    } else if (criteria_num == 3) {
        return count_YIP(valid_entries, criteria_values);
    } else if (criteria_num == 4) {
        return count_rating(valid_entries, criteria_values);
    }
}

function count_options(arr, options) {
    var counts = init_vec(options.length);
    for(var i = 0; i < arr.length; i++) {
        if(arr[i]["option"] == 1) {
            counts[0] += 1;
        } else {
            counts[1] += 1;
        }
    }
    return counts;
}

function count_specialty(arr, options) {
    var counts = init_vec(options.length);
    for(var ai = 0; ai < arr.length; ai++) {
        var vote = arr[ai];
        for(var oi = 0; oi < options.length; oi++) {
            if(vote["specialty"] == options[oi]) {
                counts[oi] += 1;
            }
        }
    }
    return counts;
}

function count_YIP(arr, options) {
    var counts = init_vec(options.length);
    for(var i = 0; i < arr.length; i++) {
        var YIP = arr[i]["YIP"];
        if(YIP > 21) YIP = 21;
        counts[Math.floor((YIP - 1) / 5)] += 1;
    }
    return counts;
}

function count_rating(arr, options) {
    var counts = init_vec(options.length);
    for(var i = 0; i < arr.length; i++) {
        var rating = arr[i]["rating"];
        counts[Math.floor((rating - 41) / 10)] += 1;
    }
    return counts;
}

function filter_list(type) {
    var valid_entries = []
    for(var index in votes[type]) {
        var entry = votes[type][index];
        if(valid_entry(entry, type))
            valid_entries.push(entry);
    }
    return valid_entries;
}

/* ----------------- */
/* Validity Checking */
/* ----------------- */

function valid_entry(entry, type) {
    if(type == "doctor") {
        if(valid_option(entry, type) && valid_specialty(entry, type) &&
           valid_YIP(entry, type) && valid_rating(entry, type)) {
            return true;
        }
    } else {
        if(valid_age(entry, type) && valid_location(entry, type) &&
           valid_gender(entry, type) && valid_option(entry, type)) {
            return true;
        }
    }
    return false;
}

function valid_option(entry, type) {
    var filter = (type == "doctor") ? "doc_option_filter" : "user_option_filter";
    if(filter_options[type][filter] == null ||
       filter_options[type][filter] == "Option " + entry["option"]) {
        return true;
    }
    return false;
}

function valid_specialty(entry, type) {
    if(filter_options[type]["doc_specialty_filter"] == null ||
       filter_options[type]["doc_specialty_filter"] == entry["specialty"]) {
        return true;
    }
    return false;
}

function valid_YIP(entry, type) {
    var YIP = filter_options[type]["doc_YIP_filter"];
    if(YIP == null ||
      (YIP == "0-5" && entry["YIP"] <= 5) ||
      (YIP == "6-10" && entry["YIP"] >= 6 && entry["YIP"] <= 10) ||
      (YIP == "11-15" && entry["YIP"] >= 11 && entry["YIP"] <= 15) ||
      (YIP == "16-20" && entry["YIP"] >= 16 && entry["YIP"] <= 20) ||
      (YIP == "21+" && entry["YIP"] >= 21)) {
        return true;
      }
    return false;
}

function valid_rating(entry, type) {
    var rating = filter_options[type]["doc_rating_filter"];
    if(rating == null ||
      (rating == "< 51" && entry["rating"] < 51) ||
      (rating == "51-60" && entry["rating"] >= 51 && entry["rating"] <= 60) ||
      (rating == "61-70" && entry["rating"] >= 61 && entry["rating"] <= 70) ||
      (rating == "71-80" && entry["rating"] >= 71 && entry["rating"] <= 80) ||
      (rating == "81-90" && entry["rating"] >= 81 && entry["rating"] <= 90) ||
      (rating == "91-100" && entry["rating"] >= 91)) {
        return true;
      }
    return false;
}

/* ---------------- */
/* utility function */
/* ---------------- */
function init_vec(length) {
    var vec = [];
    for(var i = 0; i < length; i++) {
        vec.push(0);
    }
    return vec;
}

function has_no_values(data) {
    for(var i = 0; i < data.length; i++) {
        if(data[i]["value"] != 0)
            return false;
    }
    return true;
}

/*
var filter_options {
    "doctor" : {
        "criteria": -1,
        "doc_option_filter": null,
        "doc_specialty_filter": null,
        "doc_YIP_filter": null,
        "doc_rating_filter": null
    },
    "user": {
        "criteria": -1,
        "user_age_filter": null,
        "user_location_filter": null,
        "user_gender_filter": null,
        "user_option_filter": null
    }
};
var dropdown_options = {
    "doctor": {
        "doc_specialty_filter": ["Internal Medicine", "Pediatrics", "Cardiologist"],
        "doc_option_filter": ["1", "2"],
        "doc_YIP_filter": ["0-5", "6-10", "11-15", "16-20", "20+"],
        "doc_rating_filter": ["< 5", "5-5.9", "6-6.9", "7-7.9", "8-8.9", "9-10"]
    },

    "user": {
        "user_option_filter": ["1", "2"],
        "user_age_filter": ["< 18", "18-24", "25-30", "31-40", "41-50", "51+"],
        "user_gender_filter": ["Male", "Female"],
        "user_location_filter": ["Eastern U.S.", "Western U.S.", "Midwest", "South", "Outside U.S."]
    }
};
*/

/*
var ctx = $("#doc_canvas").get(0).getContext("2d");
    var chart = new Chart(ctx).Doughnut(data, options);
    var legend = chart.generateLegend();
    $("#doc_legend_div").append(legend);

    var ctx = $("#user_canvas").get(0).getContext("2d");
    var chart = new Chart(ctx).Doughnut(data, options);
    var legend = chart.generateLegend();
    $("#user_legend_div").append(legend);


/* ------------------- */
/* Comments section JS */
/* ------------------- */
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