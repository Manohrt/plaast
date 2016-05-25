// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
= require jquery
//= require pjax
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
<script type="text/javascript">
$(function () {
    $("#txtFrom").datepicker({
        numberOfMonths: 1,
        onSelect: function (selected) {
            var dt = new Date(selected);
            dt.setDate(dt.getDate() + 1);
            $("#txtTo").datepicker("option", "minDate", dt);
        }
    });
    $("#txtTo").datepicker({
        numberOfMonths: 1,
        onSelect: function (selected) {
            var dt = new Date(selected);
            dt.setDate(dt.getDate() - 1);
            $("#txtFrom").datepicker("option", "maxDate", dt);
        }
    });
});
</script>
<script>
    function sum() {
      var txtFirstNumberValue = document.getElementById('txt1').value;
      var txtSecondNumberValue = document.getElementById('txt2').value;
      var txtThreeNumberValue = document.getElementById('txt3').value;
      var result = parseFloat(txtFirstNumberValue) * parseFloat(txtSecondNumberValue);
     var result1 =  parseFloat(txtFirstNumberValue) * parseFloat(txtSecondNumberValue) * parseFloat(txtThreeNumberValue);
          if (!isNaN(result))  {
         document.getElementById('txt4').value = result;
     }
             if (!isNaN(result1))  {
      document.getElementById('txt5').value = result1;
}
}
</script>

