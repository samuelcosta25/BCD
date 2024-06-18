
    document.addEventListener('DOMContentLoaded', function () {
        const editModal = new bootstrap.Modal(document.getElementById('editModal'));
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));

        document.querySelectorAll('.btn-edit').forEach(button => {
            button.addEventListener('click', function () {
                const row = this.closest('tr');
                const id = row.querySelector('td:nth-child(1)').innerText;
                const nome = row.querySelector('td:nth-child(2)').innerText;
                const sobrenome = row.querySelector('td:nth-child(3)').innerText;
                const endereco = row.querySelector('td:nth-child(4)').innerText;
                const cidade = row.querySelector('td:nth-child(5)').innerText;
                const estado = row.querySelector('td:nth-child(6)').innerText;
                const telefone = row.querySelector('td:nth-child(7)').innerText;
                const email = row.querySelector('td:nth-child(8)').innerText;

                document.getElementById('edit-id').value = id;
                document.getElementById('edit-nome').value = nome;
                document.getElementById('edit-sobrenome').value = sobrenome;
                document.getElementById('edit-endereco').value = endereco;
                document.getElementById('edit-cidade').value = cidade;
                document.getElementById('edit-estado').value = estado;
                document.getElementById('edit-telefone').value = telefone;
                document.getElementById('edit-email').value = email;

                editModal.show();
            });
        });

        document.querySelectorAll('.btn-delete').forEach(button => {
            button.addEventListener('click', function () {
                const row = this.closest('tr');
                const id = row.querySelector('td:nth-child(1)').innerText;
                
                document.getElementById('delete-id').value = id;

                deleteModal.show();
            });
        });
    });