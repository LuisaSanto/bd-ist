<html>
    <body>
<?php
    $moradaLocal = $_REQUEST['moradaLocal'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist179758";
        $password = "bd2018";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "SELECT numProcessoSocorro FROM eventoEmergencia WHERE moradaLocal=$moradaLocal;";
        $result = $db->query($sql);

        echo("<table border=\"0\" cellspacing=\"10\">\n");
        echo("<tr><td><b>Numero de Processo</b></td></tr>\n");
        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['numProcessoSocorro']}</td>\n");
            echo("<td><a href=\"mostrameios.php?numProcessoSocorro={$row['numProcessoSocorro']}\">Escolher Numero de processo</a></td>\n");
            echo("</tr>\n");
        }
        echo("<td><a href=\"index.php\">Voltar para o inicio</a></td>\n");
        echo("</table>\n");

        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['moradaLocal']}</td>\n");
            echo("<td><a href=\"mostranumeroprocesso.php?moradaLocal={$row['moradaLocal']}\">Escolher Local</a></td>\n");
            echo("</tr>\n");
        }
        echo("<td><a href=\"index.php\">Voltar para o inicio</a></td>\n");
        echo("</table>\n");

        $db = null;


    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");

    }
    echo("<td><a href=\"espacos.php\">Voltar para a lista de Espacos</a></td>\n");
    echo("<td><a href=\"inicio.php\">Voltar para o inicio</a></td>\n");
?>
    </body>
</html>
