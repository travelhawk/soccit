module Main where

import Network.HTTP
import Text.HTML.TagSoup

openURL :: String -> IO String
openURL x = getResponseBody =<< simpleHTTP (getRequest x)

ndmPapers :: IO ()
ndmPapers = do
        tags <- parseTags <$> openURL "http://community.haskell.org/~ndm/downloads/"
        let papers = map f $ sections (~== "<li class=paper>") tags
        putStr $ unlines papers
    where
        f :: [Tag String] -> String
        f xs = fromTagText (xs !! 2)

main :: IO ()
main = ndmPapers