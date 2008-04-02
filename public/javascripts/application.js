$(document).ready(function(){
  $('#go-button').hide();
  $('#version-select').change(function(){
    $('form#select-version').submit();
  });
})