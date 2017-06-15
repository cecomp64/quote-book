<% cl = @mpq ? '' : 'band-' %>
<% id = @mpq ? @mpq.id : @band_name.id %>

$('.up-<%=cl%><%=id%>').each (i, obj) ->
  $(obj).html('<%= j render(partial: 'quotes/upvote', locals: {mpq: @mpq, band: @band_name, vote: @vote, value: 1}) %>')

$('.dn-<%=cl%><%=id%>').each (i, obj) ->
  $(obj).html('<%= j render(partial: 'quotes/upvote', locals: {mpq: @mpq, band: @band_name,  vote: @vote, value: -1}) %>')

$('.score-<%=cl%><%=id%>').each (i, obj) ->
  $(obj).html('<%= j render(partial: 'quotes/score', locals: {score: @score}) %>')
