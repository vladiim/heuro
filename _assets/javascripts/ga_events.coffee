# https://developers.google.com/analytics/devguides/collection/analyticsjs/events

subscriptionListener = ->
  $('.subscribe-now-btn').on 'click', (event) ->
    email = $('#mce-EMAIL').value
    ga('send', 'event', 'button', 'click', 'subscribe now', email)

trackEvents = ->
  subscriptionListener()

$(document).ready -> trackEvents()