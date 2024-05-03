<?php

use database\databaseConfig;
use notifications\attention;
class MyShop
{
    private databaseConfig $databaseConfig;
    private object $mysqli;
    private int $authorized;

    public function __construct() {

        $this->databaseConfig = new databaseConfig;
        $this->authorized = 0;

        if($this->databaseConfig->checkAuthority() == 1) {
            $this->mysqli = $this->databaseConfig->getConfig();
            $this->authorized = 1;
        } else {
            $attention = new attention("MyShop", "MyShop plugin requires database access!");
            $attention->raiseOnMissingDatabasePermission();
        }
    }

    public function createTables(string $file)
    {
        if($this->authorized) {
            $this->databaseConfig->checkForTable("myshop_categories");
            $this->mysqli->multi_query(file_get_contents($file));
        }

    }




}



