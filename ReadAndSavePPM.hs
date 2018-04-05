module ReadAndSavePPM (save_ppm, leArquivo) where
import System.IO
import Imagem

leArquivo file counter header = do
    line <- hGetLine file
    if line!!0 == '#'
        then (leArquivo file counter header)
        else if counter < 2
            then (leArquivo file (counter+1) (header ++ (words line)))
        else do
            contents <- hGetContents file
            let image = (tail $ mountImage (words contents) 0 (read (header!!1) :: Int) [] [[]])
            return (image)


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
