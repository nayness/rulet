
$(document).ready(function() {
  setInterval(function() {
    $('.spinner-border').removeClass('d-none');
    var players = $('#gambles').data('players');

    $.ajax({
      type: 'POST',
      url: '/gamble',
      data: { round: { players } },
      success: function(result) {
        $('.spinner-border').addClass('d-none');
        console.log(result);
        var bets = $('.bet');
        var index = 0
        bets.each(function(){
          $(this).html('$' + result[index])
          index +=1;
        });
      }
    });
  }, 180000);
});
