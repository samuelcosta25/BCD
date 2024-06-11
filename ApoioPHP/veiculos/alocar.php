<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
    rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="alocar.css">
    <title>Alugar - Sync</title>
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
    <div class="container">
    <form action="processa_locacao.php" method="post">
        <div class="cadastro">
            <div class="imgCadastro">
                <img src="../img/MainImage.png" alt="Imagem Cadastro">
            </div>
            <div class="formularios">
                <div class="formulario">
                    <label for="lnome">Nome do Cliente</label>
                    <select class="form-select" id="lnome" name="id_cliente" required>
                        <option selected>Escolha um cliente...</option>
                        <!-- Opções de clientes devem ser geradas dinamicamente do banco de dados -->
                        <?php
                        // Código PHP para preencher dinamicamente as opções de cliente
                        $conn = pg_connect("host=localhost dbname=locadorazz user=postgres password=postgres");
                        if (!$conn) {
                            die("Conexão falhou: " . pg_last_error());
                        }
                        $result = pg_query($conn, "SELECT id_cliente, nome, sobrenome FROM Clientes");
                        if (!$result) {
                            die("Erro na consulta: " . pg_last_error());
                        }
                        while ($row = pg_fetch_assoc($result)) {
                            echo "<option value='" . $row['id_cliente'] . "'>" . $row['nome'] . " " . $row['sobrenome'] . "</option>";
                        }
                        pg_free_result($result);
                        pg_close($conn);
                        ?>
                    </select>

                    <label for="ldatalocacao">Data da Locação</label>
                    <input type="text" id="ldatalocacao" name="data_locacao" placeholder="Insira a data de locação">


                    <label for="lvalor">Valor (Exceto Taxas)</label>
                    <input type="text" id="lvalor" name="valor" placeholder="Insira o valor">
                </div>
                <div class="formulario">
                    <label for="lcarro">Selecione o Carro</label>
                    <select class="form-select" id="lcarro" name="id_carro" required>
                        <option selected>Escolha um carro...</option>
                        <!-- Opções de carros devem ser geradas dinamicamente do banco de dados -->
                        <?php
                        // Código PHP para preencher dinamicamente as opções de carro
                        $conn = pg_connect("host=localhost dbname=locadorazz user=postgres password=postgres");
                        if (!$conn) {
                            die("Conexão falhou: " . pg_last_error());
                        }
                        $result = pg_query($conn, "SELECT Id_carro, Modelo FROM Carro WHERE Disponibilidade = 'Disponível'");
                        if (!$result) {
                            die("Erro na consulta: " . pg_last_error());
                        }
                        while ($row = pg_fetch_assoc($result)) {
                            echo "<option value='" . $row['id_carro'] . "'>" . $row['modelo'] . "</option>";
                        }
                        pg_free_result($result);
                        pg_close($conn);
                        ?>
                    </select>

                    <label for="ldatadevolucao">Data da Devolução</label>
                    <input type="text" id="ldatadevolucao" name="data_devolucao" placeholder="Insira a data de devolução">

                    <label for="lnumero">CEP</label>
                    <input type="text" id="lcep" name="cep" placeholder="Insira seu CEP">
                </div>
            </div>
            <div class="formulario2">
                <div class="enviarCadastro">
                    <input type="submit" id="lenviar" name="enviar" value="Enviar">
                </div>
            </div>
            </form>
            
        </div>
    </div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</html>