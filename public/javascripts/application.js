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
	
	$(document).click(function(event) {		
		if($(event.target).is('#notifications a img')) {
			$(".notification-list").fadeToggle('fast');
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
	
	$("font#edit-user a").click(function(e) {
		e.preventDefault();
		$("#user-submit input").show();
		$("#change-password").show();
		$(this).parent().parent().find("#last-name").show();
		$(this).parent().parent().find("#first-name font.text").replaceWith("<input type='text' name='user[first_name]' value='" + $(this).parent().parent().find("#first-name font.text").text() + "'/>");
		$(this).parent().parent().find("#last-name font.text").replaceWith("<input type='text' name='user[last_name]' value='" + $(this).parent().parent().find("#last-name font.text").text() + "'/>");
		$("#username font.text").replaceWith("<input type='text' name='user[username]' value='" + $("#username font.text").text() + "'/>");
		$("#email font.text").replaceWith("<input type='text' name='user[email]' value='" + $("#email font.text").text() + "'/>");
		$("#phone font.text").replaceWith("<input type='text' name='user[phone]' value='" + $("#phone font.text").text() + "'/>");
		$("#work_phone font.text").replaceWith("<input type='text' name='user[work_phone]' value='" + $("#work_phone font.text").text() + "'/>");
	});
	
	$("font#edit-child a").click(function(e) {
		e.preventDefault();
		$(this).parent().parent().parent().find("#child-submit input").show();
		//Show childrens information
		$(this).parent().parent().parent().find("#first-name").show();
		$(this).parent().parent().parent().find("#last-name").show();
		$(this).parent().parent().parent().find("#DOB").show();
		$(this).parent().parent().parent().find("#allergies").show();
		$(this).parent().parent().parent().find("#medications").show();
		$(this).parent().parent().parent().find("#notes").show();
		
		//Be able to edit childrens information
		$(this).parent().parent().parent().find("#user-submit input").show();
		//$(this).parent().parent().parent().find("#show-more").show();
		$(this).parent().parent().parent().find("#first-name font.text").replaceWith("<input type='text' name='child[first_name]' value='" + $(this).parent().parent().parent().find("#first-name font.text").text() + "'/>");
		$(this).parent().parent().parent().find("#last-name font.text").replaceWith("<input type='text' name='child[last_name]' value='" + $(this).parent().parent().parent().find("#last-name font.text").text() + "'/>");
		$(this).parent().parent().parent().find("#DOB font.text").replaceWith("<input type='text' name='child[date_of_birth]' value='" + $(this).parent().parent().parent().find("#DOB font.text").text() + "'/>");
		$(this).parent().parent().parent().find("#allergies font.text").replaceWith("<input type='text' name='child[allergies]' value='" + $(this).parent().parent().parent().find("#allergies font.text").text() + "'/>");
		$(this).parent().parent().parent().find("#medications font.text").replaceWith("<input type='text' name='child[medications]' value='" + $(this).parent().parent().parent().find("#medications font.text").text() + "'/>");
		$(this).parent().parent().parent().find("#notes font.text").replaceWith("<input type='text' name='child[notes]' value='" + $(this).parent().parent().parent().find("#notes font.text").text() + "'/>");
		$(this).hide();
	});
	
	$("font#edit-address a").click(function(e) {
		e.preventDefault();
		$("#address-submit input").show();
		$("#street1 font.text").replaceWith("<input type='text' name='address[street1]' value='" + $("#street1 font.text").text() + "'/>");
		$("#street2 font.text").replaceWith("<input type='text' name='address[street2]' value='" + $("#street2 font.text").text() + "'/>");
		$("#city font.text").replaceWith("<input type='text' name='address[city]' value='" + $("#city font.text").text() + "'/>");
		$("#state font.text").replaceWith("<input type='text' name='address[state]' value='" + $("#state font.text").text() + "'/>");
		$("#zip font.text").replaceWith("<input type='text' name='address[zip]' value='" + $("#zip font.text").text() + "'/>");
	});
	

	$("font#edit-household a").click(function(e) {
		e.preventDefault();
		$("#household-name font.text").replaceWith("<input type='text' name='household[name]' value='" + $("#household-name font.text").text() + "'/>");
		$("#home-phone font.text").replaceWith("<input type='text' name='household[home_phone]' value='" + $("#home-phone font.text").text() + "'/>");
		$("#household-submit input").show();
	});
	
	$("font#edit-contacts a").click(function(e) {
		e.preventDefault();
		$("#contact-submit input").show();
		$("#name font.text").replaceWith("<input type='text' name='emergency_contact[name]' value='" + $("#name font.text").text() + "'/>");
		$("#relationship font.text").replaceWith("<input type='text' name='emergency_contact[relationship]' value='" + $("#relationship font.text").text() + "'/>");
		$("#phone_number font.text").replaceWith("<input type='text' name='emergency_contact[phone]' value='" + $("#phone_number font.text").text() + "'/>");
	});
	
	$("#change-password a").click(function(e) {
		$("#new-password").show();
		$("#password-confirmation").show();
		$(this).hide();
	});
	
	$("font#display-child a").click(function(e) {
		e.preventDefault();
		//$(this).parent().parent().parent().find("#user-submit input").show());
		$(this).parent().parent().parent().find("#first-name").show();
		$(this).parent().parent().parent().find("#last-name").show();
		$(this).parent().parent().parent().find("#DOB").show();
		$(this).parent().parent().parent().find("#allergies").show();
		$(this).parent().parent().parent().find("#medications").show();
		$(this).parent().parent().parent().find("#notes").show();
		//$(this).hide();
		//$(".tools").show();
	});
	
	$("font#hide-child a").click(function(e) {
		e.preventDefault();
		$(this).parent().parent().parent().find("#first-name").show();
		$(this).parent().parent().parent().find("#last-name").hide();
		$(this).parent().parent().parent().find("#DOB").hide();
		$(this).parent().parent().parent().find("#allergies").hide();
		$(this).parent().parent().parent().find("#medications").hide();
		$(this).parent().parent().parent().find("#notes").hide();
		//$(this).hide();
		//$(this).parent().parent().parent().parent().find("font#display-child").show();
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





