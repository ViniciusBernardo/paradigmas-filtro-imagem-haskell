module FiltroNegativo (Pixel(..), somaLista) where

data Pixel = Pixel {red :: Int, green :: Int, blue :: Int} deriving (Show)

getRed :: Pixel -> Int
getRed (Pixel {red = r, green = g, blue = b}) = r

getGreen :: Pixel -> Int
getGreen (Pixel {red = r, green = g, blue = b}) = g

getBlue :: Pixel -> Int
getBlue (Pixel {red = r, green = g, blue = b}) = b

data Image = Image {pixels :: [[Pixel]]} deriving (Show)

getPixel :: Image -> Int -> Int -> Pixel
getPixel (Image {pixels = p}) row column = p!!row!!column

somaLista :: [String] -> String
somaLista [] = []
somaLista (h:t) = unwords([show(15 - (read h :: Int))]) ++ " " ++ somaLista(t)


addSpace xs width = if length xs <= width
                    then xs 
                    else take width xs ++ "\n" ++ addSpace (drop width xs) width

mountImage :: [String] -> Int -> Int -> [Pixel] -> [[Pixel]] -> [[Pixel]]
mountImage [] _ _ _ a = a
mountImage xs counter width listPixels image = do
    let slicedList = take 3 xs
    if counter < width
    then do
        [listPixels] ++ [[Pixel (read (slicedList!!0) :: Int) (read (slicedList!!1) :: Int) (read (slicedList!!2) :: Int)]]
        drop 3 xs
        mountImage xs (counter+1) width listPixels image
    else do
        image ++ [listPixels]
        listPixels <- []
        mountImage xs 0 width listPixels image
