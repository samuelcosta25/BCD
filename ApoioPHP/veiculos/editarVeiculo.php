<?php
$conn = pg_connect("host=localhost dbname=locadorazz user=postgres password=postgres");
if (!$conn) {
    die("Conexão falhou: " . pg_last_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];
    $modelo = $_POST['modelo'];
    $placa = $_POST['placa'];
    $ano = $_POST['ano'];
    $tipo = $_POST['tipo'];
    $disponibilidade = $_POST['disponibilidade'];

    $query = "UPDATE Carro SET modelo = $1, placa = $2, ano = $3, tipo = $4, disponibilidade = $5 WHERE id_carro = $6";
    $result = pg_query_params($conn, $query, [$modelo, $placa, $ano, $tipo, $disponibilidade, $id]);

    if ($result) {
        header("Location: infoVeiculos.php"); // Redirecionar de volta para a página de veículos
        exit();
    } else {
        echo "Erro na atualização: " . pg_last_error();
    }

    pg_close($conn);
}
?>
