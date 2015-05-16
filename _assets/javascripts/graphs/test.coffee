'#site-chart'

jsonCircles = [{ "x_axis": 30, "y_axis": 30, "radius": 20, "color" : "green" }, { "x_axis": 70, "y_axis": 70, "radius": 20, "color" : "purple"}, { "x_axis": 110, "y_axis": 100, "radius": 20, "color" : "red"}]

addCircles = ->
  svgContainer = d3.select("body").append("svg")
    .attr("width", 200)
    .attr("height", 200)

  circles = svgContainer.selectAll("circle")
    .data(jsonCircles)
    .enter()
    .append("circle")

  circleAttributes = circles
    .attr 'cx', (d) -> d['x_axis']
    .attr 'cy', (d) -> d['y_axis']
    .attr 'r', (d) -> d['radius']
    .attr 'fill', (d) -> d['color']

$(document).ready -> addCircles()

# CODES = ['A season of classics','Podium finish','At the movies','A Diamond in the Rough','Unbeatable','Vincent supports CYCA SOLAS','MCA ARTBAR driven by Audi turns two','Audi and MONA join forces','Audi sculpts the S8 into art','Wonderment Walk','Sydney Spectacular','Design Icons','Fast Art','Join the conversation','Vorsprung Festival','A season of classics','A season of classics','Design Icons','Vorsprung Festival','Vorsprung Festival']

# ndxDim = (ndx, dim) ->
#   ndx.dimension (d) -> d[dim]

# addDateAndVisits = (observation) ->
#   dateFormat           = d3.time.format("%Y-%m-%d")
#   datum                = {}
#   datum['date']        = dateFormat.parse(observation['date'])
#   datum['visits']      = Math.floor((Math.random() * (100000 - 3000 + 1)) + 30000);
#   datum['sports_code'] = CODES[Math.floor(Math.random() * CODES.length)]
#   datum

# processData = (data) ->
#   processedData = []
#   for observation in data
#     processedData.push(addDateAndVisits(observation))
#   processedData

# makeGraphs = (error, raw_data) ->
#   data               = processData(raw_data)
#   ndx                = crossfilter(data)
#   dateDim            = ndxDim(ndx, 'date')
#   sportsCodeDim      = ndxDim(ndx, 'sports_code')
#   minDate            = dateDim.bottom(1)[0]["date"]
#   maxDate            = dateDim.top(1)[0]["date"]
#   visitsByDate       = dateDim.group().reduceSum (d) -> d['visits']
#   visitsBySportsCode = sportsCodeDim.group()
#   siteChart          = dc.lineChart('#site-chart')
#   sportsCodeChart    = dc.rowChart("#sports-chart");

#   siteChart
#     .width(900)
#     .height(250)
#     .margins({top: 10, right: 50, bottom: 30, left: 100})
#     .dimension(dateDim)
#     .group(visitsByDate, 'Visits')
#     .x(d3.time.scale().domain([minDate, maxDate]))
#     .elasticY(true)
#     .legend(dc.legend().x(800).y(10).itemHeight(13).gap(5))

#   sportsCodeChart
#     .width(300)
#     .height(700)
#     .dimension(sportsCodeDim)
#     .group(visitsBySportsCode)
#     .xAxis().ticks(3)

# queue()
#   # .defer(d3.csv, 'data/netflix_subs.csv')
#   .defer(d3.json, '/assets/data/dates.json')
#   .await(makeGraphs)