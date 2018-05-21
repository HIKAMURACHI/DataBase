<?php
ob_start();
function __autoload($class_name)
{
    require_once dirname(__FILE__) . DIRECTORY_SEPARATOR . 'classes' . DIRECTORY_SEPARATOR . strtolower($class_name) . '.class.php';
}

// BD Connection
$db = new DB(Config::$dbHost, Config::$dbUser, Config::$dbPass, Config::$dbBase);

$request = $_SERVER['REQUEST_URI'];
$request = urldecode(trim($request, '/'));

$query = explode('?', $request);
$query = $query[1];
$queryData = explode('&', $request);

$query = array();
foreach ($queryData as $item) {
    $item = explode('=', $item);
    $query[$item[0]] = $item[1];
}

$request = explode('/', $request);

function _view($clients) {
    echo '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>';
    echo "<table class=\"table table-hover\">";
    echo "<tr>";
    foreach ($clients[0] as $key => $value) {
        echo "<td>";
        echo $key;
        echo "</td>";
    }
    echo "</tr>";

    foreach ($clients as $client) {
        echo "<tr>";
        foreach ($client as $value) {
            echo "<td>";
            echo $value;
            echo "</td>";
        }
        echo "</tr>";
    }

    echo "</table>";
}

$data = array();

//var_dump($request);

switch ($request[2]) {
    case 'movies':
        switch ($request[3]) {
            case 'all':
                $data['type'] = 'success';
                $data['data'] = $db->sql("SELECT * FROM `movies`");
                break;

            case 'get':
                $data['type'] = 'success';
                $data['data'] = $db->sql("SELECT * FROM `movies` WHERE `ID` = " . (int)$db->escape($request[4]));
                $data['data'] = $data['data'][0];
                break;

            case 'view':
                $clients = $db->sql("SELECT * FROM `movies`");
                _view($clients);
                exit;
        }
        break;

	case 'directorr':
        switch ($request[3]) {
            case 'all':
                $data['type'] = 'success';
                $data['data'] = $db->sql("SELECT * FROM `directorr`");
                break;

            case 'get':
                $data['type'] = 'success';
				$d = $db->escape($request[4]);
                $data['data'] = $db->sql("SELECT * FROM `directorr` WHERE `directors` = '$d'");
                $data['data'] = $data['data'][0];
                break;

            case 'view':
                $clients = $db->sql("SELECT * FROM `directorr`");
                _view($clients);	
                exit;
        }
        break;
		
	case 'genress':
        switch ($request[3]) {
            case 'all':
                $data['type'] = 'success';
                $data['data'] = $db->sql("SELECT * FROM `genress`");
                break;

            case 'get':
                $data['type'] = 'success';
                $data['data'] = $db->sql("SELECT * FROM `movies` WHERE `genres` = " . $db->escape($request[4]));
                $data['data'] = $data['data'][0];
                break;

            case 'view':
                $clients = $db->sql("SELECT * FROM `movies`");
                _view($clients);
                exit;
        }
        break;
		
	case 'studioo':
        switch ($request[3]) {
            case 'all':
                $data['type'] = 'success';
                $data['data'] = $db->sql("SELECT * FROM `studioo`");
                break;

            case 'get':
                $data['type'] = 'success';
                $data['data'] = $db->sql("SELECT * FROM `movies` WHERE `studios` = " . $db->escape($request[4]));
                $data['data'] = $data['data'][0];
                break;

            case 'view':
                $clients = $db->sql("SELECT * FROM `studio`");
                _view($clients);
                exit;
        }
        break;
		
		case 'resultt':
        switch ($request[3]) {
            case 'all':
                $data['type'] = 'success';
                $data['data'] = $db->sql("SELECT * FROM `resultt`");
                break;

            case 'get':
                $data['type'] = 'success';
                //$data['data'] = $db->sql("SELECT * FROM `movies` WHERE `Result` = " . $db->escape($request[4]));
                $data['data'] = $db->sql("SELECT * FROM `resultt` WHERE `ID` = " . $db->escape($request[4]));
                $data['data'] = $data['data'][0];
                break;

            case 'view':
                $clients = $db->sql("SELECT * FROM `Result`");
                _view($clients);
                exit;
        }
        break;
		
    default:
        $data['type'] = 'error';
        $data['desc'] = 'Bad Request';
}

header('Content-type: application/json');
echo json_encode($data);
ob_get_contents();