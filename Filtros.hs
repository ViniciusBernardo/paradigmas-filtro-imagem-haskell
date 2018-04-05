module Filtros (filtroNegativo, filtroPretoEBranco, filtroPolarizado) where
import Imagem (Pixel, operationOverLinePixel, getRed, getGreen, getBlue, setPixel)
import Data.Typeable (typeOf)


filtroNegativo :: [[Pixel]] -> [[Pixel]]
filtroNegativo [] = []
filtroNegativo (h:t) = [operationOverLinePixel (255-) (255-) (255-) h] ++ filtroNegativo(t)


filtroPretoEBranco :: [[Pixel]] -> [[Pixel]]
filtroPretoEBranco [] = []
filtroPretoEBranco (h:t) = do
    [calculaEscalaCinza h] ++ (filtroPretoEBranco t)

calculaEscalaCinza :: [Pixel] -> [Pixel]
calculaEscalaCinza [] = []
calculaEscalaCinza (h:t) = do
    let escala_cinza = truncate(0.289*(fromIntegral(getRed h)) + 0.577*(fromIntegral(getGreen h)) + 0.134*(fromIntegral(getBlue h)))
    if escala_cinza > 255
        then do
            [setPixel h 255 255 255] ++ (calculaEscalaCinza t)
    else do
        [setPixel h escala_cinza escala_cinza escala_cinza] ++ (calculaEscalaCinza t)


filtroPolarizado :: [[Pixel]] -> [[Pixel]]
filtroPolarizado [] = []
filtroPolarizado (h:t) = [calculaPolarizacao h] ++ (filtroPolarizado t)

calculaPolarizacao :: [Pixel] -> [Pixel]
calculaPolarizacao [] = []
calculaPolarizacao (h:t) = do
    let value_red = if (getRed h) > truncate(255/2)
                    then 255
                    else 0
    let value_green = if (getGreen h) > truncate(255/2)
                      then 255
                      else 0
    let value_blue = if (getBlue h) > truncate(255/2)
                     then 255
                     else 0
    [setPixel h value_red value_green value_blue] ++ (calculaPolarizacao t)
