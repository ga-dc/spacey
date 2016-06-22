$(function(){
  $(".js-jump-to").datetimepicker({
    timepicker: false,
    onChangeDateTime: function(){
      if( !this.getValue() ) return
      window.location = "/days/" + moment(this.getValue()).format("YYYY-MM-DD") + window.location.search
    }
  })
})
