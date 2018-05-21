function client(id) {
    var c = $.ajax({
        url: 'api/movies/get/' + id,
        async: false
    }).responseText;
    c = JSON.parse(c);
    return c['data'];
}

function clientDir(id) {
    var c = $.ajax({
        url: 'api/directorr/get/' + encodeURIComponent(id),
        async: false
    }).responseText;
	console.log(c);
    c = JSON.parse(c);
    return c['data'];
}

function clientRes(id) {
    var c = $.ajax({
        url: 'api/resultt/get/' + encodeURIComponent(id),
        async: false
    }).responseText;
	console.log(c);
    c = JSON.parse(c);
    return c['data'];
}

function modalClient(id) {
    var c = client(id);
	var a = c['Avaliable'] == 0 ? 'No' : 'Yes';
    $('#modal-title').text(c['Name']);
    $('#modal-text')
        .text('')
        .append('ID: ' + c['ID'] + '<br/>')
        .append('Name: ' + c['Name'] + '<br/>')
        .append('Studio: ' + c['Studio'] + '<br/>')
        .append('Genre: ' + c['Genre'] + '<br/>')
        .append('Year: ' + c['Year'] + '<br/>')
        .append('Director: ' + c['Director'] + '<br/>')
        .append('Main_Role: ' + c['Main_Role'] + '<br/>')
        .append('ShortStroy: ' + c['ShortStroy'] + '<br/>')
        .append('Result: ' + c['Result'] + '<br/>')
		.append('Avaliable: ' + a + '<br/>')
		.append('<img style="max-width: 50%; max-height: 60%;" src="img/'+c['Name']+'.jpg"/>');
    $('#modal').modal('show');
}

function modalClientDir(id) {
    var c = clientDir(id);
    $('#modal-title').text(c['directors']);
    $('#modal-text')
        .text('')
        .append('Director: ' + c['directors'] + '<br/>')
		.append('Date Birth: ' + c['DateBirth'] + '<br/>')
		.append('<img style="max-width: 50%; max-height: 60%;" src="img/'+c['directors']+'.jpg"/>');
		
    $('#modal').modal('show');
}

function modalClientRes(id) {
    var c = clientRes(id);
	console.log(c);
    $('#modal-title').text('Score');
    $('#modal-text')
        .text('')
        .append('Result: ' + c['Res'] + '<br/>')
		.append('<img src="https://rating.kinopoisk.ru/'+c['MovieSer']+'.gif" border="0">');
		
    $('#modal').modal('show');
}

$(document).ready(function () {
    $.ajax('api/movies/all')
        .done(function (data) {
            if (data['type'] == 'error') return;

            for (var i = 0; i < data['data'].length; i++) {
                var a = data['data'][i]['Avaliable'] == 0 ? 'No' : 'Yes';
				var r = clientRes(data['data'][i]['Result']);
                $('#deposits').append('<tr>' +
                    '<td>' + data['data'][i]['ID'] + '</td>' +
                    '<td><a href="javascript:void(0)" onclick="modalClient(' + data['data'][i]['ID'] + ');">' + data['data'][i]['Name'] + '</a></td>' +
                    '<td>' + data['data'][i]['Studio'] + '</td>' +
                    '<td>' + data['data'][i]['Genre'] + '</td>' +
					'<td>' + data['data'][i]['Year'] + '</td>' +
					'<td><a href="javascript:void(0)" onclick="modalClientDir(\'' + data['data'][i]['Director'] + '\');">'  + data['data'][i]['Director'] + '</a></td>' +
					'<td><a target="_blank" href="https://www.kinopoisk.ru/index.php?kp_query=' + data['data'][i]['Name'] + '">' + data['data'][i]['Main_Role'] + '</a></td>' + //
					'<td>' + data['data'][i]['ShortStroy'] + '</td>' +
					'<td><a href="javascript:void(0)" onclick="modalClientRes(' + data['data'][i]['ID'] + ');">'+ r['Res'] + '</a></td>' +
					'<td>' + a + '</td>' +
                    '</tr>');
            } //<a href='https://www.kinopoisk.ru/film/zvyozdnye-voyny-epizod-1-skrytaya-ugroza-1999-6695/'><img src='https://rating.kinopoisk.ru/6695.gif' border='0'></a>
        })
        .fail(function () {
            alert('Ошибка получения данных');
        });
});