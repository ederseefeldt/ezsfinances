var tableTransactions;
var tableModalCategory;
var tableModalAccount;

var categories;
var accounts;

$(document).ready(function() {
    const date = new Date();
    const firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
    const lastDay = new Date();
    
    const formattedInitialDate = firstDay.toISOString().split('T')[0];
    const formattedFinalDate = lastDay.toISOString().split('T')[0];
    
    document.getElementById('initialDateTransaction').value = formattedInitialDate;
    document.getElementById('finalDateTransaction').value = formattedFinalDate;

    formFilter = {
        accountTransaction: "all",
        categoryTransaction: "all",
        methodTransaction: "all",
        initialDateTransaction: formattedInitialDate,
        finalDateTransaction: formattedFinalDate
    }

    $.ajax({
        type: 'GET',
        url: '../models/category_model.php?action=getCategory',
        dataType: 'json',
        success: function(response) {
            // categories = response;
            response.forEach(function(category) {
                $('#categoryTransaction').append(new Option(category.category_name, category.category_id));
            });
        },
        error: function(xhr, status, error) {
            console.error('Ocorreu um erro na solicitação AJAX:', xhr.status);
        }
    });

    $.ajax({
        type: 'GET',
        url: '../models/account_model.php?action=getAccount',
        dataType: 'json',
        success: function(response) {
            // accounts = response;
            response.forEach(function(account) {
                $('#accountTransaction').append(new Option(account.account_name, account.account_id));
            });
        },
        error: function(xhr, status, error) {
            console.error('Ocorreu um erro na solicitação AJAX:', xhr.status)
        }
    });

    getTransactions(formFilter);
    getPatrimony(formFilter);
});

function getTransactions(formFilter) {
    if ($.fn.DataTable.isDataTable('#tableTransactions')) {
        tableTransactions.destroy();
    }
    
    tableTransactions = $('#tableTransactions').DataTable({
        searching: false,
        ordering: false,
        info: false,
        paging: false,
        autoWidth: false,
        language: {
            zeroRecords: "Nenhuma transação cadastrada!",
            infoEmpty: "Nenhum registro disponível",
        },
        columns: [
            {
                data: 'transaction_date',
                render: function(data, type, row) {
                    if (data) {
                        // Dividimos a string no formato YYYY-MM-DD para formatar como DD/MM/YYYY
                        var dateParts = data.split('-');
                        var year = dateParts[0];
                        var month = dateParts[1];
                        var day = dateParts[2];
            
                        return day + '/' + month + '/' + year;
                    }
                    return data; // Caso não haja data, retorna como está
                }
            },            
            {
                data: 'transaction_value',
                render: function(data, type, row) {
                    // Formata o valor para duas casas decimais
                    return 'R$ ' + parseFloat(data).toFixed(2);
                }
            },
            { data: 'transaction_description' },
            { data: 'category_name' },
            {
                data: null,
                render: function(data, type, row) {
                    return '<div class="modal-actions">' +
                        '<button class="modal-action-btn" id="editBtn" value="' + data.transaction_id + '"><i class="fa-solid fa-pen-to-square"></i></button>' +
                        '<button class="modal-action-btn" id="viewBtn" value="' + data.transaction_id + '"><i class="fa-solid fa-eye"></i></button>' +
                        '<button class="modal-action-btn" id="deleteBtn" value="' + data.transaction_id + '"><i class="fa-solid fa-trash"></i></button>' + 
                    '</div>';
                }
            }
        ]
    });

    $.ajax({
        type: 'GET',
        url: '../models/transaction_model.php?action=getTransactions',
        data: formFilter,
        dataType: 'json',
        success: function(response) {
            console.log(response);
            tableTransactions.clear();
            tableTransactions.rows.add(response);
            tableTransactions.draw();

            if (response = []) {
                tableTransactions.clear();
            }
        },
        error: function(xhr, response, status, error) {
            console.log(response);
            console.error('Ocorreu um erro na solicitação AJAX:', xhr.status);
        }
    });

    $.ajax({
        type: 'GET',
        url: '../models/transaction_model.php?action=getTransactionsValues',
        data: formFilter,
        dataType: 'json',
        success: function(response) {
            console.log(response);
            if (response && response.length > 0) {
                // Se houver dados no response
                $('#entries').html("R$ " + parseFloat(response[0].entries || 0).toFixed(2));
                $('#exits').html("R$ " + parseFloat(response[0].exits || 0).toFixed(2));
                $('#balance').html("R$ " + parseFloat(response[0].balance || 0).toFixed(2));
            } else {
                // Se não houver dados ou se os valores forem NaN, define tudo como 0
                $('#entries').html("R$ 0.00");
                $('#exits').html("R$ 0.00");
                $('#balance').html("R$ 0.00");
            }
        },
        error: function(xhr, status, error) {
            console.error('Ocorreu um erro na solicitação AJAX:', xhr.status);
            $('#entries').html("R$ 0.00");
            $('#exits').html("R$ 0.00");
            $('#balance').html("R$ 0.00");
        }
    });    
}

