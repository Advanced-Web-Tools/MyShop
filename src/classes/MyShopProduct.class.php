<?php

use MyShopCategories;

class MyShopProduct
{
    public string $name;
    public string $description;
    public MyShopCategories $category;
    public string $imageURL;
    public int $albumID; 
    public int $stock;
    public float $price;
}