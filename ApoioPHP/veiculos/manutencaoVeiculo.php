<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
    rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="manutencaoVeiculo.css">
    <title>Consulta de Manutenções - Sync</title>
</head>

<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.html">
                <img src="../img/Logo2.png" alt="">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="index.html">Início</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../Login/login.html">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../Funcionarios/funcionarios.html">Funcionários</a>
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
                <h2>Consulta de Manutenções</h2>
            </div>
            <div class="card-body">
                <form method="GET" class="row mb-4">
                    <div class="col-md-4">
                        <label for="carro" class="form-label">Nome do Carro</label>
                        <input type="text" id="carro" name="carro" class="form-control" placeholder="Digite o nome do carro">
                    </div>
                    <div class="col-md-3">
                        <label for="data_inicio" class="form-label">Data de Início</label>
                        <input type="date" id="data_inicio" name="data_inicio" class="form-control">
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">Filtrar</button>
                    </div>
                </form>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID Manutenção</th>
                            <th>Descrição</th>
                            <th>Responsável</th>
                            <th>Data de Manutenção</th>
                            <th>Tipo de Manutenção</th>
                            <th>Custo</th>
                            <th>Carro</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        // Código PHP para buscar dados da tabela Manutencao com JOINs e Filtros
                        $conn = pg_connect("host=localhost dbname=locadorazz user=postgres password=postgres");
                        if (!$conn) {
                            die("Conexão falhou: " . pg_last_error());
                        }

                        // Parâmetros de paginação
                        $limit = 15; // Número de registros por página
                        $page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
                        $offset = ($page - 1) * $limit;

                        $conditions = [];
                        if (!empty($_GET['carro'])) {
                            $conditions[] = "Carro.Modelo ILIKE '%" . pg_escape_string($conn, $_GET['carro']) . "%'";
                        }
                        if (!empty($_GET['data_inicio'])) {
                            $conditions[] = "Manutencao.data_manutencao >= '" . pg_escape_string($conn, $_GET['data_inicio']) . "'";
                        }
                        if (!empty($_GET['data_fim'])) {
                            $conditions[] = "Manutencao.data_manutencao <= '" . pg_escape_string($conn, $_GET['data_fim']) . "'";
                        }

                        // Contar o número total de registros para paginação
                        $count_query = "SELECT COUNT(*) AS total FROM Manutencao
                                        JOIN Carro ON Manutencao.id_carro = Carro.id_carro";
                        if (count($conditions) > 0) {
                            $count_query .= " WHERE " . implode(' AND ', $conditions);
                        }
                        $count_result = pg_query($conn, $count_query);
                        $total_records = pg_fetch_result($count_result, 0, 'total');
                        $total_pages = ceil($total_records / $limit);

                        // Consulta principal com LIMIT e OFFSET
                        $query = "SELECT Manutencao.id_manutencao, Manutencao.descricao, Manutencao.rh, Manutencao.data_manutencao, 
                                         Manutencao.tipo_manutencao, Manutencao.custo, Carro.Modelo AS carro
                                  FROM Manutencao
                                  JOIN Carro ON Manutencao.id_carro = Carro.id_carro";
                        if (count($conditions) > 0) {
                            $query .= " WHERE " . implode(' AND ', $conditions);
                        }
                        $query .= " LIMIT $limit OFFSET $offset";

                        $result = pg_query($conn, $query);
                        if (!$result) {
                            die("Erro na consulta: " . pg_last_error());
                        }

                        while ($row = pg_fetch_assoc($result)) {
                            echo "<tr>
                                    <td>{$row['id_manutencao']}</td>
                                    <td>{$row['descricao']}</td>
                                    <td>{$row['rh']}</td>
                                    <td>{$row['data_manutencao']}</td>
                                    <td>{$row['tipo_manutencao']}</td>
                                    <td>{$row['custo']}</td>
                                    <td>{$row['carro']}</td>
                                  </tr>";
                        }
                        pg_free_result($result);
                        pg_close($conn);
                        ?>
                    </tbody>
                </table>
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-center">
                        <?php if ($page > 1) : ?>
                            <li class="page-item"><a class="page-link" href="?<?php echo http_build_query(array_merge($_GET, ['page' => $page - 1])); ?>">Anterior</a></li>
                        <?php endif; ?>
                        <?php for ($i = 1; $i <= $total_pages; $i++) : ?>
                            <li class="page-item <?php if ($i == $page) echo 'active'; ?>"><a class="page-link" href="?<?php echo http_build_query(array_merge($_GET, ['page' => $i])); ?>"><?php echo $i; ?></a></li>
                        <?php endfor; ?>
                        <?php if ($page < $total_pages) : ?>
                            <li class="page-item"><a class="page-link" href="?<?php echo http_build_query(array_merge($_GET, ['page' => $page + 1])); ?>">Próxima</a></li>
                        <?php endif; ?>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>