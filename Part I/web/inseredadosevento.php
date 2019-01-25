<html>
    <body>
        <h3>Criar uma Evento</h3>
        <form action="insereevento.php" method="post">
            <p><input type="hidden" name="numprocessosocorro" value="<?=$_REQUEST['numprocessosocorro']?>"/></p>
            <p>Telefone: <input type="text" name="numtelefone"/></p>
            <p>Instante de Chamada: <input type="text" name="instantechamada"/></p>
            <p>Nome: <input type="text" name="nomepessoa"/></p>
            <p>Morada: <input type="text" name="moradalocal"/></p>
            <p><input type="submit" value="Submit"/></p>
        </form>
    </body>
</html>
