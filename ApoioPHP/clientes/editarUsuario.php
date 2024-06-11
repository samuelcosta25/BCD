<?php
$conn = pg_connect("host=localhost dbname=locadorazz user=postgres password=postgres");
if (!$conn) {
    die("Conexão falhou: " . pg_last_error());
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];
    $nome = $_POST['nome'];
    $sobrenome = $_POST['sobrenome'];
    $endereco = $_POST['endereco'];
    $cidade = $_POST['cidade'];
    $estado = $_POST['estado'];
    $telefone = $_POST['telefone'];
    $email = $_POST['email'];

    $query = "UPDATE Clientes SET nome = $1, sobrenome = $2, endereco = $3, cidade = $4, estado = $5, telefone = $6, email = $7 WHERE id_cliente = $8";
    $result = pg_query_params($conn, $query, [$nome, $sobrenome, $endereco, $cidade, $estado, $telefone, $email, $id]);

    if ($result) {
        header("Location: infoClientes.php"); // Redirecionar de volta para a página de veículos
        exit();
    } else {
        echo "Erro na atualização: " . pg_last_error();
    }

    pg_close($conn);
}
?>
