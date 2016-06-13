$(document).ready(function() {
  var lang = $('html').attr('lang');
  var format = (lang == 'pt-BR') ? 'dd/mm/yyyy' : 'mm/dd/yyyy'

  $("#certificate_initial_date").datepicker({
    language: lang,
    format: format
  });

  $("#certificate_final_date").datepicker({
    language: lang,
    format: format
  });
});
