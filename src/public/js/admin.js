// Send an ajax message to the server.
function updateConfigurationAjax(changeSetP, jsondata){
	var answer = confirm("Are you sure you want to commit these "+
				"changes?");
	// Only continue if answer is truthy.
	if (answer) {
		// Continue on.
	} else { return true; }
	
	$.ajax({
		type:	'POST',
		url:	'/autosistant/admin/ajax',
		data:	{
				// TODO: Login-info or something?
				changeSet:	changeSetP,
				json:		jsondata
			},
		beforeSend:function(){
			// TODO: Notify user about waiting for reply?
		},
		success:function(data){
			// AJAX request made succesfully!
			// Parse the JSON message.
			var parsed = $.parseJSON(data);
			
			// Check if changes made stayed.
			if (parsed.state == 1) {
				alert("Changes made successfully!");
			} else {
				alert("Errors occurred. The return status was: "
					+parsed.state);
			}
		},
		error:function(){
			// AJAX Request failed!
			alert('AJAX Failure: please try again!');
		}
	});
};

// Send an ajax message to the server.
function searchProducts(searchString){
	$.ajax({
		type:	'POST',
		url:	'/autosistant/admin/ajax',
		data:	{
				changeSet:	"productsearch",
				json:		searchString
			},
		beforeSend:function(){
			// TODO: Notify user about waiting for reply?
		},
		success:function(data){
			// AJAX request made succesfully!
			// Parse the JSON message.
			var parsed = $.parseJSON(data);
			
			// Check if changes made stayed.
			if (parsed.state == 1) {
				// Get the resultsul JQuery object.
				var $resultsul = $("ul#prodsearchresults");
				
				// Remove all old results.
				$resultsul.empty();
				
				// List matching products.
				for (i = 0; i < parsed.results.length; i++) {
					var newresult = '<li><a href="#" '
						+'class="prodResultLink">'
						+parsed.results[i].name
						+'</a><form action="">'
						+'<input type="hidden" '
						+'class="hpid" value="'
						+parsed.results[i].id+'">'
						+'</form></li>';
					$resultsul.append(newresult);
				}
				//TODO: make div fit.
			} else {
				alert("Errors occurred. The return status was: "
					+parsed.state);
			}
		},
		error:function(){
			// AJAX Request failed!
			alert('AJAX Failure: please try again!');
		}
	});
};

// Get product configuration information.
function getProductConfig(id){
	var pid = id;
	$.ajax({
		type:	'POST',
		url:	'/autosistant/admin/ajax',
		data:	{
				changeSet:	"getProductConfig",
				json:		id
			},
		beforeSend:function(){
			// TODO: Notify user about waiting for reply?
		},
		success:function(data){
			// AJAX request made succesfully!
			// Parse the JSON message.
			var parsed = $.parseJSON(data);
			
			// Check if changes made stayed.
			if (parsed.state == 1) {
				// Get needed objects.
				var $prodform = $("form#searchprods");
				
				// Store the contents of the form.
				prodPrev = $prodform.html();
				
				// Empty the form.
				$prodform.empty()
				
				// Add hidden input.
				$prodform.append('<input type="hidden" '+
					'id="hiddenpid" value="'+pid+'">');
				
				// Refill the form.
				for (i = 0; i < identcats.length; i++) {
					var id = identcats[i].id;
					var name = identcats[i].name;
					var newoption = '<label for="'
							+name+'">'+name+
							'</label>'+
							'<input type="input"'+
							'id="popttb'+id+'">'+
							'</input><button '+
							'type="button" '+
							'class="addProdOpt" '+
							'id="addPOpt'+id+'">'+
							'Add</button>'+
							'</br>'+
							'<ul class="dynlist'+
							' prodConfigList" '+
							'id="poptul'+id+'">'
							+'</ul>';
					$prodform.append(newoption);
				}
				for (i = 0; i < parsed.results.length; i++) {
					var id = parsed.results[i].id;
					var name = parsed.results[i].name;
					var value = parsed.results[i].value;
					var $ul = $('ul#poptul'+id);
					var newli = '<li>'+value+'<a href="#" '
						+'class="liLinkDelete"> x</a>'+
						'</li>';
					$ul.append(newli);
				}
				$prodform.append('<a id="prodBack"href="#">'+
						'Go Back</a>');
				$prodform.append('<button type="button" '+
						'id="commitProdConfig">'+
						'Commit Changes</button>');
			} else {
				alert("Errors occurred. The return status was: "
					+parsed.state);
			}
		},
		error:function(){
			// AJAX Request failed!
			alert('AJAX Failure: please try again!');
		}
	});
};

