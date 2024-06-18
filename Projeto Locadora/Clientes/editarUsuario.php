<?php
$conn = pg_connect("host=localhost dbname=samueldb_Locadora user=postgres password=postgres");
if (!$conn) {
    die("Conexão falhou: " . pg_last_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];
    $cnh = $_POST['cnh'];
    $nome = $_POST['nome'];
    $cidade = $_POST['cidade'];
    $telefone = $_POST['telefone'];
    $email = $_POST['email'];

    $query = "UPDATE clientes SET nome = $1, cidade = $2, telefone = $3, email = $4 WHERE id_cliente = $5";
    $result = pg_query_params($conn, $query, [$nome, $cidade, $telefone, $email, $id]);

    if ($result) {
        header("Location: infoClientes.php"); // Redirecionar de volta para a página de veículos
        exit();
    } else {
        echo "Erro na atualização: " . pg_last_error();
    }

    pg_close($conn);
}
?>
