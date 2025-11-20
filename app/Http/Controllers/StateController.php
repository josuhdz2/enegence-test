<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;

use App\Services\StateService;

class StateController extends Controller
{
    public function index(StateService $stateService){
        return Inertia::render('State/Index', [
            'states'=>$stateService->findAll()
        ]);
    }

    public function getOne(StateService $stateService, $name){
        return Inertia::render('State/StateDetails', [
            'cities'=>$stateService->findOne($name)
        ]);
        //return response()->json($stateService->findOne($name));
    }
}
