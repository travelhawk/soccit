module Main where

import Network.HTTP
import Text.HTML.TagSoup


openURL :: String -> IO String
openURL x = getResponseBody =<< simpleHTTP (getRequest x)

blStats :: IO ()
blStats = do
        tags <- parseTags <$> openURL "http://sportdaten.t-online.de/fussball/german-bundesliga/2016-2017/spiel-teamvergleich/spieltag-1/id_67_0_28124_861390/"
        let statsData = takeWhile (~/= "<script>")
                        $ dropWhile (~/= "<table class=table_left>") tags

        let statsHeader = map f $ everyf 2 $ sections (~== "<td>") $ takeWhile (~/= "</table>") $ statsData

        let statsData1 = map f $ every 2 $ sections (~== "<td>") $ takeWhile (~/= "</table>") $ statsData
        let statsData2 = map f $ sections (~== "<td>") $ dropWhile (~/= "</table>") $ statsData

        putStr "headers:\n"
        putStr $ unlines statsHeader
        putStr "data1:\n"
        putStr $ unlines statsData1
        putStr "data2:\n"
        putStr $ unlines statsData2

    where
        f :: [Tag String] -> String
        f = unwords . words . fromTagText . head . filter isTagText

        everyf n [] = []
        everyf n as = head as : everyf n (drop n as)

        every n xs = case drop (n-1) xs of
              (y:ys) -> y : every n ys
              [] -> []

main :: IO ()
main = blStats