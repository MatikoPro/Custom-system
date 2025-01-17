<?php include('includes/header.php'); ?>

<div class="container-fluid px-4">
    <div class="card mt-4 shadow-sm">
        <div class="card-header">
            <h4 class="mb-0">Ongeza Mteja
                <a href="customers.php" class="btn btn-danger float-end">Back</a>
            </h4>
        </div>
        <div class="card-body">

            <?php alertMessage(); ?>

            <form action="code.php" method="POST">

                <div class="row">
                    <div class="col-md-12 mb-3">
                        <label for="">Jina *</label>
                        <input type="text" name="name" required class="form-control" />
                    </div>

                    <div class="col-md-12 mb-3">
                        <label for="">Simu Na. *</label>
                        <input type="number" name="phone" class="form-control" />
                    </div>
                    <div class="col-md-12 mb-3 text-end">
                        <br />
                        <button type="submit" name="saveCustomer" class="btn btn-primary">Save</button>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

<?php include('includes/footer.php'); ?>