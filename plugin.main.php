<?php
use admin\{navbar, authentication};


$name = "MyShop";
$version = "1.0.0";

$src = PLUGINS . $name . DIRECTORY_SEPARATOR . 'src' . DIRECTORY_SEPARATOR;
$classes = $src . "classes" . DIRECTORY_SEPARATOR;
$pages = PLUGINS . $name . DIRECTORY_SEPARATOR . "pages" . DIRECTORY_SEPARATOR;
$data = PLUGINS . $name . DIRECTORY_SEPARATOR . 'data' . DIRECTORY_SEPARATOR;

$myShopDep = $classes . 'MyShop.class.php';
$cartDep = $classes . 'MyShopCart.class.php';
$categoryDep = $classes . 'MyShopCategories.class.php';
$productDep = $classes . 'MyShopProduct.class.php';
$checkoutDep = $classes . 'MyShopCheckout.class.php';

include_once $myShopDep;
include_once $categoryDep;
include_once $cartDep;
include_once $productDep;
include_once $checkoutDep;
include_once $classes . "MyShopAPI.class.php";

$myshop = new MyShop();

$myshop->createTables($data . "myshop.sql");

addDependency("high", "MyShop", $myShopDep, $version);
addDependency("high", "MyShopCategories", $categoryDep, $version);
addDependency("high", "MyShopProduct", $productDep, $version);
addDependency("high", "MyShopCart", $cartDep, $version);
addDependency("high", "MyShopCheckout", $checkoutDep, $version);

addEngine("MyShop", $src . "MyShop.php", $version, "end");

$pluginPages['Product'] = $pages . 'product.page.php';
$pluginPages['Categories'] = $pages . 'categories.page.php';
$pluginPages['Products'] = $pages . 'products.page.php';

$auth = new authentication;

if (function_exists('navbarLoader') && $auth->checkAuthentication()) {

    $pluginPages['MyShop'] = $pages . 'plugin.page.php';
    $pluginPages['MyShop Products'] = $pages . 'myshopProducts.page.php';
    $pluginPages['MyShop Categories'] = $pages . 'myshopCategories.page.php';

    $nav = new navbar;

    $location = HOSTNAME . 'awt-content/plugins/MyShop/data/icons/';

    $nav->addItem(array('icon' => $location . 'icon.png', 'name' => 'MyShop', 'link' => HOSTNAME . 'awt-admin/?page=MyShop', 'permission' => 1));
    $nav->addItem(array('icon' => $location . 'products.png', 'name' => 'Products', 'link' => HOSTNAME . 'awt-admin/?page=MyShop Products', 'permission' => 1));
    $nav->addItem(array('icon' => $location . 'category.png', 'name' => 'Categories', 'link' => HOSTNAME . 'awt-admin/?page=MyShop Categories', 'permission' => 1));


    array_push($navbar, $nav);
}

if(isset($api_executors)) {
    addToApiExecution("MyShop", $api = new MyShopAPI);
}
