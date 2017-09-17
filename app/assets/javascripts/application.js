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
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function(){

  $('#item_quantity').keyup(function(){
    calculateTotalPrice();
  });

  function calculateTotalPrice(){
    item_quantity = parseFloat($('#item_quantity').val())
    item_value = parseFloat($('#unit_value').val())
    total_price = item_quantity*item_value
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

});

