function readURL(input, id, mode) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#' + id )
        .attr('src', e.target.result)
        };
    }
    if ( mode == "new" || mode == "edit" || mode == "edit_album" ) {
      element = document.getElementById('block_img')
      element.classList.remove('d-none')
    }
    if (mode == "edit") {
      element1 = document.getElementById('block_change_img')
      element1.classList.add('d-none')
    }
    reader.readAsDataURL(input.files[0]);
};
function deleteImage(){
  document.getElementById('block_img').classList.add('d-none')
  document.getElementById('block_change_img').classList.remove('d-none')
}
function create_truncate(id) {
  var e_array = document.getElementsByClassName(id);
  for (let i = 0; i < e_array.length; i++) {
    var element = e_array[i];
    if (element !== null) {
      var wordArray = element.innerHTML.split(' ');
      while (element.scrollHeight > element.clientHeight || element.scrollWidth > element.clientWidth) {
        wordArray.pop();
        element.innerHTML = wordArray.join(' ') + '...';
        console.log(e_array.length)
      }
    }
  }
}

// create_truncate('description');
