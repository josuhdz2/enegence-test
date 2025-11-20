<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

use App\Http\Controllers\StateController;

Route::get('/', function () {
    return Inertia::render('Welcome', ['message'=>'hola, este es el mensaje']);
})->name('home');

Route::get('/state', [StateController::class, 'index']);

Route::get('/state/{name}', [StateController::class, 'getOne']);