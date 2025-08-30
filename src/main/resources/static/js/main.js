document.addEventListener('DOMContentLoaded', function() {
    const burgerMenu = document.getElementById('burger-menu');
    const sidebar = document.getElementById('sidebar');

    if (burgerMenu && sidebar) {
        burgerMenu.addEventListener('click', function() {
            sidebar.classList.toggle('active');
        });
    }
});

// Função para filtrar tabelas
function filtrarTabela() {
    const input = document.getElementById('search-input');
    const filter = input.value.toUpperCase();
    const table = document.getElementById('books-table');
    const tr = table.getElementsByTagName('tr');

    // Percorre todas as linhas da tabela e esconde as que não correspondem à pesquisa
    for (let i = 1; i < tr.length; i++) { // Começa em 1 para ignorar o cabeçalho (thead)
        let td = tr[i].getElementsByTagName('td')[0]; // Coluna 0 é a do Título
        if (td) {
            let txtValue = td.textContent || td.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

// Associa a função ao campo de busca se ele existir na página
const searchInput = document.getElementById('search-input');
if (searchInput) {
    searchInput.addEventListener('keyup', filtrarTabela);
}