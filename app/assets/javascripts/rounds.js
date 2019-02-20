
$(document).ready(function() {
  // setTimeout(function() {
    // $('.spinner-border').removeClass('d-none');
    // $('.spinner-border').addClass('d-none');
  // }, 2000);

  $('#gambles').on('click', function(){
    // $('.spinner-border').removeClass('d-none');
    var players = $(this).data('players');

    $.ajax({
      type: 'POST',
      url: '/gamble',
      data: { round: { players } },
      success: function(result) {
        console.log(result);
        var bets = $('.bet');
        var index = 0
        bets.each(function(){
          $(this).html('$' + result[index])
          index +=1;
        });
      }
    });
  });

});
