/* Initial setup for firstime page load */
window.onload = function () {
  if (localStorage.getItem("timerDistance") === null) {
      localStorage.setItem("timerDistance", 180000);
  }
  if (localStorage.getItem("currentRound") === null) {
    var currentRound = $('#round').data('current-round');
    localStorage.setItem("currentRound", currentRound);
  }
}
$(document).ready(function() {

  /* get and renders round gambles on main page*/
  function gamble(){
    var currentRound = localStorage.getItem('currentRound');
    $.ajax({
      type: 'POST',
      url: '/gamble/' + currentRound ,
      success: function(result) {
        var players = $('.player');
        var index = 0
        var gambles = result.gambles
        var newRoundId = result.new_round
        players.each(function(){
          $(this).find('.bet-amount').html('$' + gambles[index].amount)
          betColor = getBetColor(gambles[index].color);
          $(this).find('.row').find('.bet-color').css('background-color', betColor);
          index +=1;
        });
        displayRoundResult(result.round_color);
        loadLastRound();
        localStorage.setItem('currentRound', newRoundId);
        clearPreviousRound();
      }
    });
  }

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

  function loadLastRound(){
    if ($('.infinity-rounds').length > 0){
      var currentRound = localStorage.getItem('currentRound');
      $.ajax({
        type: 'GET',
        url: '/infinite_rounds/' + currentRound,
        success: function(result) {
          $('.infinity-rounds').append(result);
        }
      });
    }
  }

  function displayRoundResult(color){
    var roundColor = getRoundColor(color);
    $('#round-title').html('Round Result: ');
    $('.round-result').css('background-color', roundColor);
  }

  function loadNewRound(roundId){
    $('#round-title').html('New Round: ');
    $('.round-result').css('background-color', '#E2E2E2');
    addPlayers();
  }

  function addPlayers(){
    var roundId = localStorage.getItem('currentRound');
    $.ajax({
      type: 'GET',
      url: '/add_players/' + roundId,
      success: function(result) {
        $('#round').prepend(result);
      }
    });
  }

  function clearPreviousRound(){
    var previousRound = document.getElementById("round");
    setTimeout(function(){
      while (previousRound.firstChild) {
        previousRound.removeChild(previousRound.firstChild);
      }
      loadNewRound();
    }, 3000);
  }

  /* start timer so it counts 3 mins*/
  function timer(){
    setInterval(function() {
      var timerDistance = localStorage.getItem('timerDistance');
      var minutes = Math.floor((timerDistance % (1000 * 60 * 60)) / (1000 * 60));
      var seconds = Math.floor((timerDistance % (1000 * 60)) / 1000);
      $('.timer').html(minutes + "m:" + seconds + "s.");
      localStorage.setItem('timerDistance', timerDistance - 1000);
      if (timerDistance <= 0){
        localStorage.setItem('timerDistance', 180000);
        gamble();
      }
    }, 1000);
  }
  // timer();
});
