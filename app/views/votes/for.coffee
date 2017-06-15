$('.up-<%=@mpq.id%>').each (i, obj) ->
  $(obj).html('<%= j render(partial: 'quotes/upvote', locals: {mpq: @mpq, vote: @vote, value: 1}) %>')

$('.dn-<%=@mpq.id%>').each (i, obj) ->
  $(obj).html('<%= j render(partial: 'quotes/upvote', locals: {mpq: @mpq, vote: @vote, value: -1}) %>')

$('.score-<%=@mpq.id%>').each (i, obj) ->
  $(obj).html('<%= j render(partial: 'quotes/score', locals: {score: @score}) %>')
