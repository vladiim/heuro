HEURO_ID   = 'heuro_id'
LOCAL_HOST = 'localhost:9292'

currentHost = -> window.location.host

currentPath = -> window.location.pathname

generateId = ->
  id = String(Math.random()).split('.')[1]
  document.cookie = "#{HEURO_ID}=#{id}"
  id

findId = ->
  regexp = /heuro_id=(.*?)(?:\s)/
  id     = regexp.exec(document.cookie)
  id     = if id is null then generateId() else id[1]
  id.replace(/;/g, '')

findAndSetId = ->
  id = findId()
  analytics.identify(id)

subscriptionListener = ->
  $('.subscribe-now-btn').on 'click', (event) ->
    analytics.track('Newsletter Subscription', {
      category: 'Newsletter',
      action: 'Sign up',
      label: currentPath(),
      value: $('#mce-EMAIL').val()
    })

trackEvents = ->
  subscriptionListener()

$(document).ready ->
  if currentHost() isnt LOCAL_HOST
    findAndSetId()
    trackEvents()