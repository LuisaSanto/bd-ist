<html>
    <body>
    <h3>Eventos de Emergencia</h3>
<?php
    try 
    { 
        $host = "db.ist.utl.pt";
        $user ="ist179758";
        $password = "bd2018";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $sql = "SELECT * FROM eventoemergencia;";
        $result = $db->query($sql);

        echo("<table border=\"0\" cellspacing=\"10\">\n");
        echo("<tr><td><a href=\"inseredadosevento.php\">Adicionar Evento</a></td></tr>\n");
        echo("<tr><td><b>Telefone</b></td><td><b>Instante de Chamada</b></td><td><b>Nome</b></td><td><b>Morada</b></td><td><b>Numero do processo</b></td></tr>\n"); 
        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['numtelefone']}</td>\n");
            echo("<td>{$row['instantechamada']}</td>\n");
            echo("<td>{$row['nomepessoa']}</td>\n");
            echo("<td>{$row['moradalocal']}</td>\n");
            echo("<td>{$row['numprocessosocorro']}</td>\n");
            echo("<td><a href=\"removereventoemergencia.php?numtelefone={$row['numtelefone']}&instantechamada={$row['instantechamada']}\">Remover Evento de Emergencia</a></td>\n");
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
