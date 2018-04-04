import System.IO
import Imagem
import Filtros

main = do
    f <- openBinaryFile "../unb_77p3.ppm" ReadMode
    numeroMagico <- hGetLine f
    line <- hGetLine f
    let size = words line
    line <- hGetLine f
    contents <- hGetContents f
    let foo = words contents
    print(size)
    let listPixels = tail $ mountImage foo 0 (read (size!!0) :: Int) [] [[]]
    let filterApplied = filtroNegativo listPixels
    save_ppm "../unb_77p3_negativo2.ppm" filterApplied
    hClose f

addSpace xs width = if length xs <= 18
                    then xs 
                    else take 18 xs ++ "\n" ++ addSpace (drop 18 xs) width

save_ppm :: FilePath -> [[Pixel]] -> IO ()
save_ppm f css = writeFile f $ make_ppm css

make_ppm :: [[Pixel]] -> String
make_ppm css =
  "P3\n" ++ (show $ length $ head css) ++ " " ++ (show $ length css) ++ "\n255\n" ++
  (unlines $ map unwords $ group 15 $ map show $ concatMap colour $ concat css)

group _ [] = []
group n xs =
  let (xs0,xs1) = splitAt n xs
  in  xs0 : group n xs1

colour (Pixel r g b) = [r,g,b]
