// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function(){
  var $createEventButton = $('.js-is-not-available')
  $(".datetimepicker").datetimepicker();
  $createEventButton.hide();
  $(".js-check-availability").on("click", function(e){
    e.preventDefault();
    var spaceId = $("[name='event[space_id]']").val()
    var start_date = $("[name='event[start_date]']").val()
    var end_date = $("[name='event[end_date]']").val()
    console.log(spaceId, start_date, end_date)
    var url = "/events/check_availability?space_id=" + spaceId + "&start_date=" + start_date + "&end_date=" + end_date; 
    $(this).addClass('loading')
    $.getJSON(url, function(response){
      console.log(response)
      if(response === true){
	$createEventButton.show();
      } else {
	$createEventButton.hide();
      }
    })
  })

  $("input[type='color']").on("change", function(e){
    console.log($(e.target).val()) 
    $color = $(e.target)
    var id = $color.attr('id')
    var color = $color.val()
    $.ajax({
      method:'patch',
      url:'/event_types/' + id,
      data: { color: color }
    })
  })
})


