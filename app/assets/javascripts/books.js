$('#isbn').change(function() {
    var isbn = $('#isbn').val();
    if (isbn.length) {
    	var $inputs = $('#isbn').closest('form').find("input, select, button, textarea");
        $inputs.prop("disabled", true);
        
    	$.getJSON('/books/isbn/' + isbn, function(data) {
    		if (data && data["identifiers"] != undefined){
    			$("#title").val(data["title"]);
    			$("#link").val(data["url"]);
    			if (data["authors"]) {
    				$("#author").val(data["authors"][0]["name"]);
    			}
    			if (data["publishers"]){
    				$("#publisher").val(data["publishers"][0]["name"]);
    			}
    			if (data["cover"]){
    				$("#img_url").val(data["cover"]["medium"]);
    			}
    			if (data["subjects"]){
    				$("#category").val(data["subjects"][0]["name"]);
    			}
    		}
    		$inputs.prop("disabled", false);
    	});
    }
});