$('#formTransaction').submit(function(event) {
    event.preventDefault();

    // Obtém os valores dos campos
    var transactionId = $('#transactionId').val().trim();
    var transactionMethod = $('#transactionMethod').val().trim();
    var transactionCategory = $('#transactionCategory').val().trim();
    var transactionAccount = $('#transactionAccount').val().trim();
    var transactionDate = $('#transactionDate').val().trim();
    var transactionValue = parseFloat($('#transactionValue').val().trim());
    var transactionDescription = $('#transactionDescription').val().trim();
    var transactionType = $('input[name="value-radio"]:checked').val().trim();

    // Verifica se todos os campos obrigatórios estão preenchidos
    if (!transactionMethod || !transactionCategory || !transactionAccount || !transactionDate || isNaN(transactionValue) || !transactionType) {
        alert('Por favor, preencha todos os campos obrigatórios corretamente.');
        return;
    }

    // Monta o objeto de dados
    const transactionData = {
        transactionMethod: transactionMethod,
        transactionCategory: transactionCategory,
        transactionAccount: transactionAccount,
        transactionDate: transactionDate,
        transactionValue: transactionValue,
        transactionDescription: transactionDescription,
        transactionType: transactionType
    };

    console.log('Dados da transação:', transactionData);

    // Configurações AJAX
    var ajaxOptions = {
        type: 'POST',
        data: transactionData,
        dataType: 'json',
        success: function(response) {
            console.log('Resposta do servidor:', response);
            $('#modalTransaction').modal('hide');
            
            // Limpa os campos do formulário após sucesso
            $('#transactionId').val('');
            // $('#transactionDate').val('');
            $('#transactionValue').val('');
            $('#transactionDescription').val('');
            
            filterTransactions();
            getPatrimony();
        },
        error: function(xhr, status, error) {
            console.error('Erro ao adicionar/editar transação:', error, status);
            alert('Ocorreu um erro ao salvar a transação. Por favor, tente novamente.');
        }
    };

    // Verifica se está em modo de edição ou adição
    if (transactionId !== "") {
        ajaxOptions.url = '../models/transaction_model.php?action=editTransaction';
        transactionData.transactionId = transactionId;  // Adiciona o ID no modo de edição
    } else {
        ajaxOptions.url = '../models/transaction_model.php?action=addTransaction';
    }

    // Envia o AJAX
    $.ajax(ajaxOptions);
});

$('#tableTransactions').on('click', '#deleteBtn', function deleteCategory() {
    var transactionId = $(this).val();

    $.ajax({
        type: 'GET',
        url: '../models/transaction_model.php?action=deleteTransaction',
        data: { transactionId: transactionId },
        dataType: 'json',
        success: function() {
            filterTransactions();
            getPatrimony();
        },
        error: function(xhr, status, error) {
            console.error('Erro ao obter detalhes do usuário:', error);
        }
    });
})