<html>
    <body>
    <h3>Entidade</h3>
<?php
    try 
    {
        $host = "db.ist.utl.pt";
        $user ="ist179758";
        $password = "bd2018";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "SELECT * FROM entidademeio;";
        $result = $db->query($sql);

        echo("<table border=\"0\" cellspacing=\"10\">\n");
        echo("<tr><td><a href=\"insereentidade.php\">Adicionar Entidade</a></td></tr>\n");
        echo("<tr><td><b>Nome da entidade</b></td></tr>\n");

        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['nomeentidade']}</td>\n");
            echo("<td><a href=\"removeentidade.php?nomeentidade={$row['nomeentidade']}\">Remover Entidade</a></td>\n");
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
