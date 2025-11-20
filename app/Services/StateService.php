<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use App\Models\State;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB;



class StateService{
    public function findAll(){
        //$result=$this->update();
        $states=State::all();
        return $states;
    }

    public function findOne($name){
        $copomex_url=config('services.copomex.base_url');
        $copomex_token=config('services.copomex.token');
        $response=Http::get("$copomex_url/query/get_municipio_por_estado/$name?token=$copomex_token");
        $data=$response->json();
        return $data['response']['municipios'];
    }

    public function update(){//esto se puede ejecutar mediante un cronjob para evitar llamadas recurrentes al servicio
        $copomex_url=config('services.copomex.base_url');
        $copomex_token=config('services.copomex.token');
        $response=Http::get("$copomex_url/query/get_estados?token=$copomex_token");
        $data=$response->json();
        $states=$data['response']['estado'];
        foreach($states as $item){
            State::firstOrCreate([
                'name'=>$item
            ]);
        }
    }
}