$(function() {
  if (window.countdownInterval) {
    clearInterval(window.countdownInterval);
  }
  if (window.sliderInterval) {
    clearInterval(window.sliderInterval); 
  }
  if (window.standingsInterval) {
    clearInterval(window.standingsInterval); 
  }

  var ICAPresentsDate = new Date(parseInt($('body').attr('data-ica_presents_begins')));
  ICAPresentsDate = ICAPresentsDate.getTime();
  var days = 0;
  var hours = 0;
  var minutes = 0;
  var seconds = 0;
  var interval = false;
  var started = true;

  function updateCountdown() {
    var now = new Date();
    now = now.getTime();
    var difference = (ICAPresentsDate - now) / 1000;
    if (difference > 0) {
      started = false;
      if (!interval) {
        window.countdownInterval = setInterval(function() {
          updateCountdown();
        }, 1000);
        interval = true;
      }

      if (difference >= 86400) {
        days = Math.floor(difference / 86400);
        difference = difference - (days * 86400);
      }
      if (difference >= 3600) {
        hours = Math.floor(difference / 3600);
        difference = difference - (hours * 3600);
      }
      if (difference >= 60) {
        minutes = Math.floor(difference / 60);
        if(minutes < 59 && minutes > 1) {
          minutes++;
        }
      }
      renderCountdown();
    }else if(!started){
        alert('ICA Presents has started, you can now vote for your favorite projects!');
        started = true;
    }
  }
  function renderCountdown() {
    $('#days').text(days);
    $('#hours').text(hours);
    $('#minutes').text(minutes);
  }
  updateCountdown();

  if ($('.bxslider').length) {
    var messages = JSON.parse($("#messages").html());
    var latest = 0;
    if (messages.length) {
      latest = messages[0]['id'];
    }
    var slider = $('.bxslider').bxSlider({
      auto: true,
      controls: false,
      pager: false
    });
    window.sliderInterval = setInterval(function() {
      if ($('.bxslider').length) {
        $.getJSON('/messages.json?latest=' + latest, function(data) {
          var items = [];
          messages = data.concat(messages);
          if ($('.bxslider').length && data.length) {
            latest = messages[0]['id'];
            $.each(messages, function(key, val) {
              items.push('<li data-id="' + val.id + '">' + val.content + '</li>');
            });
            $('.bxslider').empty().html(items.join(''));
            slider.reloadSlider();
          }
        });
      }
    }, 60000);
  }

  if ($('#standings').length) {
    window.standingsInterval = setInterval(function() {
      if ($('#standings').length) {
        Turbolinks.visit('/votes');
      }
    }, 60000);
  }

  $('.disabled').click(function() {
    return false;
  });
});