function getPatrimony() {
    var accountPatrimony = 0;
    var investimentPatrimony = 0; // Defina aqui o valor do patrimônio de investimentos, se necessário
    var totalPatrimony;

    $.ajax({
        type: 'GET',
        url: '../models/account_model.php?action=sumAccountValues',
        dataType: 'json',
        success: function(response) {
            console.log(response);

            if (response && response.length > 0 && response[0].total_accounts_value) {
                accountPatrimony = parseFloat(response[0].total_accounts_value);
            }

            $('#accountPatrimony').html(`R$ ${accountPatrimony.toFixed(2)}`);

            totalPatrimony = accountPatrimony + investimentPatrimony;

            $('#totalPatrimony').html(`R$ ${totalPatrimony.toFixed(2)}`);
        },
        error: function(xhr, status, error) {
            console.error('Ocorreu um erro na solicitação AJAX:', xhr.status);
        }
    });
}

//No momento que o modal é aberto, puxa os dados de categorias do banco
$('#modalCategories').on('shown.bs.modal', function() {
    if ($.fn.DataTable.isDataTable('#tableCategoriesModal')) {
        tableModalCategory.destroy();
    }

    tableModalCategory = $('#tableCategoriesModal').DataTable({
        searching: true,
        ordering: false,
        info: false,
        paging: false,
        autoWidth: false,
        language: {
            zeroRecords: "Nenhum registro encontrado",
            infoEmpty: "Nenhum registro disponível",
            search: "",
            searchPlaceholder: 'Busque por categoria...'
        },
        columns: [
            { data: 'category_name' },
            {
                data: 'category_target',
                render: function(data, type, row) {
                    return 'R$ ' + parseFloat(data).toFixed(2);
                }
            },
            {
                data: null,
                render: function(data, type, row) {
                    return '<div class="modal-actions">' +
                        '<button class="modal-action-btn" id="editBtn" value="' + data.category_id + '"><i class="fa-solid fa-pen-to-square"></i></button>' +
                        '<button class="modal-action-btn" id="deleteBtn" value="' + data.category_id + '"><i class="fa-solid fa-trash"></i></button>' +
                    '</div>';
                }
            }
        ]
    });

    $.ajax({
        type: 'GET',
        url: '../models/category_model.php?action=getCategory',
        dataType: 'json',
        success: function(response) {
            //console.log(response);
            tableModalCategory.clear();
            tableModalCategory.rows.add(response);
            tableModalCategory.draw();
        },
        error: function(xhr, status, error) {
            console.error('Ocorreu um erro na solicitação AJAX:', xhr.status);
        }
    });
});

