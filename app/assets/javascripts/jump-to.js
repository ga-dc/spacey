$(function(){

  var opts = {
    timepicker: false,
    onChangeDateTime: function(){
      if( !this.getValue() ) return
      window.location = "/days/" + moment(this.getValue()).format("YYYY-MM-DD") + window.location.search
    }
  }
  var dateInUrl = window.location.pathname.match(/[0-9]{4}-[0-9]{2}-[0-9]{2}/)
  if(dateInUrl){
    opts.defaultDate = dateInUrl[0] 
  }
  $(".js-jump-to").datetimepicker(opts)
})
