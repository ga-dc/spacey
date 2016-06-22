$(function(){
  $(".js-jump-to").datetimepicker({
    timepicker: false,
    onChangeDateTime: function(){
      window.location = "/days/" + moment(this.getValue()).format("YYYY-MM-DD") + window.location.search
    }
  })
})
