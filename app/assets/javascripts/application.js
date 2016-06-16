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
//= require moment
//= require recurring_select
//= require_tree .

$(function(){
  $(".datetimepicker").datetimepicker();
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

$.fn.recurring_select.options = {
  monthly: {
    show_week: [true, true, true, true, true, true]
  }
};