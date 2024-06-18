<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="infoVeiculos.css">
    <title>Listagem de Veículos - Sync</title>
</head>
<body>
<nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.html">
                <img src="../img/Logo2.png" alt="">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="../Home/index.html">Início</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../Login/login.html">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Cadastro</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../Veiculos/veiculos.html">Veículos</a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="../Cadastro/cadastro.html">
                            <i class="fas fa-user fa-2xl"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container mt-5">
        <div class="card">
            <div class="card-header">
                <h2>Listagem de Veículos</h2>
            </div>
            <div class="card-body">
                <form method="GET" class="row mb-4">
                    <div class="col-md-3">
                        <label for="disponibilidade" class="form-label">Disponibilidade</label>
                        <select id="disponibilidade" name="disponibilidade" class="form-select">
                            <option value="">Todos</option>
                            <option value="Disponível">Disponível</option>
                            <option value="Indisponível">Indisponível</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="modelo" class="form-label">Modelo</label>
                        <input type="text" id="modelo" name="modelo" class="form-control" placeholder="Digite o modelo">
                    </div>
                    <div class="col-md-3 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">Filtrar</button>
                    </div>
                </form>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Modelo</th>
                            <th>Placa</th>
                            <th>Ano</th>
                            <th>Disponibilidade</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        // Código PHP para buscar dados dos veículos com filtros
                        $conn = pg_connect("host=localhost dbname=samueldb_Locadora user=postgres password=postgres");
                        if (!$conn) {
                            die("Conexão falhou: " . pg_last_error());
                        }

                        $conditions = [];
                        if (!empty($_GET['disponibilidade'])) {
                            $conditions[] = "disponibilidade = '" . pg_escape_string($conn, $_GET['disponibilidade']) . "'";
                        }
                        if (!empty($_GET['modelo'])) {
                            $conditions[] = "modelo ILIKE '%" . pg_escape_string($conn, $_GET['modelo']) . "%'";
                        }
                        
                        $query = "SELECT * FROM Carro";
                        if (count($conditions) > 0) {
                            $query .= " WHERE " . implode(' AND ', $conditions);
                        }

                        $result = pg_query($conn, $query);
                        if (!$result) {
                            die("Erro na consulta: " . pg_last_error());
                        }

                        while ($row = pg_fetch_assoc($result)) {
                            echo "<tr>
                                    <td>{$row['id_carro']}</td>
                                    <td>{$row['modelo']}</td>
                                    <td>{$row['placa']}</td>
                                    <td>{$row['ano']}</td>
                                    <td>{$row['disponibilidade']}</td>
                                    <td><button type='button' class='btn btn-primary btn-edit'>Editar</button></td>
                                    <td><button type='button' class='btn btn-danger btn-delete'>Excluir</button></td>
                                  </tr>";
                        }
                        
                        pg_free_result($result);
                        pg_close($conn);
                        ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal de Edição -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Editar Veículo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="editForm" method="POST" action="editarVeiculo.php">
                <div class="modal-body">
                    <input type="hidden" id="edit-id" name="id">
                    <div class="mb-3">
                        <label for="edit-modelo" class="form-label">Modelo</label>
                        <input type="text" class="form-control" id="edit-modelo" name="modelo">
                    </div>
                    <div class="mb-3">
                        <label for="edit-placa" class="form-label">Placa</label>
                        <input type="text" class="form-control" id="edit-placa" name="placa">
                    </div>
                    <div class="mb-3">
                        <label for="edit-ano" class="form-label">Ano</label>
                        <input type="text" class="form-control" id="edit-ano" name="ano">
                    </div>
                    <div class="mb-3">
                        <label for="edit-disponibilidade" class="form-label">Disponibilidade</label>
                        <input type="text" class="form-control" id="edit-disponibilidade" name="disponibilidade">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Salvar mudanças</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal de Exclusão -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Excluir Veículo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="deleteForm" method="POST" action="excluirVeiculo.php">
                <div class="modal-body">
                    <input type="hidden" id="delete-id" name="id">
                    <p>Tem certeza que deseja excluir este veículo?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-danger">Excluir</button>
                </div>
            </form>
        </div>
    </div>
</div>


</body>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const editModal = new bootstrap.Modal(document.getElementById('editModal'));
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));

        document.querySelectorAll('.btn-edit').forEach(button => {
            button.addEventListener('click', function () {
                const row = this.closest('tr');
                const id = row.querySelector('td:nth-child(1)').innerText;
                const modelo = row.querySelector('td:nth-child(2)').innerText;
                const placa = row.querySelector('td:nth-child(3)').innerText;
                const ano = row.querySelector('td:nth-child(4)').innerText;
                const tipo = row.querySelector('td:nth-child(5)').innerText;
                const disponibilidade = row.querySelector('td:nth-child(6)').innerText;

                document.getElementById('edit-id').value = id;
                document.getElementById('edit-modelo').value = modelo;
                document.getElementById('edit-placa').value = placa;
                document.getElementById('edit-ano').value = ano;
                document.getElementById('edit-tipo').value = tipo;
                document.getElementById('edit-disponibilidade').value = disponibilidade;

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
</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</html>
