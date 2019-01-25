<html>
    <body>
<?php
    $numprocessosocorro = $_REQUEST['numprocessosocorro'];
    $numtelefone = $_REQUEST['numtelefone'];
    $instantechamada = $_REQUEST['instantechamada'];
    $nomepessoa = $_REQUEST['nomepessoa'];
    $moradalocal = $_REQUEST['moradalocal'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist179758";
        $password = "bd2018";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->query("start transaction;");
        $sql = "INSERT INTO eventoemergencia (numtelefone, instantechamada, nomepessoa, moradalocal, numprocessosocorro) VALUES (?,?,?,?,?);";
        $stmt = $db->prepare($sql);
        $stmt->execute(array($numtelefone, $instantechamada, $nomepessoa, $moradalocal, $numprocessosocorro));
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
