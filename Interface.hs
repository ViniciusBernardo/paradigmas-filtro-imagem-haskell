module Interface (menu) where
import Filtros (filtroNegativo, filtroPolarizado, filtroPretoEBranco)
import ReadAndSavePPM
import System.IO

menu _ True = do
    hSetBuffering stdin LineBuffering
    putStrLn "Insira o nome o arquivo de entrada (formato .ppm)"
    filePath <- getLine
    f <- openBinaryFile filePath ReadMode
    image <- leArquivo f 0 []
    menu image False
menu image False = do
    hSetBuffering stdin LineBuffering

    putStrLn "------------------------Menu de Operações--------------------------"
    putStrLn "- (1) Negativo                               (2) Polarizado       -"
    putStrLn "- (3) Preto e Branco                         (4) Sair             -"
    putStrLn "-------------------------------------------------------------------"
    putStrLn "Escolha uma opção"
    option <- getLine
    if option == "1"
        then (menu (filtroNegativo image) False)
        else if option == "2"
        then (menu (filtroPolarizado image) False)
        else if option == "3"
        then (menu (filtroPretoEBranco image) False)
        else if option == "4"
        then salvaArquivo image
        else do
            putStrLn "Escolha uma opção válida!\n"
            (menu image False)

salvaArquivo imagem = do
    putStrLn "Insira o nome o arquivo de saída (formato .ppm)"
    filePath <- getLine
    save_ppm filePath imagem
    putStrLn "Imagem salva com sucesso!"
