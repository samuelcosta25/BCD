<?php
$conn = pg_connect("host=localhost dbname=samueldb_Locadora user=postgres password=postgres");
if (!$conn) {
    die("Conexão falhou: " . pg_last_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];

    $query = "DELETE FROM Clientes WHERE id_cliente = $1";
    $result = pg_query_params($conn, $query, [$id]);

    if ($result) {
        header("Location: infoClientes.php"); // Redirecionar de volta para a página de veículos
        exit();
    } else {
        echo "Erro na exclusão: " . pg_last_error();
    }

    pg_close($conn);
}
?>
