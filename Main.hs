module Main where

import Yesod

import Application
import Foundation

main :: IO ()
main = warp 80 App
