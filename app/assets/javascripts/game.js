$( document ).ready(() => {
  $('.alert').hide();
  var color = $('#player').val() == 1? 'red' : 'blue';
  $('table').css('cursor', `url(assets/cursor_${color}.png), auto`);

  $('td').click((e) => {
    const data = {
      id: e.target.id,
      player: $('#player').val(),
    };

    $.ajax({
      url: '/game/place_move',
      type: 'POST',
      data: JSON.stringify(data),
      contentType: 'application/json; charset=utf-8',
      dataType: 'json',
      success: (result) => {

        const coordinate = `${result.data.new_x}${result.data.new_y}`;

        $('#' + coordinate).append(`<img src='assets/${color}.png'>`);
        if (result.data.status == true) {
          $('.alert').html(`<strong> ${color.toUpperCase()} wins!</strong>`);
          $('.alert').show();
        }

        $('#player').val(data.player * -1);
        color = data.player * -1 == 1? 'red' : 'blue';
        $('table').css('cursor', `url(assets/cursor_${color}.png), auto`);
      }
    });

 
  });
});
