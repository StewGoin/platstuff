var fieldIgnoreList = [];

function createElement(name, data, parent)
{
	//generic headers
	if (/^h\d/.test(data.type))
		createHeader(name, data, parent);
	else {
		switch(data.type) {
			case "select": createSelection(name, data, parent); break;
			case "checkbox": createCheckbox(name, data, parent); break;
			case "text": createTextbox(name, data, parent); break;
			case "fieldset": createFieldset(name, data, parent); break;
		}
	}
}

function createFieldset(name, data, parent) {
	var fieldset = $("<fieldset>").appendTo(parent);	
	$("<legend>", {"text": data.text}).appendTo(fieldset);
	
	$.each(data.fields, function(key,val) {
		createElement(key, val, fieldset);
	});
}

function createHeader(name, data, parent) {
	element = $("<"+data.type+">", {"text": data.text})
		.appendTo(parent);
}

function createCheckbox(name, data, parent) {
	div = $("<div>", {"class": "gh_setting"}).appendTo(parent);	
	element = $("<input>", {"type": data.type, "value": name, "id": name, "name": name}).appendTo(div);
	label = $("<label>", {"text": data.text, "for": name}).appendTo(div);
	
	if ('title' in data)
		div.attr('title', data.title);
	
	if ('child' in data) {
		fieldIgnoreList.push(data.child);
		element.attr('child', data.child);
	}
			
	if ('requiresChild' in data)
		if (data.requiresChild)
			element.attr('requiresChild', true);
}

function createTextbox(name, data, parent) {
	div = $("<div>", {"class": "gh_setting"}).appendTo(parent);	
	$("<label>", {"text": data.text, "for": name}).appendTo(div);
	element = $("<input>", {"type": data.type, "id": name, "name": name}).appendTo(div);
	
	if ('title' in data)
		div.attr('title', data.title);
	
	if ('child' in data){
		fieldIgnoreList.push(data.child);
		element.attr('child', data.child);
	}
			
	if ('requiresChild' in data)
		if (data.requiresChild)
			element.attr('requiresChild', true);
}

function createSelection(name, data, parent) {
	div = $("<div>", {"class": "gh_setting"}).appendTo(parent);
	$("<label>", {"text": data.text, "for": name}).appendTo(div);
	element = $("<select>", {"type": data.type, "id": name, "name": name}).appendTo(div);
	
		
	if ('title' in data)
		div.attr('title', data.title);
	
	if ('child' in data){
		fieldIgnoreList.push(data.child);
		element.attr('child', data.child);
	}
			
	if ('requiresChild' in data)
		if (data.requiresChild)
			element.attr('requiresChild', true);
	
	data.options.forEach(function(item) {
		element.append($("<option>", {
			"value": item.value,
			"text": item.text
		}));
	});
}

function buildForm(form_id, filepath) {
	//$.getJSON(filepath, function( data ) {
		
		var ghform = $(form_id);
		id = 100;
		
		$.each(data.form, function(key, val) {
			createElement(key, val, ghform);
		});
	}