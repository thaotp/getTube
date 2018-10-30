// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require bootstrap-sass/assets/javascripts/bootstrap
//= require mediaelement/build/mediaelement-and-player
//= require_tree .

var showLoading = function(){
  $('.content').hide()
  $('.loader').removeClass('hidden');
}

var hideLoading = function(){
  resetVideo();
  $('.loader').addClass('hidden');
  $('.content').show()
}

var resetVideo = function(){
  if($('video').length != 0){
    $('video, audio').mediaelementplayer();
  }
}

$(function(){

});

document.addEventListener("turbolinks:before-visit", function() {
  Turbolinks.clearCache();
})

document.addEventListener("turbolinks:load", function(event) {
  console.log("turbolinks:load")
  $('form.find-video').on('ajax:beforeSend', function(e) {
    if($('#link_url').val().length == 0){
      e.detail[0].onreadystatechange = null
      e.detail[0].abort();
      return;
    }else{
      showLoading();
    }
  });

  $('form.find-video').on('ajax:success', function(e) {
    hideLoading();
  });
  if (!event.data.timing.visitStart) {

  }else{
    resetVideo()
  }

});

document.addEventListener("turbolinks:request-start", function() {
  console.log("turbolinks:request-start")
  showLoading();
});
document.addEventListener("turbolinks:request-end", function() {
  hideLoading();
});

document.addEventListener("turbolinks:before-cache", function() {
  var video = $('video')[0]
  $('video').remove();
  $('.video').html('');
  $('.video').append(video)
  $('.loader').addClass('hidden');
})

document.addEventListener("turbolinks:before-render", function(e) {
  console.log(e)
});



