function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_prev')
        .attr('src', e.target.result)
        .width(120)
        .height(120);
        };
      element = document.getElementById('block_img')
      element.classList.remove('d-none')
      reader.readAsDataURL(input.files[0]);
    }
};
function readURL_edit(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#edit_img')
      .attr('src', e.target.result)
      };

    reader.readAsDataURL(input.files[0]);
  }
};
