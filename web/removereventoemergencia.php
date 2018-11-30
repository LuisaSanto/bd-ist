<html>
    <body>
<?php
    $numtelefone = $_REQUEST['numtelefone'];
    $instantechamada = $_REQUEST['instantechamada'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist179758";
        $password = "bd2018";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->query("start transaction;");
        $sql = "DELETE FROM eventoemergencia WHERE numtelefone=? AND instantechamada=?;";
        $stmt = $db->prepare($sql);
        $stmt->execute(array($numtelefone, $instantechamada));
        $db->query("commit;");

        $db = null;
        echo("<p>Evento removido com sucesso!</p>");
    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");

        echo("<p>Este evento nao pode ser removida.</p>");

    }
    echo("<td><a href=\"eventosdeemergencia.php\">Voltar para a lista de Eventos</a></td>\n");
    echo("<td><a href=\"index.php\">Voltar para o inicio</a></td>\n");
?>
    </body>
</html>
