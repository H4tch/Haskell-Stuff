
module Main where

{- #define LIBGL_DEBUG=verbose -}

import System.IO
import System.Exit
import Control.Monad
import Control.Concurrent

import Graphics.UI.SDL
import qualified Graphics.UI.SDL as SDL
import Graphics.Rendering.OpenGL.Raw
import Graphics.Rendering.GLU.Raw ( gluPerspective )
import Data.Bits ( (.|.) )
import GHC.Word


class Drawable d where
    draw :: d -> IO Surface

windowFlags = [ HWSurface, OpenGL, DoubleBuf ]

fullscreen width height =
    setVideoMode width height 32 ([Fullscreen] ++ windowFlags)

window width height =
    setVideoMode width height 32 windowFlags

handleEvents = do
   event <- pollEvent
   case event of
        Quit -> exitWith ExitSuccess
        KeyDown (Keysym {symKey=key}) -> keyPressed key
        _ -> return ()

keyPressed key = putStrLn (show key ++ " was pressed.")


initSDL = do
  SDL.init [ SDL.InitEverything ]

initGL :: IO ()
initGL = do
  glShadeModel gl_SMOOTH -- enables smooth color shading
  glClearColor 0 0 0 0 -- Clear the background color to black
  glClearDepth 1 -- enables clearing of the depth buffer
  glEnable gl_DEPTH_TEST
  glDepthFunc gl_LEQUAL -- type of depth test
  glHint gl_PERSPECTIVE_CORRECTION_HINT gl_NICEST

resizeScene w     0      = resizeScene w 1 -- prevent divide by zero
resizeScene width height = do
  glViewport 0 0 (fromIntegral width) (fromIntegral height)
  glMatrixMode gl_PROJECTION
  glLoadIdentity
  --gluPerspective 45 (fromIntegral width/fromIntegral height) 0.1 100 
  glMatrixMode gl_MODELVIEW
  glLoadIdentity
  glFlush

drawScene :: IO ()
drawScene = do
  -- clear the screen and the depth buffer
  glClear $ fromIntegral  $  gl_COLOR_BUFFER_BIT
                         .|. gl_DEPTH_BUFFER_BIT
  glLoadIdentity  -- reset view
  glFlush



main = do
    initSDL
    initGL
    screen <- window 800 600
    forever $ do
       handleEvents
       drawScene
       delay 50
    
    delay 5000
    --killThread eventThread
    return ()


