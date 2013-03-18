import Control.ThreadPool (threadPoolIO)
import System.IO (openFile, IOMode(..))
import System.Environment (getArgs)
import Control.Concurrent.Chan
import Control.Monad (forM_)
import qualified Data.ByteString.Lazy.Char8 as L


-- Parallel Processing
---------------------------------------------------
import Text.Printf
import Control.Parallel

main = (a::Integer) `par` (b::Integer) `par` (c::Integer) `pseq`
	(printf "A = %d\nB = %d\nC = %d\n" a b c) where
	a = ack 3 10
	b = fac 42
	c = fib 34
---------------------------------------------------

--Control.Engine  -  http://tommd.wordpress.com/2009/03/13/explicit-parallelism-via-thread-pools/
---------------
--Provides a way to create worker threads to split up the processing of streaming data.
--Control.ThreadPool





