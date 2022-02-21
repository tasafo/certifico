require('jquery-ui/themes/base/all.css');
require('jquery-ui/ui/i18n/datepicker-pt-BR');
var datepicker = require('jquery-ui/ui/widgets/datepicker');

$(function() {
  $(".date").datepicker();
});
