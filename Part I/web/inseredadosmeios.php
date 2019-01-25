<html>
    <body>
        <h3>Criar Meios</h3>
        <form action="inseremeios.php" method="post">
            <p><input type="hidden" name="nomeentidade" value="<?=$_REQUEST['nomeentidade']?>"/></p>
            <p>Numero do Meio: <input type="text" name="nummeio"/></p>
            <p>Nome do Meio: <input type="text" name="nomemeio"/></p>
            <p><input type="submit" value="Submit"/></p>
        </form>
    </body>
</html>
