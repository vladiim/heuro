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
  analytics.page(
    userId: findId(),
    category: contentCategory,
    contentCategory: contentCategory)

subscriptionListener = ->
  $('.subscribe-now-btn').on 'click', (event) ->
    email = $('#mce-EMAIL').val()
    analytics.track('Newsletter Subscription', {
      userId: findId(),
      category: 'Newsletter',
      action: 'Sign up',
      label: currentPath(),
      value: email,
      email: email,
    })

trackEvents = ->
  subscriptionListener()

$(document).ready ->
  if currentHost() isnt LOCAL_HOST
    findAndSetId()
    trackPage()
    trackEvents()