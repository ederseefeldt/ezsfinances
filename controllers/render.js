var tableTransactions;

$(document).ready(function() {
    const date = new Date();
    const firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
    const lastDay = new Date();
    
    const formattedInitialDate = firstDay.toISOString().split('T')[0];
    const formattedFinalDate = lastDay.toISOString().split('T')[0];
    
    document.getElementById('initialDateInput').value = formattedInitialDate;
    document.getElementById('finalDateInput').value = formattedFinalDate;

    getTransactions();
});

function getTransactions() {
    if ($.fn.DataTable.isDataTable('#tableTransactions')) {
        tableTransactions.destroy();
    }

    tableTransactions = $('#tableTransactions').DataTable({
        searching: false,
        ordering: true,
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
            { data: 'category_target' },
            { data: 'category_transactions' },
            { data: 'remaining_target' },
        ]
    });
}