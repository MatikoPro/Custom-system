<?php

include('../config/function.php');

if (isset($_POST['saveAdmin'])) {
    $name = validate($_POST['name']);
    $email = validate($_POST['email']);
    $password = validate($_POST['password']);
    $phone = validate($_POST['phone']);
    $role = validate($_POST['role']);
    $is_ban = isset($_POST['is_ban']) == true ? 1 : 0;

    if ($name != '' && $email != '' && $password != '' && $role != '') {

        $emailCheck = mysqli_query($conn, "SELECT * FROM admins WHERE email='$email'");
        if ($emailCheck) {
            if (mysqli_num_rows($emailCheck) > 0) {
                redirect('admins-create.php', 'Email Already used by another user.');
            }
        }

        $bcrypt_password = password_hash($password, PASSWORD_BCRYPT);

        $data = [
            'name' => $name,
            'email' => $email,
            'password' => $bcrypt_password,
            'phone' => $phone,
            'role' => $role,
            'is_ban' => $is_ban
        ];
        $result = insert('admins', $data);

        if ($result) {
            redirect('admins.php', 'User Created Successfully!');
        } else {
            redirect('admins-create.php', 'Something Went Wrong!');
        }
    } else {
        redirect('admins-create.php', 'Please fill required fields.');
    }
}

if (isset($_POST['updateAdmin'])) {
    $adminId = validate($_POST['adminId']);

    $adminData = getById('admins', $adminId);
    if ($adminData['status'] != 200) {
        redirect('admins-edit.php?id=' . $adminId, 'Please fill required fields.');
    }

    $name = validate($_POST['name']);
    $email = validate($_POST['email']);
    $password = validate($_POST['password']);
    $phone = validate($_POST['phone']);
    $role = validate($_POST['role']);
    $is_ban = isset($_POST['is_ban']) == true ? 1 : 0;

    $EmailCheckQuery = "SELECT * FROM admins WHERE email='$email' AND id!='$adminId'";
    $checkResult = mysqli_query($conn, $EmailCheckQuery);
    if ($checkResult) {
        if (mysqli_num_rows($checkResult) > 0) {
            redirect('admins-edit.php?id=' . $adminId, 'Email Already used by another user');
        }
    }

    if ($password != '') {
        $hashedPassword = password_hash($password, PASSWORD_BCRYPT);
    } else {
        $hashedPassword = $adminData['data']['password'];
    }

    if ($name != '' && $email != '') {
        $data = [
            'name' => $name,
            'email' => $email,
            'password' => $hashedPassword,
            'phone' => $phone,
            'role' => $role,
            'is_ban' => $is_ban
        ];
        $result = update('admins', $adminId, $data);

        if ($result) {
            redirect('admins-edit.php?id=' . $adminId, 'User Updated Successfully!');
        } else {
            redirect('admins-edit.php?id=' . $adminId, 'Something Went Wrong!');
        }
    } else {
        redirect('admins-create.php', 'Please fill required fields.');
    }
}



/** 
 *   PRODUCTS CODE
 */
if (isset($_POST['saveProduct'])) {
    $name = validate($_POST['name']);
    $batch = validate($_POST['batch']);
    $quantity = validate($_POST['quantity']);
    $measure = validate($_POST['measure']);
    $buy_price = validate($_POST['buy_price']);
    $sell_price = validate($_POST['sell_price']);
    
    // Get the expenses arrays
    $expenses = isset($_POST['expenses']) ? $_POST['expenses'] : [];
    $expense_percentages = isset($_POST['expense_percentages']) ? $_POST['expense_percentages'] : [];

    // Combine multiple expenses into comma-separated strings
    $combined_expenses = [];
    $combined_percentages = [];
    
    foreach($expenses as $index => $expense) {
        if(!empty($expense) && !empty($expense_percentages[$index])) {
            $combined_expenses[] = validate($expense);
            $combined_percentages[] = validate($expense_percentages[$index]);
        }
    }

    $expense = implode(',', $combined_expenses);
    $expense_percentage = implode(',', $combined_percentages);

    if ($name != '' && $batch != '' && $quantity != '' && $buy_price != '' && $sell_price != '') {
        $data = [
            'name' => $name,
            'batch' => $batch,
            'quantity' => $quantity,
            'measure' => $measure,
            'buy_price' => $buy_price,
            'sell_price' => $sell_price,
            'expense' => $expense,
            'expense_percentage' => $expense_percentage,
            'status' => isset($_POST['status']) ? 1 : 0
        ];

        $result = insert('products', $data);

        if ($result) {
            redirect('products.php', 'Bidhaa imesajiliwa!');
        } else {
            redirect('products-create.php', 'Something Went Wrong!');
        }
    } else {
        redirect('products-create.php', 'Please fill required fields.');
    }
}

