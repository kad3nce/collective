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
  
  // Rounded Corners. Modify width and margin-top to compensate for
  // layout changes caused by corner()
  $('#content')
    .corner()
    // =====================================================================
    // = TODO: Use cssDelta to add 2.1% of width instead of overwriting it =
    // =====================================================================
    .css('width', '72.1%')
    // =====================================================================
    // = TODO: Use cssDelta to add 8px of margin instead of overwriting it =
    // =====================================================================
    .css('margin-top', '8px');
});