$( document ).ready(() => {
  console.log( "ready!" );
  $('.alert').hide();

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
        coordinate = `${result.data.new_x}${result.data.new_y}`;
        console.log(coordinate);
        const color = data.player == 1? 'red' : 'blue';
        $('#' + coordinate).append(`<img src='assets/${color}.png'>`);
        if (result.data.status == 'win') {
          $('.alert').html(`<strong> ${color.toUpperCase()} wins!</strong>`);
          $('.alert').show();
        }
        $('#player').val(data.player * -1);
      }
    });

 
  });
});
