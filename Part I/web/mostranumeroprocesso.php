<html>
    <body>
<?php
    $moradalocal = $_REQUEST['moradalocal'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist179758";
        $password = "bd2018"; 
        $dbname = $user; 
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "SELECT numprocessosocorro FROM eventoemergencia WHERE moradalocal='$moradalocal';";
        $result = $db->query($sql);


        echo("<table border=\"0\" cellspacing=\"10\">\n");
        echo("<tr><td><b>Numero de Processo</b></td></tr>\n");
        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['numprocessosocorro']}</td>\n");
            echo("<td><a href=\"mostrameios.php?numprocessosocorro={$row['numprocessosocorro']}\">Escolher Numero de processo</a></td>\n");
            echo("</tr>\n");
        }
        echo("<td><a href=\"index.php\">Voltar para o inicio</a></td>\n");
        echo("<td><a href=\"listameiosdeumprocesso.php\">Voltar para a lista de processos</a></td>\n");
        echo("</table>\n");
        $db = null;


    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");

    }
?>
    </body>
</html>
