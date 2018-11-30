<html>
    <body>
<?php
    $nummeio = $_REQUEST['nummeio'];
    $nomeentidade = $_REQUEST['nomeentidade'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist179758";
        $password = "bd2018";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->query("start transaction;");
        $sql = "DELETE FROM meiocombate WHERE nummeio=? AND nomeentidade=?;";
        $stmt = $db->prepare($sql);
        $stmt->execute(array($nummeio, $nomeentidade));
        $db->query("commit;");

        $db = null;
        echo("<p>Meio removido com sucesso!</p>");
    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");

        echo("<p>Este meio nao pode ser removida.</p>");

    }
    echo("<td><a href=\"meiosdecombate.php\">Voltar para a lista de Meios de Combate</a></td>\n");
    echo("<td><a href=\"index.php\">Voltar para o inicio</a></td>\n");
?>
    </body>
</html>