// Update product configuration information.
function updateProductConfig($clicked) {
	// Prepare the send data.
	sendData = [];
	var $prodform = $clicked.closest("form");
	var $hidden = $prodform.children("#hiddenpid").eq(0);
	var pid = parseInt($hidden.val(), 10);
	
	$("ul.dynlist.prodConfigList").each(function(){
		var $curul = $(this);
		var icid = parseInt($curul.attr("id").match(/\d+/), 10);
		
		$curul.children("li").each(function(){
			var $curli = $(this);
			var value = $curli.html();
			value = value.substring(0, value.indexOf('<'));
			sendData.push({ icid: icid, value: value });
		});
	});
	
	$.ajax({
		type:	'POST',
		url:	'/autosistant/admin/ajax',
		data:	{
				changeSet:	"updateProductConfig",
				json:		{
							pid: pid,
							sendData: sendData
						}
			},
		beforeSend:function(){
			// TODO: Notify user about waiting for reply?
		},
		success:function(data){
			// AJAX request made succesfully!
			// Parse the JSON message.
			var parsed = $.parseJSON(data);
			
			// Check if changes made stayed.
			if (parsed.state == 1) {
				alert("Changes made successfully!");
			} else {
				alert("Errors occurred. The return status was: "
					+parsed.state);
			}
		},
		error:function(){
			// AJAX Request failed!
			alert('AJAX Failure: please try again!');
		}
	});
};

// Update product configuration information.
function updateICConfig($clicked) {
	// Prepare the send data.
	sendData = {};
	var $form = $clicked.closest("form");
	var $icul = $form.children("#identCatList").eq(0);
	var icinfo = [];
	var questioninfo = [];
	
	// Build up identifier category information.
	$icul.children("li.idcatli").each(function(){
		var $curli = $(this);
		var text = $curli.html();
		var priority = parseInt(text.substring(text.indexOf("(")+1,
					text.indexOf(")")));
		var name = text.substring(0, text.indexOf(" "));
		
		// Push new item onto the array
		icinfo.push(	{
					name:		name,
					priority:	priority
				});
		
		// Build up this part of questioninfo.
		var $qul = $curli.children("ul.icquestionlist").eq(0);
		$qul.children("li").each(function(){
			$curli = $(this);
			text = $curli.html();
			var question = text.substring(0, text.indexOf("<"));
			
			questioninfo.push(	{
							question: question,
							name: name
						});
		});
	});
	$.ajax({
		type:	'POST',
		url:	'/autosistant/admin/ajax',
		data:	{
				changeSet:	"updateICConfig",
				json:		{
							icinfo: icinfo,
							qinfo: questioninfo 
						}
			},
		beforeSend:function(){
			// TODO: Notify user about waiting for reply?
		},
		success:function(data){
			// AJAX request made succesfully!
			// Parse the JSON message.
			var parsed = $.parseJSON(data);
			
			// Check if changes made stayed.
			if (parsed.state == 1) {
				alert("Changes made successfully!");
			} else {
				alert("Errors occurred. The return status was: "
					+parsed.state);
			}
		},
		error:function(){
			// AJAX Request failed!
			alert('AJAX Failure: please try again!');
		}
	});
};

// Key codes for reference.
var A_KEY = 65;
var CTRL_KEY = 17;
var BACKSPACE_KEY = 8;
var L_ARROW = 37;
var U_ARROW = 38;
var R_ARROW = 39;
var D_ARROW = 40;

