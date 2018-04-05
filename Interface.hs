module Interface (menu) where
import Filtros (filtroNegativo, filtroPolarizado, filtroPretoEBranco)
import ReadAndSavePPM
import System.IO

menu = do
    putStrLn "Insira o nome o arquivo (formato .ppm)"
    filePath <- getLine
    f <- openBinaryFile filePath ReadMode
    image <- leArquivo f 0 []
    putStrLn "------------------------Menu de Operações--------------------------"
    putStrLn "- (1) Negativo                               (2) Polarizado       -"
    putStrLn "- (3) Preto e Branco                         (4) Sair             -"
    putStrLn "-------------------------------------------------------------------"
    putStrLn "Escolha uma opção"
    option <- getLine
    let imageFiltered = if option == "1"
                            then filtroNegativo image
                            else if option == "2"
                                then filtroPolarizado image
                                else if option == "3"
                                then filtroPretoEBranco image
                                else [[]]
    salvaArquivo imageFiltered
    putStrLn "Imagem salve com sucesso!"

salvaArquivo imagem = do
    putStrLn "Insira o nome o arquivo (formato .ppm)"
    filePath <- getLine
    save_ppm filePath imagem
