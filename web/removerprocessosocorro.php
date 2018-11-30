<html>
    <body>
<?php
    $numProcessoSocorro = $_REQUEST['numProcessoSocorro'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist179758";
        $password = "bd2018";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->query("start transaction;");
        $sql = "DELETE FROM processoSocorro WHERE numProcessoSocorro=?;";
        $stmt = $db->prepare($sql);
        $stmt->execute(array($numProcessoSocorro));
        $db->query("commit;");

        $db = null;
        echo("<p>Processo removido com sucesso!</p>");
    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");

        echo("<p>Este Processo nao pode ser removido.</p>");

    }
    echo("<td><a href=\"processosdesocorro.php\">Voltar para a lista de Processos</a></td>\n");
    echo("<td><a href=\"index.php\">Voltar para o inicio</a></td>\n");
?>
    </body>
</html>