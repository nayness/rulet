
$(document).ready(function() {
  // setInterval(function() {
    $('#gambles').on('click', function(){
      $('.spinner-border').removeClass('d-none');
      var players = $('#gambles').data('players');
      var roundId = $('#new-player').data('round');
      $.ajax({
        type: 'POST',
        url: '/gamble/' + roundId ,
        data: { round: { players } },
        success: function(result) {
          $('.spinner-border').addClass('d-none');
          var players = $('.player');
          var index = 0
          var gambles = result.gambles
          players.each(function(){
            $(this).find('.bet-amount').html('$' + gambles[index].amount)
            betColor = getBetColor(gambles[index].color);
            $(this).find('.row').find('.bet-color').css('background-color', betColor);
            index +=1;
          });
          loadResult(result.round_color);
          loadRounds();
        }
      });
    });

  // }, 180000);

  function getBetColor(color){
    switch(color){
      case 'green':
        color = '#28a745';
        break;
      case 'red':
        color = '#dc3545';
        break;
      default:
        color = '#343a40';
    }
    return color;
  }

  function getRoundColor(color){
    switch(color){
      case 1:
        color = '#28a745';
        break;
      case 2:
        color = '#dc3545';
        break;
      default:
        color = '#343a40';
    }
    return color;
  }

  function loadRounds(){
    if ($('.infinity-rounds').length > 0){
      $.ajax({
        type: 'GET',
        url: '/infinite_rounds',
        success: function(result) {
          $('.infinity-rounds').append(result);
        }
      });
    }
  }

  function loadResult(color){
    var roundColor = getRoundColor(color);
    $('#round-title').html('Round Result: ');
    $('.round-result').css('background-color', roundColor);
  }

  $('#new-player').on('click', function(){
    addPlayer();
  });

  function addPlayer(){
    var roundId = $('#new-player').data('round');
    var roundPlayers = $('#new-player').data('players');
    if (roundPlayers < 6){
      $.ajax({
        type: 'GET',
        url: '/add_player/' + roundId,
        success: function(result) {
          $('#new-player').data('players', roundPlayers + 1);
          $('#round').append(result);
        }
      });
    }
    else {
      alert("You can't add more players. Round is full!");
    }
  }

  // function timer(){
  //   setInterval(function() {
  //     var timerDistance = localStorage.getItem('timerDistance');
  //     var minutes = Math.floor((timerDistance % (1000 * 60 * 60)) / (1000 * 60));
  //     var seconds = Math.floor((timerDistance % (1000 * 60)) / 1000);
  //     $('.timer').html(minutes + "m:" + seconds + "s.");
  //     localStorage.setItem('timerDistance', timerDistance - 1000);
  //     if (timerDistance == 0){
  //       localStorage.setItem('timerDistance', 180000);
  //     }
  //   }, 1000);
  // }
  // timer();
});
