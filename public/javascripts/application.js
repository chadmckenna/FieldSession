// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
	$('#request_from_date').datepicker({minDate: '0', maxDate: '+1y', selectOtherMonths: true, showOtherMonths: true,
										onSelect: function(dateStr, inst)
										{
											var min = $(this).datepicker("getDate");
											$('#request_to_date').datepicker();
											$('#request_to_date').datepicker("option", "minDate", min);
										}});
										
	var min = $('#request_from_date').datepicker("getDate")	;		
	$('#request_to_date').datepicker({minDate: min, maxDate: '+1y', selectOtherMonths: true, showOtherMonths: true});
																				
});

$(document).ready(function() {
	$(".request").hover(function() {
		$(this).find(".delete span").fadeIn("fast").show();
	}, function() {
		$(this).find(".delete span").fadeOut("slow").hide();
		$(this).find(".subnav ul").fadeOut("fast").hide();
	});
	
	
	$(".delete").click(function(e) {
		e.preventDefault();
	});
	
	$(".delete").click(function() {
		$(this).parent().find(".subnav ul").fadeIn("medium").show();
		
		$(this).parent().hover(function() {
		}, function() {
			$(this).parent().find(".subnav ul").hide();
		});
	});
});






