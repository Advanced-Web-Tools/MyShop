<?php
use admin\{authentication, profiler};

defined('DASHBOARD') or die("You should not do that..");
defined('ALL_CONFIG_LOADED') or die("An error has occured");

$check = new authentication;

if (!$check->checkAuthentication()) {
    header("Location: ./login.php");
    exit();
}

$profiler = new profiler;

if (!$profiler->checkPermissions(2))
    die("Insufficient permission to view this page!");


$location = HOSTNAME . 'awt-content/plugins/MyShop/';

?>

<link rel="stylesheet" href="<?php echo $location ?>data/assets/css/categories.css">
<script src="<?php echo $location ?>js/addCategory.js"></script>

<div class="overlay hidden"></div>

<div class="section">

    <h3>Add new MyShop Category</h3>

    <div class="addCategory wrapper shadow">

        <div class="input-container">
            <input type="text" name="Name" id="name" class="input" placeholder="Category name">
            <textarea name="description" placeholder="Description" id="description" class="textarea"></textarea>
            <select name="album" id="album" class="select">
                <option value="null">Select Album</option>
            </select>
            <button type="button" class="button">Select image</button>
            <button type="button" class="button" id="green">Save</button>
        </div>
    </div>

    <div class="categories shadow">

    </div>
</div>


<script>

</script>