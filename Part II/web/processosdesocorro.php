<html>
    <body>
    <h3>Processo de socorro</h3>
<?php
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist179758";
        $password = "bd2018";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


        $sql = "SELECT * FROM processosocorro;";
        $result = $db->query($sql);

        echo("<table border=\"0\" cellspacing=\"10\">\n");
        echo("<tr><td><a href=\"inserenumeroprocesso.php\">Adicionar Processo de Socorro</a></td></tr>\n");
        echo("<tr><td><b>Numero do Processo</b></td></tr>\n");

        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['numprocessosocorro']}</td>\n");
            echo("<td><a href=\"removerprocessosocorro.php?numprocessosocorro={$row['numprocessosocorro']}\">Remover Processo de Socorro</a></td>\n");
            echo("</tr>\n");
        }
        echo("<td><a href=\"index.php\">Voltar para o inicio</a></td>\n");
        echo("</table>\n");

        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
