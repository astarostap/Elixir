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
        {"option": 1, "age": 20, "location": "Western U.S.", "gender": "Female"},
        {"option": 1, "age": 30, "location": "Eastern U.S.", "gender": "Male"},
        {"option": 2, "age": 25, "location": "Midwest U.S.", "gender": "Male"},
        {"option": 2, "age": 41, "location": "Southern U.S.", "gender": "Male"},
        {"option": 2, "age": 12, "location": "Other", "gender": "Male"},
        {"option": 1, "age": 77, "location": "Western U.S.", "gender": "Female"},
        {"option": 1, "age": 36, "location": "Western U.S.", "gender": "Female"},
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
        "criteria": ["user_option_filter", "user_age_filter", "user_gender_filter", "user_location_filter"],
        "user_option_filter": ["Option 1", "Option 2"],
        "user_age_filter": ["< 18", "18-24", "25-30", "31-40", "41-50", "51+"],
        "user_gender_filter": ["Male", "Female"],
        "user_location_filter": ["Eastern U.S.", "Western U.S.", "Midwest U.S.", "Southern U.S.", "Other"]
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

var current_user = null;

/* ----------------- */
/* Initialization JS */
/* ----------------- */
$(document).ready(function() {
    init_graphs();
    hide_section_divs();
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

function hide_section_divs() {
    var divs = $(".section_div");
    for(var i = 0; i < divs.length; i++) {
        $(divs[i]).hide();
    }
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
    if(current_user == null) {
        alert("You must be logged in to vote.");
    } else if(already_voted()) {
        alert("You have already voted on this question.");
    } else {
        var URL = "http://localhost:3000/questions/option_vote?option=" + option_num;
        $.post(URL, function() {get_votes();});
    }
}

function get_votes() {
    var URL = "http://localhost:3000/questions/query_votes" 
    this.xhr = new XMLHttpRequest();
    this.xhr.open("GET", URL);
    var obj = this;

    this.xhr.onreadystatechange = function(e) {
        if(this.readyState == 4) {
            if(this.status == 200) {
                data = JSON.parse(obj.xhr.responseText);
                votes = data["votes"];
                current_user = data["curr"];
                display_all_votes();
            }
        }
    }

    this.xhr.send();
}

function get_counts(arr) {
    if(arr.length == 0) return [-1];
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
    
    if(percents[0] == -1) {
        var left_div = $("#" + name + "_vote_bar_left");
        left_div.width(width).height(height);
        left_div.html("<p class='centered'><strong>No Votes<strong></p>");
        return;
    }

    var left_div = $("#" + name + "_vote_bar_left");
    left_div.html("");
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

    round_opposite_corners(widths, right_div, left_div);
}

function round_opposite_corners(widths, right_div, left_div) {
    if(widths[0] == 0) {
        right_div.css("border-top-left-radius", "5px");
        right_div.css("border-bottom-left-radius", "5px");
        left_div.css("display", "none");
    } else if (widths[1] == 0) {
        left_div.css("border-top-right-radius", "5px");
        left_div.css("border-bottom-right-radius", "5px");
        right_div.css("display", "none");
    }
}

function already_voted() {
    var type = current_user["type"];
    for(var i = 0; i < votes[type].length; i++) {
        if(votes[type][i]["id"] == current_user["id"])
            return true;
    }
    return false;
}

/* ------------------- */
/* Chart management JS */
/* ------------------- */

/* Doc filters */
function criteria_selected(val, type) {
    display_filter(type + "_filter", val);
    reset_filter_option(filter_options[type], dropdown_options[type]["criteria"][val - 1]);
    filter_options[type]["criteria"] = val;
    if(val == -1) reset_all_filters(type);
    redraw_chart(type);
}

function filter_selected(filter_id, filter_val, type) {
    filter_options[type][filter_id] = dropdown_options[type][filter_id][filter_val];
    redraw_chart(type);
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
    var colors = ["green", "red", "blue", "yellow", "teal", "black"];
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

function filter_list(type) {
    var valid_entries = []
    for(var index in votes[type]) {
        var entry = votes[type][index];
        if(valid_entry(entry, type))
            valid_entries.push(entry);
    }
    return valid_entries;
}

/* ------------------ */
/* Counting Functions */
/* ------------------ */

function count_entries(type, criteria_values, criteria_num) {
    var valid_entries = filter_list(type);
    var counts = null;
    if(type == "doctor") {
        if(criteria_num == 1) {
            counts = count_options(valid_entries, criteria_values);
        } else if (criteria_num == 2) {
            counts = count_specialty(valid_entries, criteria_values);
        } else if (criteria_num == 3) {
            counts = count_YIP(valid_entries, criteria_values);
        } else if (criteria_num == 4) {
            counts = count_rating(valid_entries, criteria_values);
        }
    } else {
        if(criteria_num == 1) {
            counts = count_options(valid_entries, criteria_values);
        } else if (criteria_num == 2) {
            counts = count_age(valid_entries, criteria_values);
        } else if (criteria_num == 3) {
            counts = count_gender(valid_entries, criteria_values);
        } else if (criteria_num == 4) {
            counts = count_location(valid_entries, criteria_values);
        }
    }
    return counts;
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

function count_age(arr, options) {
    var counts = init_vec(options.length);
    for(var i = 0; i < arr.length; i++) {
        var age = arr[i]["age"];
        if(age < 18) {
            counts[0] += 1;
        } else if (age <= 24) {
            counts[1] += 1;
        } else if (age <= 30) {
            counts[2] += 1;
        } else if (age <= 40) {
            counts[3] += 1;
        } else if (age <= 50) {
            counts[4] += 1;
        } else {
            counts[5] += 1;
        }
    }
    return counts;
}

function count_gender(arr, options) {
    var counts = init_vec(options.length);
    for(var i = 0; i < arr.length; i++) {
        var gender = arr[i]["gender"];
        if(gender == "Male") {
            counts[0] += 1;
        } else {
            counts[1] += 1;
        }
    }
    return counts;
}

function count_location(arr, options) {
    var counts = init_vec(options.length);
    for(var ai = 0; ai < arr.length; ai++) {
        var loc = arr[ai]["location"];
        for(var oi = 0; oi < options.length; oi++) {
            if(loc == options[oi]) {
                counts[oi] += 1;
                break;
            }
        }
    }
    return counts;
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

function valid_age(entry, type) {
    var age = filter_options[type]["user_age_filter"];
    if(age == null ||
      (age == "< 18" && entry["age"] < 18) ||
      (age == "18-24" && entry["age"] >= 18 && entry["age"] <= 24) ||
      (age == "25-30" && entry["age"] >= 25 && entry["age"] <= 30) ||
      (age == "31-40" && entry["age"] >= 31 && entry["age"] <= 40) ||
      (age == "41-50" && entry["age"] >= 41 && entry["age"] <= 50) ||
      (age == "51+" && entry["age"] >= 51)) {
        return true;
    }
    return false;
}

function valid_location(entry, type) {
    var loc = filter_options[type]["user_location_filter"];
    if(loc == null || entry["location"] == loc) {
        return true;
    }
    return false;
}

function valid_gender(entry, type) {
    var gender = filter_options[type]["gender"];
    if(gender == null || entry["gender"] == gender) {
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

function toggleVisibility(button_id, div_id) {
    var div = $("#" + div_id);
    var button = $("#" + button_id);
    if(div.css("display") == "none") {
        div.slideDown("slow", null);
        var text = (button_id == "paper_button") ? "Hide Add Source" : "Hide " + button.text().slice(4);
        button.html(text);
    } else {
        div.slideUp("fast", null);
        var text = (button_id == "paper_button") ? "Add Source" : "Show " + button.text().slice(4);
        button.html(text);
    }
}

/* ------------------- */
/* Comments section JS */
/* ------------------- */
function show_add_div(index) {
    $("#add_comment_div_" + index).slideDown("slow", null);
    //window.scrollBy(0, 120); //make it based on bottom of div on page
}

function hide_add_div(index) {
    $("#add_comment_div_" + index).slideUp("slow", null);
    $("#add_ta" +index).value = "";
}

function add_comment(side) {
    if(current_user == null) {
        alert("You must be signed in to comment.");
        return;
    }
    var option = (side == "left") ? "1" : "2";
    var comment = $("#" + side + "_add_ta").val();
    $("#" + side + "_comment_list").append(generate_comment_html(comment));
    $("#" + side + "_add_ta").val('');
    hide_add_div(option)

    data = {
        'text': comment,
        'option': option
    };

    $.ajax({
        type: "POST",
        url: "http://localhost:3000/questions/create_comment",
        data: JSON.stringify(data),
        contentType: 'application/json', 
        error:  function(response) {
            alert("Your comment failed to save. Please try again.");
        }
    });
}

function generate_comment_html(comment) {
    return '<li class="disc_li"> \
                <div class="comment_header"> \
                    <div class="float_left" style="text-align: left;"> \
                        <img alt="Goat" class="profile_picture" src="/assets/goat.jpg" /> \
                        <p><strong>' + current_user.username + '</strong></p> \
                    </div> \
                    <div class="float_right" style="text-align: right;"> \
                        <div class="inline comment_rating"> \
                            (0) \
                        </div> \
                        <div class="inline"> \
                            <input type="image" class="sentiment_button" src="/assets/thumbs-up.jpg" onclick="count_vote();"> \
                        </div> \
                        <div class="inline"> \
                            <input type="image" class="sentiment_button" src="/assets/thumbs-down.jpg" onclick="count_vote();"> \
                        </div> \
                    </div> \
                </div> \
                <div class="comment_body"> \
                    ' + comment + ' \
                </div> \
            </li>';
}

function count_vote() {
    console.log("hi");
}