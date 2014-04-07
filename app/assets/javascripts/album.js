function addMoreField() {
	var num = 0
	var item_index = 0
	$('.image_attr input').last().attr('id').split('_').forEach(function(val, index){
		if (!isNaN(parseInt(val))){
			num = parseInt(val)
			item_index = index
		}
	});
	num = num + 1
	
	var str = '<br/><p class="image_attr"><label for="album_photos_attributes_'+num+'_content">Upload Photo</label><br>'
	str += '<input type="file" name="album[photos_attributes]['+num+'][image]" id="album_photos_attributes_'+num+'_image"><br></p>'
	str+='<p><label for="album_photos_attributes_'+num+'_tags_attributes_0_caption">Tag</label>'
	str +='<input type="text" size="30" name="album[photos_attributes]['+num+'][tags_attributes][0][caption]" id="album_photos_attributes_'+num+'_tags_attributes_0_caption"></p>'
	
	$('#data-image').append(str)
}

$(document).ready(function() {
	$("#add-more_image").click(function(e){
		e.preventDefault();
		addMoreField();
	})
});