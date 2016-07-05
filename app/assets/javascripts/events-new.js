$(function(){
  var $input = $("[name='event[custom_color]']")
  var $dropdown = $("[name='event[event_type_id]']")
  if($input.val() === "#000000"){
    updateCustomColor()
  }
  $dropdown.on("change", updateCustomColor)

  function updateCustomColor(){
    var selected = $dropdown.find(":selected").text()
    var newColor = colors[selected]
    $input.val(newColor)
  }
  $startDate = $('[name="event[start_date]"]')
  $endDate = $('[name="event[end_date]"]')
  $startDate.on("change", function(){
    $endDate.val($(this).val())
  })
})