$(function() {
	/// Try and prevent non-letters from being entered in certain textboxes
	var validateLettersOnly = function(selector) {
		var $elem = $(selector);
		var replace = $elem.val().replace(/[^a-zA-Z]/g, "");
		return $elem.val(replace);
	}

	$(".lettersonly").keydown(function(e) {
		if ((e.which < 65 || e.which > 90) &&
		    e.which != BACKSPACE_KEY &&
		    e.which != L_ARROW &&
		    e.which != U_ARROW &&
		    e.which != R_ARROW &&
		    e.which != D_ARROW
		)
	
			e.preventDefault();
		return true;
	});

	$(".lettersonly").keyup(function(e) {
		if(
			(e.ctrlKey && e.which === A_KEY)	
				|| 
			(e.which === CTRL_KEY)
				||
			(e.which === BACKSPACE_KEY)
				||
			(e.which === L_ARROW)
				||
			(e.which === U_ARROW)
				||
			(e.which === R_ARROW)
				||
			(e.which === L_ARROW)
		)
		{
			return true;
		}

		validateLettersOnly(this);	
		return true;
	});

	$(".lettersonly").bind("paste", function() {
		var selector = this;
        	setTimeout(function() {
			validateLettersOnly(selector);	
		}, 20);
	});
	///

	// Create UI Tabs.
	$( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
	$( "#tabs li" ).removeClass( "ui-corner-top" )
		.addClass( "ui-corner-left" );
	
	// Create accordions. 
	$( ".accordion" ).accordion();
	
	// Add item to a specific list.
	$(document).on('click', '.addphrase', function() {
		// Get objects we need.
		var $form = $(this).closest("form");
		var $div = $(this).closest("div.autosized");
		var aid = $form.children("input:hidden.hid").eq(0).val();
		var $list = $form.children("ul").eq(0);
		var $textbox = $form.children("input:text").eq(0);
		var text = $textbox.val();
 		$textbox.attr('value', '');
		
		// Search to see if the new item already exists.
		var found = false;
		for (i = 0; i < actionlist.length; i++) {
			if (actionlist[i].phrase == text) {
				found = true;
				break;
			}
		}
		
		// If this is a new, unique item, add it to the list.
		if (text != '' && !found) {
			$list.append('<li>'+text+
				'<a href="#" class="liLinkDelete">x</a></li>');
			var newitem = {
				aid:	aid,
				phrase:	text
			};
			actionlist.push(newitem);
			
			// Change div size.
			$div.fadeIn("slow", function() {
				$div.height('auto');
			});
		} else if (text == '') {
		} else if (found) {
			alert('Cannot have two of the same phrase!');
		}
	});
	
	// Remove item off of a specific list. 
	$(document).on('click', '.liLinkDelete', function() {
		// Get some necessary objects.
		var $form = $(this).closest("form");
		var $div = $(this).closest("div.autosized");
		var text = $(this).closest("li").html();
		// The following is a total hack... a terribe idea.
		text = text.substring(0, text.indexOf('<'));
		
		$(this).closest('li').remove();
		
		// Change div size.
		$div.fadeIn("slow", function() {
			$div.height('auto');
		});
		
		// Delete any occurence in actionlist.
		for (i = 0; i < actionlist.length; i++) {
			if (actionlist[i].phrase == text) {
				actionlist.splice(i, 1);
			}
		}
	});
	
	// Send AJAX message on click for phrase updating.
	$("#commitPhrases").click(function() {
		// Make sure there are no empty lists.
		var message = "";
		$("ul.dynlist.phraselist").each(function() {
			var $curul = $(this);
			var title = $curul.closest("form")
				.children("input:hidden.htitle").eq(0).val();
			if ($curul.children("li").length == 0) {
				// Add the title to the list.
				if ("" == message) {
					message += "The following actions "
							+"have no phrases:\n\n";
				}
				message += title+"\n";
			}
		});
		if ("" != message) {
			alert(message+"\nPlease enter at least one phrase "
				+"for each of these actions.");
			return true;
		}
		updateConfigurationAjax("phrases", actionlist);
	});
	
	// Add item to a specific product configuration list.
	$(document).on('click', '.addProdOpt', function() {
		// Get all the objects we need.
		var $clicked = $(this);
		var id = $clicked.attr("id");
		var idnum = parseInt(id.match(/\d+/), 10);
		var $ul = $('ul#poptul'+idnum);
		var $textbox = $('#popttb'+idnum);
		var addtext = $textbox.val();
		
		// Check that value doesn't already exist in list.
		var found = false;
		$ul.children('li').each(function() {
			$curli = $(this);
			var litext = $curli.html();
			litext = litext.substring(0, litext.indexOf('<'));
			if (litext == addtext) {
				alert('You have entered a duplicate option!');
				found = true;
				return false;
			}
		});
		
		// Only continue if nothing was found.
		if (found) {return true;}
		
		// Create the new li.
		var newli = '<li>'+addtext+'<a href="#" '
			+'class="liLinkDelete"> x</a>'+
			'</li>';
		
		// Add the item!
		$ul.append(newli);
		$textbox.val("");
	});
	
	// Send AJAX message for product search.
	$(document).on('click', '#searchProducts', function() {
		// Get the string in the textbox.
		var tosearch = 
			$(this).closest('form').children('input:text').val();
		searchProducts(tosearch);
	});
	
	// Send AJAX message for product configuration.
	$(document).on('click', '.prodResultLink', function() {
		// Get the string in the textbox.
		var id = 
			$(this).closest('li').children('form').eq(0)
				.children('input:hidden.hpid').eq(0).val();
		getProductConfig(id);
	});
	
	// Send AJAX message for product configuration.
	$(document).on('click', '#prodBack', function() {
		var $form = $(this).closest('form');
		$form.empty();
		$form.append(prodPrev);
	});
	
	// Send AJAX message for product configuration.
	$(document).on('click', '#commitProdConfig', function() {
		updateProductConfig($(this));
	});
	
	// Add an identifier category.
	$(document).on('click', '#addIdentCategory', function() {
		// Get objects we need.
		var $form = $(this).closest('form');
		var $tbCatName = $form.children('#categoryName').eq(0);
		var $tbPriority = $form.children('#categoryPriority').eq(0);
		var name = $tbCatName.val();
		var priority = parseInt($tbPriority.val());
		
		var $catul = $form.children('#identCatList');
		var dontadd = false;
		// Check to see if there are any duplicates
		$catul.children("li.idcatli").each(function(){
			// Extract the text needed.
			var $curli = $(this);
			var text = $curli.html();
			text = text.substring(0, text.indexOf(" "));
			
			// Check that we are not adding a non-unique name
			if (text == name) {
				alert('There cannot be two identifier '+
					'categories with the same name!');
				dontadd = true;
				return false;
			}
			else if (!name || name=="") {
				alert('Each category must have a name!');
				dontadd = true;
				return false;
			}
			else if (isNaN(priority)) {
				alert('New category must have an integer '+
					'priority!');
				dontadd = true;
				return false;
			}
		});
		if (dontadd) { return true };
		
		// Add new item to the list.
		var newli = '<li class="idcatli">'+name+' ('+priority+
			')<a href="#" class="liLinkDelete">x</a>'+
			'</br>'+
			'<input type="text" class="tbICQuestion">'+
			'<button type="button" class="addICQuestion">'+
				'Add Question</button>'+
			'<ul class="dynlist icquestionlist"></ul>'+
			'<input type="hidden" class="hiddenpriority" value="'+
				priority+'">';
		$catul.append(newli);
		// TODO: Sort the list?
		
		$tbCatName.val("");
		$tbPriority.val("");
	});
	
	// Add question to a identifier category.
	$(document).on('click', '.addICQuestion', function(){
		var $li = $(this).closest("li");
		var $textbox = $li.children("input:text.tbICQuestion").eq(0);
		var text = $textbox.val();
		var $ul = $li.children("ul.icquestionlist").eq(0);
		
		// Append to the list.
		var newli = '<li>'+text+
				'<a href="#" class="liLinkDelete">x</a></li>';
		$ul.append(newli);
		
		// Clear the textbox.
		$textbox.val("");
	});
	
	// Commit changes to Identifier Category settings.
	$(document).on('click', '#commitIdentCategories', function(){
		updateICConfig($(this));
	});
});
