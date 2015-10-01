HEURO_ID   = 'heuro_id'
LOCAL_HOST = 'localhost:9292'

currentHost = -> window.location.host
currentPath = -> window.location.pathname

contentCategory = -> $('meta[name="categories"]').attr('content')

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

trackPage = ->
  contentCategory = contentCategory()
  analytics.page()
  # analytics.track('Pageview', {
  #   userId: findId(),
  #   category: contentCategory,
  #   contentCategory: contentCategory
  # })

subscriptionListener = ->
  $('.subscribe-now-btn').on 'click', (event) ->
    email = $('#mce-EMAIL').val()
    analytics.track(email, 'Newsletter Subscription', {
      userId: findId(),
      category: 'Newsletter',
      action: 'Sign up',
      label: currentPath(),
      value: email,
      email: email,
    })

downloadMillennialListener = ->
  $('.download-millennial > a').on 'click', (event) ->
    value = $(@)
    analytics.track('Download millennial persona', {
      customMetric: 1,
      category: 'Blog',
      action: 'Download',
      label: value.attr('href'),
      userId: findId()
    })

trackEvents = ->
  subscriptionListener()
  downloadMillennialListener()

$(document).ready ->
  if currentHost() isnt LOCAL_HOST
    findAndSetId()
    trackPage()
    trackEvents()
