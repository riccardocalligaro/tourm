<?php

/** @var \Laravel\Lumen\Routing\Router $router */

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->group(['prefix' => 'api/v1'], function () use ($router) {


    $router->get('/beacons', 'BeaconsController@index');
    $router->get('/rooms', 'RoomsController@index');
    $router->get('/room/{id}/audioguides', 'AudioguidesController@audioguidesByRoom');

    $router->get('/languages', 'LanguagesController@index');
    $router->get('/audioguides', 'AudioguidesController@index');
    $router->get('/audioguides-with-room', 'AudioguidesController@audioguidesWithRoom');

    $router->get('/audioguides/{beacon_code}', 'AudioguidesController@audioguidesByBeacon');

    // tickets
    $router->get('/tickets', 'TicketsController@tickets');
    $router->get('/ticket-types', 'TicketsController@ticketTypes');
    $router->get('/check-ticket/{code}', 'TicketsController@checkTicket');

    // employees
    $router->get('/employees', 'EmployeesController@index');

    // articles
    $router->get('/articles', 'ArticlesController@index');
    $router->get('/articles-for-author/{name}', 'ArticlesController@articlesForAuthor');

    $router->get('/room/{room_id}/articles', 'ArticlesController@roomArticles');

});
