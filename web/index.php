<html>
    <body>
    <h3>Base de Dados</h3>
    <h3>Inicio</h3>
<?php
    try
    {
        echo("<table border=\"0\" cellspacing=\"10\">\n");

        echo("<tr>\n");
        echo("<td><a href=\"locais.php\">Adicionar ou Remover Locais</a></td>\n");
        echo("</tr>\n");
        echo("<tr>\n");
        echo("<td><a href=\"eventosdeemergencia.php\">Adicionar ou Remover Eventos de Emergência</a></td>\n");
        echo("</tr>\n");
        echo("<tr>\n");
        echo("<td><a href=\"processosdesocorro.php\">Adicionar ou Remover Processos de Socorro</a></td>\n");
        echo("</tr>\n");
        echo("<tr>\n");
        echo("<td><a href=\"meios.php\">Adicionar ou Remover Meios</a></td>\n");
        echo("</tr>\n");
        echo("<tr>\n");
        echo("<td><a href=\"entidades.php\">Adicionar ou Remover Entidades</a></td>\n");
        echo("</tr>\n");
        echo("<tr>\n");
        echo("<td><a href=\"meiosdecombate.php\">Adicionar, Editar ou Remover Meios de Combate</a></td>\n");
        echo("</tr>\n");
        echo("<tr>\n");
        echo("<td><a href=\"meiosdeapoio.php\">Adicionar, Editar ou Remover Meios de Apoio</a></td>\n");
        echo("</tr>\n");
        echo("<tr>\n");
        echo("<td><a href=\"meiosdesocorro.php\">Adicionar, Editar ou Remover Meios de Socorro</a></td>\n");
        echo("</tr>\n");
        echo("<tr>\n");
        echo("<td><a href=\"listarprocessodesocorro.php\">Mostrar Processos de Socorro</a></td>\n");
        echo("</tr>\n");
        echo("<tr>\n");
        echo("<td><a href=\"listarmeios.php\">Mostrar Meios</a></td>\n");
        echo("</tr>\n");
        echo("<tr>\n");
        echo("<td><a href=\"associarprocessosameios.php\">Associar Processos de Socorro a Meios</a></td>\n");
        echo("</tr>\n");
        echo("<tr>\n");
        echo("<td><a href=\"associarprocessosaeventos.php\">Associar Processos de Socorro a Eventos de Emergência</a></td>\n");
        echo("</tr>\n");
        echo("<tr>\n");
        echo("<td><a href=\"listarmeiosdeumprocesso.php\">Mostrar Meios de um Processo de Socorro </a></td>\n");
        echo("</tr>\n");
        echo("<tr>\n");
        echo("<td><a href=\"listarmeiosdeumprocessodeumlocal.php\">Mostrar Meios de um Processo de Socorro de um icendio </a></td>\n");
        echo("</tr>\n");

        echo("</table>\n");
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
