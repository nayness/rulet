/* Initial setup for firstime page load */
window.onload = function () {
  var timer = localStorage.getItem("timerDistance");
  if ( timer === null || timer === "undefined" ) {
      localStorage.setItem("timerDistance", 180000);
  }
}
$(document).ready(function() {

  var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

  /* get and renders round gambles on main page*/
  function gamble(){
    $.ajax({
      type: 'POST',
      headers: { 'X_CSRF_TOKEN': AUTH_TOKEN },
      url: '/gamble',
      success: function(result) {
        var index = 0
        var gambles = result.gambles
        $('.player').each(function(){
          $(this).find('.bet-amount').html('$' + gambles[index].amount);
          betColor = getBetColor(gambles[index].color);
          $(this).find('.row').find('.bet-color').css('background-color', betColor);
          index +=1;
        });
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

  function createNewRound(){
    $.ajax({
      type: 'POST',
      headers: { 'X_CSRF_TOKEN': AUTH_TOKEN },
      url: '/new_round',
      success: function(result) {
        console.log('New Round created');
      }
    });
  }

  function loadLastRound(){
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

  function loadRoundColor(){
    $.ajax({
      type: 'GET',
      headers: { 'X_CSRF_TOKEN': AUTH_TOKEN },
      url: '/last_round',
      success: function(result) {
        var roundColor = getRoundColor(result.color);
        $('.round-result').css('background-color', roundColor);
      }
    });
  }

  function addPlayers(){
    $.ajax({
      type: 'POST',
      headers: { 'X_CSRF_TOKEN': AUTH_TOKEN },
      url: '/add_players',
      success: function(result) {
        $('#round').prepend(result);
      }
    });
  }

  function clearPreviousRound(){
    $('.round-result').css('background-color', '#FFFFFF');
    var previousRound = document.getElementById("round");
    while (previousRound.firstChild) {
      previousRound.removeChild(previousRound.firstChild);
    }
  }

  function clearWinners(){
    var winners = document.getElementById("round-rulet");
    while (winners.firstChild) {
      winners.removeChild(winners.firstChild);
    }
  }

  function loadWinners(){
    $.ajax({
      type: 'POST',
      headers: { 'X_CSRF_TOKEN': AUTH_TOKEN },
      url: '/round_winners',
      success: function(result) {
        $('#round-rulet').append(result);
      }
    });
  }

  /* start timer so it counts 3 mins*/
  function timer(){
    setInterval(function() {
      var timerDistance = localStorage.getItem('timerDistance');
      var minutes = Math.floor((timerDistance % (1000 * 60 * 60)) / (1000 * 60));
      var seconds = Math.floor((timerDistance % (1000 * 60)) / 1000);
      $('.timer').html(minutes + "m:" + seconds + "s.");
      localStorage.setItem('timerDistance', timerDistance - 1000);
      if (timerDistance == 175000){
        addPlayers();
      }
      if (timerDistance == 170000){
        $('#feedback').html("Players are gambling ...");
        $('#feedback-time').html('please wait 2 minutes');
        gamble();
      }
      if (timerDistance == 10000){
        clearPreviousRound();
        $('#feedback').html("Rulet is spining!");
        $('#feedback-time').html('please wait 5 seconds...');
        $('#rulet').removeClass('d-none');
      }
      if (timerDistance == 5000){
        $('#rulet').addClass('d-none');
        $('#feedback').html("");
        $('#feedback-time').html('');
        loadWinners();
      }
      if (timerDistance <= 0){
        localStorage.setItem('timerDistance', 180000);
        createNewRound();
        loadLastRound();
        clearWinners();
        $('#feedback').html("New round is starting!");
        $('#feedback-time').html('please wait 5 seconds');
      }
    }, 1000);
  }
  timer();
});