//No momento que o modal é aberto, puxa os dados de contas do banco
$('#modalAccounts').on('shown.bs.modal', function() {
    if ($.fn.DataTable.isDataTable('#tableAccountsModal')) {
        tableModalAccount.destroy();
    }

    tableModalAccount = $('#tableAccountsModal').DataTable({
        searching: true,
        ordering: true,
        info: false,
        paging: false,
        autoWidth: false,
        language: {
            zeroRecords: "Nenhum registro encontrado",
            infoEmpty: "Nenhum registro disponível",
            search: "",
            searchPlaceholder: 'Busque por banco...'
        },
        columns: [
            { data: 'account_name' },
            {
                data: 'account_value',
                render: function(data, type, row) {
                    // Formata o valor para duas casas decimais
                    return 'R$ ' + parseFloat(data).toFixed(2);
                }
            },
            {
                data: null,
                render: function(data, type, row) {
                    return '<div class="modal-actions">' +
                        '<button class="modal-action-btn" id="editBtn" value="' + data.account_id + '"><i class="fa-solid fa-pen-to-square"></i></button>' +
                        '<button class="modal-action-btn" id="deleteBtn" value="' + data.account_id + '"><i class="fa-solid fa-trash"></i></button>' +
                    '</div>';
                }
            }
        ]
    });

    $.ajax({
        type: 'GET',
        url: '../models/account_model.php?action=getAccount',
        dataType: 'json',
        success: function(response) {
            // console.log(response);
            tableModalAccount.clear()
            tableModalAccount.rows.add(response)
            tableModalAccount.draw()
        },
        error: function(xhr, status, error) {
            console.error('Ocorreu um erro na solicitação AJAX:', xhr.status)
        }
    });
});

$('#modalTransaction').on('show.bs.modal', function() {
    // Limpa o select
    $('#transactionCategory').empty();
    $('#transactionAccount').empty();

    // Faz a requisição AJAX para buscar as categorias
    $.ajax({
        type: 'GET',
        url: '../models/category_model.php?action=getCategory',
        dataType: 'json',
        success: function(response) {
            response.forEach(function(category) {
                $('#transactionCategory').append(new Option(category.category_name, category.category_id));
            });
        },
        error: function(xhr, status, error) {
            console.error('Erro ao buscar categorias:', error);
        }
    });

    // Faz a requisição AJAX para buscar as contas
    $.ajax({
        type: 'GET',
        url: '../models/account_model.php?action=getAccount',
        dataType: 'json',
        success: function(response) {
            response.forEach(function(account) {
                $('#transactionAccount').append(new Option(account.account_name, account.account_id));
            });
        },
        error: function(xhr, status, error) {
            console.error('Erro ao buscar contas:', error);
        }
    });
})

$('#formFilter').submit(function(event) {
    event.preventDefault();

    var initialDateTransaction = $('#initialDateTransaction').val().trim();
    var finalDateTransaction = $('#finalDateTransaction').val().trim();
    var methodTransaction = $('#methodTransaction').val().trim();
    var accountTransaction = $('#accountTransaction').val().trim();
    var categoryTransaction = $('#categoryTransaction').val().trim();

    formFilter = {
        accountTransaction: accountTransaction,
        categoryTransaction: categoryTransaction,
        methodTransaction: methodTransaction,
        initialDateTransaction: initialDateTransaction,
        finalDateTransaction: finalDateTransaction
    };

    // console.log(formFilter);
    getTransactions(formFilter);
})

function filterTransactions() {
    var initialDateTransaction = $('#initialDateTransaction').val().trim();
    var finalDateTransaction = $('#finalDateTransaction').val().trim();
    var methodTransaction = $('#methodTransaction').val().trim();
    var accountTransaction = $('#accountTransaction').val().trim();
    var categoryTransaction = $('#categoryTransaction').val().trim();

    formFilter = {
        accountTransaction: accountTransaction,
        categoryTransaction: categoryTransaction,
        methodTransaction: methodTransaction,
        initialDateTransaction: initialDateTransaction,
        finalDateTransaction: finalDateTransaction
    };

    // console.log(formFilter);
    getTransactions(formFilter);
}

$('#setDateInput').click(function() {
    const today = new Date();
    const formattedDate = today.toISOString().split('T')[0];

    $('#transactionDate').val(formattedDate);
});

