<html>
    <body>
<?php
    $numProcessoSocorro = $_REQUEST['numProcessoSocorro'];
    $numTelefone = $_REQUEST['numTelefone'];
    $instanteChamada = $_REQUEST['instanteChamada'];
    $nomePessoa = $_REQUEST['nomePessoa'];
    $moradaLocal = $_REQUEST['moradaLocal'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist179758";
        $password = "bd2018";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->query("start transaction;");
        $sql = "INSERT INTO eventoEmergencia (numTelefone, instanteChamada, nomePessoa, moradaLocal, numProcessoSocorro) VALUES (?,?,?,?,?);";
        $stmt = $db->prepare($sql);
        $stmt->execute(array($numTelefone, $instanteChamada, $nomePessoa, $moradaLocal, $numProcessoSocorro));
        $db->query("commit;");

        $db = null;
        echo("<p>Evento adicionada com sucesso!</p>");
    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
    echo("<td><a href=\"eventosdeemergencia.php\">Voltar para a lista de Eventos</a></td>\n");
    echo("<td><a href=\"index.php\">Voltar para o inicio</a></td>\n");
?>
    </body>
</html>
