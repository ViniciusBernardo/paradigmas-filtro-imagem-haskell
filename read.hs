import System.IO

main = do
    f <- openBinaryFile "bla.ppm" ReadMode
    numeroMagico <- hGetLine f
    line <- hGetLine f
    line <- hGetLine f
    let size = words line
    line <- hGetLine f
    contents <- hGetContents f
    let foo = words contents
    let listPixels = map(read::String->Int) foo
    let soma = somaLista(listPixels)
    appendFile "foo_negativo.ppm" (numeroMagico ++ "\n")
    appendFile "foo_negativo.ppm" (size!!0 ++ " " ++ size!!1 ++ "\n")
    appendFile "foo_negativo.ppm" (line ++ "\n")
    --appendFile "dado_negativo.ppm" (filter(/=' ')(unwords(map toEnum listPixels)))
    let listString = unwords(map show soma)
    appendFile "foo_negativo.ppm" (addSpace listString ((read (size!!0) :: Int)))
    --appendFile "x_negativo.ppm" (ola)
    hClose f

addSpace xs width = if length xs <= 18
                    then xs 
                    else take 18 xs ++ "\n" ++ addSpace (drop 18 xs) width

somaLista :: [Char] -> [Int]
somaLista [] = []
somaLista (h:t) = unwords([show(15 - (read h :: Int))]) ++ somaLista(t)
