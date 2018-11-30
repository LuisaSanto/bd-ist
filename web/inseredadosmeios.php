<html>
    <body>
        <h3>Criar Meios</h3>
        <form action="inseremeios.php" method="post">
            <p><input type="hidden" name="nomeEntidade" value="<?=$_REQUEST['nomeEntidade']?>"/></p>
            <p>Numero do Meio: <input type="text" name="numMeio"/></p>
            <p>Nome do Meio: <input type="text" name="nomeMeio"/></p>
            <p><input type="submit" value="Submit"/></p>
        </form>
    </body>
</html>
