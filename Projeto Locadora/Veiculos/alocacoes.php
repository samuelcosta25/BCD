<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="alocacoes.css">
    <title>Listagem de Locações - Sync</title>
</head>

<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="../Home/index.html">
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
                <h2>Listagem de Locações</h2>
            </div>
            <div class="card-body">
                <form method="GET" class="row mb-4">
                    <div class="col-md-4">
                        <label for="cliente" class="form-label">Nome do Cliente</label>
                        <input type="text" id="cliente" name="cliente" class="form-control" placeholder="Digite o nome do cliente">
                    </div>
                    <div class="col-md-3">
                        <label for="data_inicio" class="form-label">Data de Início</label>
                        <input type="date" id="data_inicio" name="data_inicio" class="form-control">
                    </div>
                    <div class="col-md-3">
                        <label for="data_fim" class="form-label">Data de Término</label>
                        <input type="date" id="data_fim" name="data_fim" class="form-control">
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">Filtrar</button>
                    </div>
                </form>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID Aluguel</th>
                            <th>Data de Aluguel</th>
                            <th>Data de Devolução</th>
                            <th>Valor Total</th>
                            <th>Carro</th>
                            <th>Cliente</th>
                            <th>Média de Dias Alugado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        // Código PHP para buscar dados da tabela Locacao com JOINs e Filtros
                        $conn = pg_connect("host=localhost dbname=samueldb_Locadora user=postgres password=postgres");
                        if (!$conn) {
                            die("Conexão falhou: " . pg_last_error());
                        }

                        $conditions = [];
                        if (!empty($_GET['cliente'])) {
                            $conditions[] = "Clientes.nome ILIKE '%" . pg_escape_string($conn, $_GET['cliente']) . "%'";
                        }
                        if (!empty($_GET['data_inicio'])) {
                            $conditions[] = "Locacao.data_locacao >= '" . pg_escape_string($conn, $_GET['data_inicio']) . "'";
                        }
                        if (!empty($_GET['data_fim'])) {
                            $conditions[] = "Locacao.data_locacao <= '" . pg_escape_string($conn, $_GET['data_fim']) . "'";
                        }

                        $query = "SELECT Locacao.id_locacao, Locacao.data_locacao, Locacao.data_devolucao, Locacao.valor_total, 
                                         Carro.Modelo AS carro, Clientes.nome AS cliente,
                                         (Locacao.data_devolucao - Locacao.data_locacao) AS dias_alugado,
                                         AVG(Locacao.data_devolucao - Locacao.data_locacao) OVER (PARTITION BY Carro.id_carro) AS media_dias_alugado
                                  FROM Locacao
                                  JOIN Carro ON Locacao.id_carro = Carro.id_carro
                                  JOIN Clientes ON Locacao.id_cliente = Clientes.id_cliente";
                        if (count($conditions) > 0) {
                            $query .= " WHERE " . implode(' AND ', $conditions);
                        }

                        $result = pg_query($conn, $query);
                        if (!$result) {
                            die("Erro na consulta: " . pg_last_error());
                        }

                        while ($row = pg_fetch_assoc($result)) {
                            $dias_alugado = $row['dias_alugado'];
                            $media_dias_alugado = round($row['media_dias_alugado'], 2);
                            echo "<tr>
                                    <td>{$row['id_locacao']}</td>
                                    <td>{$row['data_locacao']}</td>
                                    <td>{$row['data_devolucao']}</td>
                                    <td>{$row['valor_total']}</td>
                                    <td>{$row['carro']}</td>
                                    <td>{$row['cliente']}</td>
                                    <td>{$media_dias_alugado}</td>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>
