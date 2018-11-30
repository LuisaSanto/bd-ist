<html>
    <body>
        <h3>Criar uma Evento</h3>
        <form action="insereevento.php" method="post">
            <p><input type="hidden" name="numProcessoSocorro" value="<?=$_REQUEST['numProcessoSocorro']?>"/></p>
            <p>Telefone: <input type="text" name="numTelefone"/></p>
            <p>Instante de Chamada: <input type="text" name="instanteChamada"/></p>
            <p>Nome: <input type="text" name="nomePessoa"/></p>
            <p>Morada: <input type="text" name="moradaLocal"/></p>
            <p><input type="submit" value="Submit"/></p>
        </form>
    </body>
</html>
