$('#formCategory').submit(function(event) {
    event.preventDefault();

    // Obtém os valores dos campos do formulário
    var categoryName = $('#categoryName').val().trim();
    var categoryTarget = $('#categoryTarget').val().trim();
    var categoryId = $('#categoryId').val().trim();

    // Objeto com os dados da categoria
    const categoryData = {
        categoryName: categoryName,
        categoryTarget: categoryTarget,
        categoryId: categoryId
    };

    console.log(categoryData);

    // Verifica se os campos obrigatórios estão preenchidos
    if (categoryName === '' || categoryTarget === '') {
        alert('Por favor, preencha todos os campos.');
        return;
    }

    // Define as opções da requisição AJAX
    var ajaxOptions = {
        type: 'POST',
        data: categoryData,
        dataType: 'json',
        success: function(response) {
            console.log('Resposta do servidor:', response);

            // Fecha o modal e limpa os campos após o sucesso
            $('#modalCategories').modal('hide');
            $('#categoryName').val('');
            $('#categoryTarget').val('');
            $('#categoryId').val('');
        },
        error: function(xhr, status, error) {
            console.error('Erro ao adicionar/editar categoria:', error, status, xhr.responseText);
            alert('Ocorreu um erro. Por favor, tente novamente.');
        }
    };

    // Caso o formulario tenha sido enviado com o categoryId, o algoritmo identifica que é uma edição
    if (categoryId !== "") {
        ajaxOptions.url = '../models/category_model.php?action=editCategory';
    } else {
        ajaxOptions.url = '../models/category_model.php?action=addCategory';
    }

    $.ajax(ajaxOptions);
});

$('#tableCategoriesModal').on('click', '#deleteBtn', function deleteCategory() {
    var categoryId = $(this).val();

    $.ajax({
        type: 'GET',
        url: '../models/category_model.php?action=deleteCategory',
        data: { categoryId: categoryId },
        dataType: 'json',
        success: function() {
            $('#modalCategories').modal('hide');
            $('#categoryName').val('');   
            $('#categoryTarget').val('')
        },
        error: function(xhr, status, error) {
            console.error('Erro ao obter detalhes do usuário:', error);
        }
    });
})

$('#tableCategoriesModal').on('click', '#editBtn', function getCategoryData() {
    var categoryId = $(this).val();

    $.ajax({
        type: 'GET',
        url: '../models/category_model.php?action=getCategoryById',
        data: { categoryId: categoryId }, // Use userId como chave para o parâmetro
        dataType: 'json',
        success: function(response) {
            //console.log(response)
            // Preenche o form do modal com as informações buscadas no banco e chama a função para editar
            $('#categoryId').val(response[0].category_id);  
            $('#categoryName').val(response[0].category_name);   
            $('#categoryTarget').val(response[0].category_target)
        },
        error: function(xhr, status, error) {
            console.error('Erro ao obter detalhes do usuário:', error);
        }
    });
})