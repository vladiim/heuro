$(document).ready ->
  $(window).scroll ->
    if $(@).scrollTop() > 10
      $('nav > .standard').addClass('hidden')
      $('nav > .email').removeClass('hidden')
    else
      $('nav > .standard').removeClass('hidden')
      $('nav > .email').addClass('hidden')
