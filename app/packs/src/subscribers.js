$(document).ready(function() {
  $('#profile').change(function(e) {
    e.preventDefault();

    $('#search-form').submit();
  });
});
