<?php
// processa_locacao.php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id_cliente = $_POST['id_cliente'];
    $data_locacao = $_POST['data_locacao'];
    $data_devolucao = $_POST['data_devolucao'];
    $id_carro = $_POST['id_carro'];
    $valor = $_POST['valor'];

    // Conexão com o banco de dados
    $conn = pg_connect("host=localhost dbname=locadorazz user=postgres password=postgres");

    // Verifica a conexão
    if (!$conn) {
        die("Conexão falhou: " . pg_last_error());
    }

    // Insere os dados na tabela de locação
    $sql = "INSERT INTO Locacao (data_locacao, data_devolucao, valor_total, id_carro, id_cliente)
            VALUES ('$data_locacao', '$data_devolucao', '$valor', '$id_carro', '$id_cliente')";
    $result = pg_query($conn, $sql);

    if ($result) {
        echo "Nova locação registrada com sucesso!";
    } else {
        echo "Erro: " . pg_last_error();
    }

    // Atualiza a disponibilidade do carro
    $sql_update_carro = "UPDATE Carro SET Disponibilidade = 'Indisponível' WHERE Id_carro = '$id_carro'";
    pg_query($conn, $sql_update_carro);

    pg_close($conn);
}
?>
