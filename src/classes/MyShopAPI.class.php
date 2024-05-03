<?php

use api\api;


class MyShopAPI extends api
{

    private MyShopCategories $myShopCategories;
    private MyShopCart $myShopCart;
    private MyShopProduct $myShopProduct;

    public function __construct()
    {
        parent::__construct();
        
        $this->myShopCategories = new MyShopCategories;
        $this->myShopCart = new MyShopCart;
        $this->myShopProduct = new MyShopProduct;
    }

    public function Api()
    {
        parent::Api();

        if (isset($_POST['fetchCategories']))
            die(json_encode($this->myShopCategories->fetchCategories()));

        if (!$this->checkForData())
            exit();

        if (isset($_POST['addCategory']))
            die($this->myShopCategories->addCategory($_POST['data']['name'], $_POST['data']['description'], $_POST['data']['image'], $_POST['data']['album']));

    }

}
