$(document).ready(function(){
  $('#go-button').hide();
  $('#version-select').change(function(){
    $('form#select-version').submit();
  });
  
  $('.moderate-edit-form').submit(function(){
    $(this).find('button').fadeOut();
    $.ajax({ type: 'PUT', url: this.action });
    return false;
  });
  
  $('#edit-filters button').click(function(){
    var edits = $('li.spam, li.ham');
    edits.hide();
    if((/all/i).test($(this).text())) {
      edits.fadeIn('fast');
    } else {
      $('li.'+$(this).text().toLowerCase()).fadeIn();
    }
    return false;
  });
  
  $('#content').corner({ autoPad: false });
});