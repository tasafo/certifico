$(document).ready(function() {
  $('#profile').change(function(e) {
    e.preventDefault();

    $('#profile').parent().submit();
  });
});
