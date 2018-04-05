module Interface (menu) where
import Imagem (mountImage)
import Filtros (filtroNegativo, filtroPolarizado, filtroPretoEBranco)
import ReadAndSavePPM
import System.IO

menu = do
    image <- leArquivo
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

leArquivo = do
    putStrLn "Insira o nome o arquivo (formato .ppm)"
    filePath <- getLine
    f <- openBinaryFile filePath ReadMode
    numeroMagico <- hGetLine f
    line <- hGetLine f
    line <- hGetLine f
    line <- hGetLine f
    line <- hGetLine f
    let size = words line
    line <- hGetLine f
    let size = words line
    line <- hGetLine f
    contents <- hGetContents f
    let image = (tail $ mountImage (words contents) 0 (read (size!!0) :: Int) [] [[]])
    return (image)


salvaArquivo imagem = do
    putStrLn "Insira o nome o arquivo (formato .ppm)"
    filePath <- getLine
    save_ppm filePath imagem
