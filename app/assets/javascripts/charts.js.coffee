jQuery ($) ->
  $(document).ready ->
    if $('#stats').length

      ###
        Legend
      ###
      $('ul.legend li').each ->
        color = $(this).attr('data-color')
        $(this).find('span').css('background-color', color)
        $(this).css('color', color)


      ###
        Charts
      ###
      for chart in [ 'history_chart', 'term_chart' ]
        data = {
          labels: (key for key, values of gon[chart])
          datasets: [
            {
              fillColor: "rgba(220,220,220,0.5)",
              strokeColor: "rgba(220,220,220,1)",
              pointColor: "rgba(220,220,220,1)",
              pointStrokeColor: "#fff",
              data: (values.impressions for key, values of gon[chart])
            },
            {
              fillColor : "rgba(151,187,205,0.5)",
              strokeColor : "rgba(151,187,205,1)",
              pointColor : "rgba(151,187,205,1)",
              pointStrokeColor : "#fff",
              data : (values.conversions for key, values of gon[chart])
            }
          ]
        }

        ctx = $("##{chart}").get(0).getContext('2d')
        new Chart(ctx).Line(data)