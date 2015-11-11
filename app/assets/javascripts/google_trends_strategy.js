//APP.home= {
//    index:load,
//    init:load
//}

//var load = function () {
    $(document).ready(function () {
        $('#stock_symbol').autocomplete({

            serviceUrl: '/indices/hints',
            deferRequestBy: 200
        })

        //Pie chart
        var colorArray = ["#F7464A", "#46BFBD", "#FDB45C"];
        var highLightArray = ["#FF5A5E", "#5AD3D1", "#FFC870"]
        var stockChart = $("#stockChart").get(0).getContext("2d")
        var termChart = $("#termChart").get(0).getContext("2d")

        $.ajax({
            url: '/google_trends_strategy/get_stock_search_history.json',
            async: true,
            dataType: 'json',
            type: 'get'
        }).done(function (data) {
            var stockArray = []
            $.each(data, function (index, item) {
                var hash = {}
                hash['value'] = item['count']
                hash['color'] = colorArray[index % 3]
                hash['hightlight'] = highLightArray[index % 3]
                hash['label'] = item['stock'];
                stockArray.push(hash)
            })
            if (stockArray.length > 0)
                new Chart(stockChart).Pie(stockArray)
        })

        $.ajax({
            url: '/google_trends_strategy/get_term_search_history.json',
            async: true,
            dataType: 'json',
            type: 'get'
        }).done(function (data) {
            var termArray = []
            $.each(data, function (index, item) {
                var hash = {}
                hash['value'] = item['count']
                hash['color'] = colorArray[index % 3]
                hash['hightlight'] = highLightArray[index % 3]
                hash['label'] = item['term'];
                termArray.push(hash)
            })
            if (termArray.length > 0)
                new Chart(termChart).Pie(termArray)
        })


    })
//}