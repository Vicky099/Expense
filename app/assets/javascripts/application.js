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
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery_nested_form
//= require bootstrap-datepicker
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require turbolinks
//= require_tree .


$(document).bind('page:change',function(){
  download_form();
  income_form();
  expense_record();
  category_record();
  income_category();
});

function download_form() {
	$('#download_record').validate({
		rules : {
			'record[date_from]' : {
				required : true
			},
			'record[date_to]' :{
				required : true
			}
		},
		messages : {
			'record[date_from]' : {
				required : ''
			},
			'record[date_to]' :{
				required : ''
			}
		},
		errorPlacement : function(error, element) {
			error.insertAfter(element);
		}
	});
}

function income_form() {
	$('#income_form').validate({
		rules : {
			'income[amount]' : {
				required : true
			},
			'income[date]' :{
				required : true
			},
			'income[income_category_id]' :{
				required : true
			}
		},
		messages : {
			'income[amount]' : {
				required : 'Please enter income amount'
			},
			'income[date]' :{
				required : ''
			},
			'income[income_category_id]' :{
				required : ''
			}
		},
		errorPlacement : function(error, element) {

		}
	});
}

function expense_record(){
	$('#expense_form').validate({
		rules : {
			'expense[amount]' :{
				required : true
			},
			'expense[date]':{
				required : true
			},
			'expense[expense_category_id]':{
				required : true
			}
		},
		messages : {
			'expense[amount]' :{
				required : "please enter expense amount"
			},
			'expense[date]' :{
				required : ''
			},
			'expense[expense_category_id]' :{
				required : ''
			}
		},
		errorPlacement : function(error, element) {

		}
	});
}

function category_record(){
	$('#category').validate({
		rules : {
			'expense_category[expense_source]' :{
				required : true
			},
			'expense_category[description]':{
				required : true
			}
		},
		messages : {
			'expense_category[expense_source]' :{
				required : "please enter expense category"
			},
			'expense_category[description]' :{
				required : 'please enter expense category description'
			}
		},
		errorPlacement : function(error, element) {

		}
	});
}

function income_category(){
	$('#income_category').validate({
		rules : {
			'income_category[income_source]' :{
				required : true
			},
			'income_category[description]':{
				required : true
			}
		},
		messages : {
			'income_category[income_source]' :{
				required : "please enter expense category"
			},
			'income_category[description]' :{
				required : 'please enter expense category description'
			}
		},
		errorPlacement : function(error, element) {

		}
	});
}

$(document).ready(function(){
	var checked = $("#expense_refundable").is(':checked');
	if(checked){
		$(".borrower-div").show();
	}else{
		$(".borrower-div").hide();
	}
});

$(document).on('click', '#expense_refundable', function(){
	var checked = $("#expense_refundable").is(':checked');
	if(checked){
		$(".borrower-div").show();
	}else{
		$(".borrower-div").hide();
	}
});
