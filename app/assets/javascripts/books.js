$('#isbn').change(function() {
    var isbn = $('#isbn').val();
    if (isbn.length) {
    	var $inputs = $('#isbn').closest('form').find("input, select, button, textarea");
        $inputs.prop("disabled", true);
        $.ajax({url: 'http://openlibrary.org/api/volumes/brief/json/isbn:' + isbn, dataType: 'jsonp'}).done(function(result){
            if (result && result["isbn:" + isbn] != undefined){
            	for (var key in result["isbn:" + isbn]["records"]){
            		record = result["isbn:" + isbn]["records"][key]
            		var data = record["data"];            		
            		var details = record["details"]["details"];
            		$("#title").val(data["title"]);
            		$("#link").val(data["url"]);
            		if (data["cover"]){
            			$("#img_url").val(data["cover"]["medium"]);
            		}
            		if (data["authors"]) {
            			$("#author").val(data["authors"][0]["name"]);
            		} else if (details["authors"]) {
            			$("#author").val(details["authors"][0]["name"]);
            		}
            		if (data["publishers"]){
            			$("#publisher").val(data["publishers"][0]["name"]);
            		} else if (details["publishers"]){
            			$("#publisher").val(data["publishers"][0]);
            		}
            		if (data["subjects"]){
            			$("#category").val(data["subjects"][0]["name"]);
            		} else if (details["subjects"]){
            			$("#category").val(details["subjects"][0]);
            		}
            		$('#isbn').parent().find('legend small').text("Got some data, complete the formular with amazon data if needed.");
            		break;
            	}
            } else {
            	$('#isbn').parent().find('legend small').text("Sorry, didn't find some book data");
            }
            $inputs.prop("disabled", false);
        });
    }
});