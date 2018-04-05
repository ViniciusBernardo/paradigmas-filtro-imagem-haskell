module Imagem (Pixel(..), mountImage, operationOverLinePixel, getRed, getGreen, getBlue, setPixel) where

data Pixel = Pixel {red :: Int, green :: Int, blue :: Int} deriving (Show)

getRed :: Pixel -> Int
getRed (Pixel {red = r, green = g, blue = b}) = r

getGreen :: Pixel -> Int
getGreen (Pixel {red = r, green = g, blue = b}) = g

getBlue :: Pixel -> Int
getBlue (Pixel {red = r, green = g, blue = b}) = b

setPixel :: Pixel -> Int -> Int -> Int -> Pixel
setPixel pixel r g b = Pixel r g b

operationOverPixel fR fG fB (Pixel {red = r, green = g, blue = b}) = Pixel (truncate(fR (fromIntegral r))) (truncate(fG (fromIntegral g))) (truncate(fB (fromIntegral b)))

operationOverLinePixel fR fG fB [] = []
operationOverLinePixel fR fG fB (h:t) = [operationOverPixel fR fG fB h] ++ (operationOverLinePixel fR fG fB t)

mountImage :: [String] -> Int -> Int -> [Pixel] -> [[Pixel]] -> [[Pixel]]
mountImage [] _ _ c d = d ++ [c]
mountImage xs counter width listPixels image = do
    let slicedList = take 3 xs
    if counter < width
        then do
            mountImage (drop 3 xs) (counter+1) width (listPixels ++ [Pixel (read (slicedList!!0) :: Int) (read (slicedList!!1) :: Int) (read (slicedList!!2) :: Int)]) image
        else do
            mountImage xs 0 width [] (image ++ [listPixels])
