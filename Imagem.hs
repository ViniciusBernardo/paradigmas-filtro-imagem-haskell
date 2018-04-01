module Imagem (Pixel(..), filtroNegativo, mountImage) where

data Pixel = Pixel {red :: Int, green :: Int, blue :: Int} deriving (Show)

getRed :: Pixel -> Int
getRed (Pixel {red = r, green = g, blue = b}) = r

getGreen :: Pixel -> Int
getGreen (Pixel {red = r, green = g, blue = b}) = g

getBlue :: Pixel -> Int
getBlue (Pixel {red = r, green = g, blue = b}) = b

operationOverPixel f (Pixel {red = r, green = g, blue = b}) = Pixel (f r) (f g) (f b)

operationOverLinePixel f [] = []
operationOverLinePixel f (h:t) = [operationOverPixel f h] ++ (operationOverLinePixel f t)

data Image = Image {pixels :: [[Pixel]]} deriving (Show)

getPixel :: Image -> Int -> Int -> Pixel
getPixel (Image {pixels = p}) row column = p!!row!!column

filtroNegativo :: [[Pixel]] -> [[Pixel]]
filtroNegativo [] = []
filtroNegativo (h:t) = [operationOverLinePixel (255-) h] ++ filtroNegativo(t)


addSpace xs width = if length xs <= width
                    then xs 
                    else take width xs ++ "\n" ++ addSpace (drop width xs) width

mountImage :: [String] -> Int -> Int -> [Pixel] -> [[Pixel]] -> [[Pixel]]
mountImage [] _ _ c d = d ++ [c]
mountImage xs counter width listPixels image = do
    let slicedList = take 3 xs
    if counter < width
        then do
            mountImage (drop 3 xs) (counter+1) width (listPixels ++ [Pixel (read (slicedList!!0) :: Int) (read (slicedList!!1) :: Int) (read (slicedList!!2) :: Int)]) image
        else do
            mountImage xs 0 width [] (image ++ [listPixels])