if (isset($_POST['updateProduct'])) {
    $product_id = validate($_POST['product_id']);

    $productData = getById('products', $product_id);
    if (!$productData) {
        redirect('products.php', 'Hakuna bidhaa hiyo');
    }

    $name = validate($_POST['name']);
    $batch = validate($_POST['batch']);
    $quantity = validate($_POST['quantity']);
    $measure = validate($_POST['measure']);
    $buy_price = validate($_POST['buy_price']);
    $sell_price = validate($_POST['sell_price']);

    // Get the expenses arrays
    $expenses = isset($_POST['expenses']) ? $_POST['expenses'] : [];
    $expense_percentages = isset($_POST['expense_percentages']) ? $_POST['expense_percentages'] : [];

    // Combine multiple expenses into comma-separated strings
    $combined_expenses = [];
    $combined_percentages = [];
    
    foreach($expenses as $index => $expense) {
        if(!empty($expense) && !empty($expense_percentages[$index])) {
            $combined_expenses[] = validate($expense);
            $combined_percentages[] = validate($expense_percentages[$index]);
        }
    }

    $expense = implode(',', $combined_expenses);
    $expense_percentage = implode(',', $combined_percentages);

    $data = [
        'name' => $name,
        'batch' => $batch,
        'quantity' => $quantity,
        'measure' => $measure,
        'buy_price' => $buy_price,
        'sell_price' => $sell_price,
        'expense' => $expense,
        'expense_percentage' => $expense_percentage,
        'status' => isset($_POST['status']) ? 1 : 0
    ];

    $result = update('products', $product_id, $data);

    if ($result) {
        redirect('products-edit.php?id=' . $product_id, 'Bidhaa imerekebishwa!');
    } else {
        redirect('products-edit.php?id=' . $product_id, 'Something Went Wrong!');
    }
}



/**
 * CUSTOMERS CODE
 */

if (isset($_POST['saveCustomer'])) {
    $name = validate($_POST['name']);
    $email = validate($_POST['email']);
    $phone = validate($_POST['phone']);
    $status = isset($_POST['status']) ? 1 : 0;

    if ($name != '') {
        $emailCheck = mysqli_query($conn, "SELECT * FROM customers WHERE email='$email'");
        if ($emailCheck) {
            if (mysqli_num_rows($emailCheck) > 0) {
                redirect('customers.php', 'Email Already used by another user');
            }
        }

        $data = [
            'name' => $name,
            'email' => $email,
            'phone' => $phone,
            'status' => $status
        ];

        $result = insert('customers', $data);

        if ($result) {
            redirect('customers.php', 'Customer Created Successfully');
        } else {
            redirect('customers.php', 'Somthing Went Wrong');
        }
    } else {
        redirect('customers.php', 'Please fill required fields');
    }
}


if (isset($_POST['updateCustomer'])) {
    $customerId = validate($_POST['customerId']);

    $name = validate($_POST['name']);
    $email = validate($_POST['email']);
    $phone = validate($_POST['phone']);
    $status = isset($_POST['status']) ? 1 : 0;

    if ($name != '') {
        $emailCheck = mysqli_query($conn, "SELECT * FROM customers WHERE email='$email' AND id!='$customerId'");
        if ($emailCheck) {
            if (mysqli_num_rows($emailCheck) > 0) {
                redirect('customers-edit.php?id=' . $customerId, 'Email Already used by another user');
            }
        }

        $data = [
            'name' => $name,
            'email' => $email,
            'phone' => $phone,
            'status' => $status
        ];

        $result = update('customers', $customerId, $data);

        if ($result) {
            redirect('customers-edit.php?id=' . $customerId, 'Customer Updated Successfully');
        } else {
            redirect('customers-edit.php?id=' . $customerId, 'Somthing Went Wrong');
        }
    } else {
        redirect('customers-edit.php?id=' . $customerId, 'Please fill required fields');
    }
}
