$(document).ready(function() {
  var lang = $('html').attr('lang');

  $("#certificate_initial_date").datepicker({
    language: lang,
    format: 'dd/mm/yyyy'
  });

  $("#certificate_final_date").datepicker({
    language: lang,
    format: 'dd/mm/yyyy'
  });
});
