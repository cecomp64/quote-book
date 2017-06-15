# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener "turbolinks:load", (event) ->
  $('.vote').each (i,obj) ->
    $(obj).on('click', ->
      console.log('Disabling')
      #$(obj).addClass('disabled')
      $(obj).html('<div class="full">...</div>')
    )
