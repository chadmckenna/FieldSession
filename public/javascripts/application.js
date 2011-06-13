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
	$(".notification-list").css('display', 'none');	
	$(".request").hover(function() {
		$(this).find(".delete span").fadeIn("fast").show();
	}, function() {
		$(this).find(".delete span").fadeOut("slow").hide();
		$(this).find(".subnav ul").fadeOut("fast").hide();
	});
	
	$(document).click(function() {		
		if($(event.target).is('#notifications a')) {
			$(".notification-list").fadeIn("fast");
		} else {
			$(".notification-list").fadeOut('fast');
		}
	});
	
	
	$(".delete").click(function(e) {
		e.preventDefault();
	});
	
	$(".delete").hover(function() {
		$(this).parent().find(".subnav ul").fadeIn("medium").show();
		
		$(this).parent().hover(function() {
		}, function() {
			$(this).parent().find(".subnav ul").hide();
		});
	});
	
	$("#first-name a").click(function(e) {
		e.preventDefault();
		$(this).replaceWith("<input type='text' name='user[first_name]' value='" + $(this).text() + "'/>");
	});
	
	$("#last-name a").click(function(e) {
		e.preventDefault();
		$(this).replaceWith("<input type='text' name='user[last_name]' value='" + $(this).text() + "'/>");
	});
	
	$("#username a").click(function(e) {
		e.preventDefault();
		$(this).replaceWith("<input type='text' name='user[username]' value='" + $(this).text() + "'/>");
	});
	
	$("#email a").click(function(e) {
		e.preventDefault();
		$(this).replaceWith("<input type='text' name='user[email]' value='" + $(this).text() + "'/>");
	});
	
	$("#phone a").click(function(e) {
		e.preventDefault();
		$(this).replaceWith("<input type='text' name='user[phone]' value='" + $(this).text() + "'/>");
	});
	
	$("#change-password a").click(function(e) {
		e.preventDefault();
		$(this).replaceWith("<label>New Password</label>" + "<br/>" + 
							"<input type='password' name='user[password]' />" + "<br/>" + "<br/>" + 
							"<label>New Password Confirmation</label>" + "<br/>" +
							"<input type='password' name='user[password_confirmation]' />")
	});
	
	$("#household-name a").click(function(e) {
		e.preventDefault();
		$(this).replaceWith("<input type='text' name='household[name]' value='" + $(this).text() + "'/>");
	});
	
	$("#change-photo a").click(function(e) {
		e.preventDefault();
		$(this).replaceWith('<input id="household_photo" name="household[photo]" size="30" type="file" />')
	});
	
	$(".flash.success").show('highlight', 'slow');
	$(".flash.error").show('highlight', 'slow');
	
	setTimeout(function() { 
		$(".flash.success").hide('blind', 'slow');
	}, 3000);
});