$('#modalTarget').on('shown.bs.modal', function() {
    const months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", 
        "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];

    let currentMonthIndex;
    let firstDayOfMonth, lastDayOfMonth;

    function getCurrentMonthIndex() {
        const today = new Date();
        return today.getMonth(); // Retorna o índice do mês atual (0 para janeiro, 11 para dezembro)
    }

    // Função que retorna o primeiro dia do mês
    function getFirstDayOfMonth(year, monthIndex) {
        return new Date(year, monthIndex, 1);
    }

    // Função que retorna o último dia do mês
    function getLastDayOfMonth(year, monthIndex) {
        return new Date(year, monthIndex + 1, 0);
    }

    // Função que formata uma data para "yyyy/mm/dd"
    function formatDate(date) {
        const day = String(date.getDate()).padStart(2, '0');
        const month = String(date.getMonth() + 1).padStart(2, '0'); // Mês começa em 0
        const year = date.getFullYear();
        return `${year}/${month}/${day}`;
    }

    // Função que atualiza o display do mês e as datas do primeiro e último dia
    function updateMonthDisplay() {
        const currentYear = new Date().getFullYear();
        const firstDay = getFirstDayOfMonth(currentYear, currentMonthIndex);
        const lastDay = getLastDayOfMonth(currentYear, currentMonthIndex);
        
        // Exibe o mês atual
        $('#currentMonth').html(months[currentMonthIndex]);
        
        // console.log(formatDate(firstDay) + formatDate(lastDay))
        firstDayOfMonth = formatDate(firstDay);
        lastDayOfMonth = formatDate(lastDay)

        getTargets(firstDayOfMonth, lastDayOfMonth);
    }

    // Define o mês atual quando o modal é aberto
    currentMonthIndex = getCurrentMonthIndex();
    updateMonthDisplay();

    // Avança o mês
    $('#nextMonth').on('click', function() {
        currentMonthIndex = (currentMonthIndex + 1) % 12;
        updateMonthDisplay();
    });

    // Regride o mês
    $('#previousMonth').on('click', function() {
        currentMonthIndex = (currentMonthIndex - 1 + 12) % 12;
        updateMonthDisplay();
    });


    function getTargets(firstDayOfMonth, lastDayOfMonth) {
        if ($.fn.DataTable.isDataTable('#tableTargets')) {
            tableModal.destroy();
        }
    
        tableModal = $('#tableTargets').DataTable({
            searching: false,
            ordering: true,
            info: false,
            paging: false,
            autoWidth: false,
            language: {
                zeroRecords: "Nenhum registro encontrado",
                infoEmpty: "Nenhum registro disponível",
            },
            columns: [
                { data: 'category_name' },
                {
                    data: 'category_target',
                    render: function(data, type, row) {
                        // Formata o valor para duas casas decimais
                        return 'R$ ' + parseFloat(data).toFixed(2);
                    }
                },
                {
                    data: 'exits',
                    render: function(data, type, row) {
                        // Formata o valor para duas casas decimais
                        return 'R$ ' + parseFloat(data).toFixed(2);
                    }
                },
                {
                    data: 'diference',
                    render: function(data, type, row) {
                        // Formata o valor para duas casas decimais
                        return 'R$ ' + parseFloat(data).toFixed(2);
                    }
                },
            ]
        });
    
        $.ajax({
            type: 'GET',
            url: '../models/transaction_model.php?action=getTransactionsByCategory',
            data: {
                firstDay: firstDayOfMonth,
                lastDay: lastDayOfMonth
            },
            dataType: 'json',
            success: function(response) {
                console.log('Dados recebidos: ', response);
                tableModal.clear();
                tableModal.rows.add(response);
                tableModal.draw();
            },
            error: function(xhr, status, error) {
                console.error('Ocorreu um erro na solicitação AJAX:', xhr.status, xhr.responseText);
            }
        });    
    }
});

$('#modalTransfer').on('show.bs.modal', function() {
    // Limpa o select
    $('#transactionAccountOrigin').empty();
    $('#transactionAccountDestiny').empty();

    // Faz a requisição AJAX para buscar as contas
    $.ajax({
        type: 'GET',
        url: '../models/account_model.php?action=getAccount',
        dataType: 'json',
        success: function(response) {
            response.forEach(function(account) {
                $('#transactionAccountOrigin').append(new Option(account.account_name, account.account_id));
                $('#transactionAccountDestiny').append(new Option(account.account_name, account.account_id));
            });
        },
        error: function(xhr, status, error) {
            console.error('Erro ao buscar contas:', error);
        }
    });
})