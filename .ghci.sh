cat <<EOF > ~/.ghci
:set  prompt "| "
let loop = do { l <- getLine; if l == "\^D" then return () else do appendFile "Main.hs" (l ++ "\n"); loop }
:def paste (\_ -> loop >> return ":load Main.hs")
:def x (\_ -> return ":e Main.hs \n :load Main.hs")
:def v (\l -> return (":e "++ l ++ " \n  :load " ++ l ++ "\n"))

:m - Prelude
:m + GOA
wakeup
setLambdabotHome "$HOME/.cabal/bin"
:set -XImplicitParams
:def pl        lambdabot "pl"
:def unpl      lambdabot "unpl"
:def index     lambdabot "index"
:def docs      lambdabot "docs"
:def instances lambdabot "instances"
:def hoogle    lambdabot "hoogle"
:def source    lambdabot "fptools"
:def where     lambdabot "where"
:def version   lambdabot "version"

:def redo      lambdabot "redo"
:def undo      lambdabot "undo"
:def src       lambdabot "src"
EOF
