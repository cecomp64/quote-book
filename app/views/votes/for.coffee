$('#up-<%=@mpq.id%>').html('<%= j render(partial: 'quotes/upvote', locals: {mpq: @mpq, vote: @vote, value: 1}) %>')
$('#dn-<%=@mpq.id%>').html('<%= j render(partial: 'quotes/upvote', locals: {mpq: @mpq, vote: @vote, value: -1}) %>')
$('#score-<%=@mpq.id%>').html('<%= j render(partial: 'quotes/score', locals: {score: @score}) %>')
