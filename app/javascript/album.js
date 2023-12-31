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
};


function updateStatus(checked) {
  const statusField = document.querySelector('#user_status'); // Thay '#user_status' bằng đúng id của trường status nếu cần
  statusField.value = checked ? 'active' : 'inactive';
};
