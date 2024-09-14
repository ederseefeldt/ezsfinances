$('#formAccount').submit(function(event) {
    event.preventDefault();

    // Corrigido para .val() ao invés de .value()
    var accountId = $('#accountId').val().trim();
    var accountName = $('#accountName').val().trim();
    var accountValue = $('#accountValue').val().trim();

    const accountData = {
        accountId: accountId,
        accountName: accountName,
        accountValue: accountValue
    };

    if (accountName === '' || accountValue === '') {
        alert('Por favor, preencha todos os campos.');
        return;
    }

    var ajaxOptions = {
        type: 'POST',
        data: accountData,
        dataType: 'json',
        success: function(response) {
            console.log(response);
            $('#modalAccounts').modal('hide');
            $('#accountId').val('');
            $('#accountName').val('');
            $('#accountValue').val('');
        },
        error: function(xhr, status, error) {
            console.error('Erro ao adicionar/editar conta:', error, status);
            alert('Ocorreu um erro. Por favor, tente novamente.');
        }
    };

    if (accountId !== "") {
        ajaxOptions.url = '../models/account_model.php?action=editAccount';
    } else {
        ajaxOptions.url = '../models/account_model.php?action=addAccount';
    }

    $.ajax(ajaxOptions);
});

$('#formTransfer').submit(function(event) {
    event.preventDefault();

    // Corrigido para .val() ao invés de .value()
    var accountOriginId = $('#transactionAccountOrigin').val().trim();
    var accountDestinyId = $('#transactionAccountDestiny').val().trim();
    var transferValue = $('#transferValue').val().trim();

    const transferData = {
        accountOriginId: accountOriginId,
        accountDestinyId: accountDestinyId,
        transferValue: transferValue
    };

    console.log(transferData);

    if (accountName === '' || accountValue === '') {
        alert('Por favor, preencha todos os campos.');
        return;
    }

});

$('#tableAccountsModal').on('click', '#deleteBtn', function deleteCategory() {
    var accountId = $(this).val();

    console.log(accountId);

    $.ajax({
        type: 'GET',
        url: '../models/account_model.php?action=deleteAccount',
        data: { accountId: accountId },
        dataType: 'json',
        success: function(response) {
            console.log(response);
            $('#modalAccounts').modal('hide');
            $('#accountId').val('');
            $('#accountName').val('');
            $('#accountValue').val('');
        },
        error: function(xhr, status, error) {
            console.error('Erro ao obter detalhes do usuário:', error);
        }
    });
})

$('#tableAccountsModal').on('click', '#editBtn', function getCategoryData() {
    var accountId = $(this).val();

    $.ajax({
        type: 'GET',
        url: '../models/account_model.php?action=getAccountById',
        data: { accountId: accountId },
        dataType: 'json',
        success: function(response) {
            // console.log(response)
            $('#accountId').val(response[0].account_id);  
            $('#accountName').val(response[0].account_name);   
            $('#accountValue').val(response[0].account_value)
        },
        error: function(xhr, status, error) {
            console.error('Erro ao obter detalhes do usuário:', error);
        }
    });
})