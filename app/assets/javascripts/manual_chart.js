function get_data(url){
    var response_data;
    $.ajax({
        type: "GET",
        url: url,
        async: false,
        success: function(response){
            response_data= response
        }
    });
    return response_data;
}

function get_info_chart(){
    let items = [];
    let datas  = $('#chart-datas data');
    let temp;
    datas.each(function () {
        let name = $(this).attr('name');
        let type = $(this).attr('chart-type');
        let data_link = $(this).attr('data-link');

        temp = {
            name: name,
            type: type,
            data: get_data(data_link)
        };

        items.push(temp);
    });
    return items;
}

$(document).on('turbolinks:load', function () {
    var chart_datas = $('#chart-datas');

    if(chart_datas != undefined){
        let chart_id = chart_datas.attr('chart-id');
        let chart_title = chart_datas.attr("chart-title");
        new Chartkick.LineChart(chart_id, get_info_chart(), {adapter:"highcharts", prefix: "$", messages: {empty: "Data empty!"}, title: chart_title, code: true});
    }
});
