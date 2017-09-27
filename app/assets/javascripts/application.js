// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery-2.0.3.min
//= require jquery_ujs
//= require chosen.jquery
//= require bootstrap-table
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require_tree .

$(document).ready(function(){

   $('.chosen-select').chosen({
    no_results_text: 'Oops, nothing found!',
    width: '100%',
    search_contains: true
  });

  $('#item_quantity').keyup(function(){
    calculateTotalPrice();
  });

  $('#item_gst_percentage').keyup(function(){
    calculateTotalPrice();
  });

  function calculateTotalPrice(){
    item_quantity = parseFloat($('#item_quantity').val())
    item_value = parseFloat($('#unit_value').val())
    gst_percentage = parseFloat($('#item_gst_percentage').val())
    total_price = totalPriceWithGst(item_quantity, item_value, gst_percentage)
    updateTotalPrice(total_price)
  }

  function updateTotalPrice(total_price){
    if(isNaN(total_price)) {
      $('#item_value').val(0);
      $('.hidden_value').val(0);
    } else {
      $('#item_value').val(total_price);
      $('.hidden_value').val(total_price);
    }
  }

  function totalPriceWithGst(item_quantity, item_value, gst_percentage) {
    total_price = item_quantity*item_value + item_quantity*(item_value*gst_percentage/100)
    return total_price;
  }

  $('.datepicker').datepicker({
    format: 'dd/mm/yyyy',
    startDate: '01/01/2000',
    forceParse: false,
    autoclose: true,
    todayHighlight: true
  });

  $('#bootstrap-table').bootstrapTable({
    pagination: true,
    pageList: [10, 20, 50, 100, 200],
    onPageChange: function (number, size) {
      $('.payslip_attribute_value').editable();
    }
  });

});

