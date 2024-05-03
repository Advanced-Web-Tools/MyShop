<?php

use admin\authentication;
use admin\profiler;
use database\databaseConfig;

class MyShopCategories
{
    public array $categories;
    private databaseConfig $databaseConfig;
    private mysqli $mysqli;
    private int $authorized;
    public function __construct()
    {
        $this->databaseConfig = new databaseConfig;

        $this->categories = array();

        if ($this->databaseConfig->checkAuthority() == 1) {
            $this->mysqli = $this->databaseConfig->getConfig();
            $this->authorized = 1;
        }
    }

    public function fetchCategories(): array
    {
        if (!$this->authorized)
            return [];

        $stmt = $this->mysqli->prepare("SELECT * FROM `myshop_categories` WHERE 1;");
        $stmt->execute();
        $fetched = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
        $stmt->close();

        foreach ($fetched as $key => $value) {
            $this->categories[$value['id']]["name"] = $value['name'];
        }

        return $this->categories;
    }

    public function addCategory(string $name, string|null $description, string|null $image, int|null $album): bool
    {

        $auth = new authentication;

        $profiler = new profiler;

        if (!$this->authorized || trim($name) == "" || !$auth->checkAuthentication() || $profiler->checkPermissions(1))
            return false;

        $stmt = $this->mysqli->prepare("INSERT INTO `myshop_categories` (`name`, `description`, `image_link`, `album_id`) VALUES ?, ?, ?, ?;");
        $stmt->bind_param("sssi", $name, $description, $image, $album);
        $stmt->execute();
        $stmt->close();

        return true;
    }
}
