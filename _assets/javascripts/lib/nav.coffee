$(window).scroll ->
  EMAIL    = 'email'
  STANDARD = 'standard'
  $NAV     = $('nav')
  if $(@).scrollTop() > 1
    $NAV.addClass(EMAIL)
    $NAV.removeClass(STANDARD)
  else
    $NAV.addClass(STANDARD)
    $NAV.removeClass(EMAIL)
