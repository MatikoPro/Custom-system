<?php
// Place this at the top of your file
function getExpenseTypes() {
    return [
        'mikopo' => 'Mikopo',
        'wafanyakazi' => 'Wafanyakazi',
        'mengineyo' => 'Mengineyo'
    ];
}

// Get the number of expense fields to show (default to 1 if not set)
$expense_count = isset($_POST['expense_count']) ? (int)$_POST['expense_count'] : 1;
?>

<?php include('includes/header.php'); ?>
<div class="container-fluid px-4">
    <div class="card mt-4 shadow-sm">
        <div class="card-header">
            <h4 class="mb-0">Ongeza Bidhaa
                <a href="products.php" class="btn btn-danger float-end">Back</a>
            </h4>
        </div>
        <div class="card-body">
            <?php alertMessage(); ?>
            <form action="code.php" method="POST" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="">Jina *</label>
                        <input type="text" name="name" required class="form-control" />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="">Batch Na. *</label>
                        <input type="text" name="batch" required class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="">Idadi *</label>
                        <input type="text" name="quantity" required class="form-control" />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="">Kipimo</label>
                        <input type="text" name="measure" class="form-control" />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="">Bei ya Kununua *</label>
                        <input type="text" name="buy_price" required class="form-control" />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="">Bei ya Kuuza *</label>
                        <input type="text" name="sell_price" required class="form-control" />
                    </div>

                    <!-- Dynamic Expenses Section -->
                    <div class="col-12 mb-3">
                        <label class="mb-2">Gharama za Matumizi *</label>
                        <div id="expenses-container">
                            <?php 
                            $expenseTypes = getExpenseTypes();
                            for($i = 0; $i < $expense_count; $i++): 
                            ?>
                                <div class="row mb-2">
                                    <div class="col-md-5">
                                        <select name="expenses[]" class="form-control" required>
                                            <option value="">--Chagua Matumizi--</option>
                                            <?php foreach($expenseTypes as $value => $label): ?>
                                                <option value="<?php echo $value; ?>"><?php echo $label; ?></option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>
                                    <div class="col-md-5">
                                        <input type="number" name="expense_percentages[]" class="form-control" 
                                               placeholder="Asilimia ya Gharama" required 
                                               min="0" max="100" step="0.01" />
                                    </div>
                                    <div class="col-md-2">
                                        <?php if($i > 0): ?>
                                            <button type="button" class="btn btn-danger remove-expense">Ondoa</button>
                                        <?php endif; ?>
                                    </div>
                                </div>
                            <?php endfor; ?>
                        </div>
                        
                        <!-- Hidden field to track number of expense fields -->
                        <input type="hidden" name="expense_count" id="expense_count" value="<?php echo $expense_count; ?>">
                        
                        <button type="button" class="btn btn-success mt-2" id="add-expense">Ongeza Gharama</button>
                    </div>

                    <div class="col-md-12 mb-3 text-end">
                        <br />
                        <button type="submit" name="saveProduct" class="btn btn-primary">Save</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const container = document.getElementById('expenses-container');
    const addButton = document.getElementById('add-expense');
    const expenseCountInput = document.getElementById('expense_count');
    
    addButton.addEventListener('click', function() {
        const expenseCount = parseInt(expenseCountInput.value);
        
        // Create new row using PHP-generated HTML structure
        const row = document.createElement('div');
        row.className = 'row mb-2';
        row.innerHTML = `
            <div class="col-md-5">
                <select name="expenses[]" class="form-control" required>
                    <option value="">--Chagua Matumizi--</option>
                    <?php foreach($expenseTypes as $value => $label): ?>
                        <option value="<?php echo $value; ?>"><?php echo $label; ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="col-md-5">
                <input type="number" name="expense_percentages[]" class="form-control" 
                       placeholder="Asilimia ya Gharama" required 
                       min="0" max="100" step="0.01" />
            </div>
            <div class="col-md-2">
                <button type="button" class="btn btn-danger remove-expense">Ondoa</button>
            </div>
        `;
        
        container.appendChild(row);
        expenseCountInput.value = expenseCount + 1;
    });
    
    // Remove expense row
    container.addEventListener('click', function(e) {
        if (e.target.classList.contains('remove-expense')) {
            e.target.closest('.row').remove();
            expenseCountInput.value = parseInt(expenseCountInput.value) - 1;
        }
    });
    
    // Form validation
    document.querySelector('form').addEventListener('submit', function(e) {
        const percentages = [...document.getElementsByName('expense_percentages[]')]
            .map(input => parseFloat(input.value) || 0);
        
        const total = percentages.reduce((sum, current) => sum + current, 0);
        
        if (total > 100) {
            e.preventDefault();
            alert('Jumla ya asilimia haiwezi kuzidi 100%');
        }
    });
});
</script>

<?php include('includes/footer.php'); ?>