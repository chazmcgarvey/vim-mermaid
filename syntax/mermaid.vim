" Vim syntax file for Mermaid diagrams
" Language: Mermaid
" Maintainer: Charles McGarvey
" Version: 0.1

if exists('b:current_syntax')
    finish
endif

" sequenceDiagram
syntax keyword mmdDiagramType sequenceDiagram

" -> --> ->> -->> -X --X
syntax match mmdArrow /\v(--\>\>|--\>|-\>\>|--X|-\>|-X)/    
    \ nextgroup=mmdActivationSymbol,mmdActorBeforeMessage skipwhite contained

syntax match mmdInvalidActorChar /[-:;,]/ contained

syntax match mmdActorBeforeArrow   /\v\S.{-}\ze\s*(-\>|--\>|-\>\>|--\>\>|-X|--X)/
    \ contains=mmdInvalidActorChar nextgroup=mmdArrow skipwhite
syntax match mmdActorBeforeMessage /\v([^\t :][^:]*)=[^\t :]/
    \ contains=mmdInvalidActorChar nextgroup=mmdMessageDelimiter skipwhite contained
syntax match mmdActorBeforeComma   /\v\S.{-}\ze\s*,/
    \ contains=mmdInvalidActorChar nextgroup=mmdComma,mmdActorBeforeMessage skipwhite contained

" ,
syntax match mmdComma /\v,/ nextgroup=mmdActorBeforeMessage skipwhite contained

" +|-
syntax match mmdActivationSymbol /\v[-\+]/ contained nextgroup=mmdActorBeforeMessage skipwhite

" participant <ACTOR> [as <TEXT>]
" activate <ACTOR>
" deactivate <ACTOR>
syntax match mmdActor /\v\S.*/ contained contains=mmdInvalidActorChar
syntax match mmdActor /\v\c\S.{-}\ze\s+as\s/ nextgroup=mmdAlias skipwhite contained contains=mmdInvalidActorChar
syntax match mmdParticipant /^\v\c\s*\zsparticipant\ze\s/ nextgroup=mmdActor skipwhite
syntax match mmdAlias /\v\cas\ze\s/ nextgroup=mmdMessage skipwhite contained
syntax match mmdActivation /^\v\c\s*\zs(activate|deactivate)\s+/ nextgroup=mmdActor skipwhite

" loop [<TEXT>]
" alt [<TEXT>]
" else [<TEXT>]
" opt [<TEXT>]
" rect [<COLOR>]
" end
syntax match mmdGroup /^\v\c\s*\zs(alt|else|loop|opt)/ nextgroup=mmdMessage skipwhite
syntax match mmdGroup /^\v\c\s*\zsrect/ nextgroup=mmdColor skipwhite
syntax match mmdGroup /^\v\c\s*\zsend/
syntax match mmdColor /\v\S.*/ contained

" autonumber
syntax match mmdAutonumber /^\v\c\s*\zsautonumber/

" Note left|right of <ACTOR>: <TEXT>
" Note over <ACTOR>[,<ACTOR>]: <TEXT>
syntax match mmdMessageDelimiter /\v:/ contained nextgroup=mmdMessage skipwhite
syntax match mmdMessage /\v\S.*/ contained
syntax match mmdNote /^\v\c\s*Note\s+(right of|left of)\ze\s/ nextgroup=mmdActorBeforeMessage skipwhite
syntax match mmdNote /^\v\c\s*Note\s+over\ze\s/ nextgroup=mmdActorBeforeComma,mmdActorBeforeMessage skipwhite

" %% <TEXT>
syntax keyword mmdTodo contained FIXME TODO XXX
syntax match mmdComment /\v\%\%.*$/ contains=mmdTodo

highlight link mmdInvalidActorChar Error
highlight link mmdDiagramType Function
highlight link mmdArrow Operator
highlight link mmdComma Operator
highlight link mmdActivationSymbol Keyword
highlight link mmdParticipant Keyword
highlight link mmdActivation Keyword
highlight link mmdAlias Keyword
highlight link mmdTodo Todo
highlight link mmdComment Comment
highlight link mmdActor Identifier
highlight link mmdActorBeforeArrow Identifier
highlight link mmdActorBeforeMessage Identifier
highlight link mmdActorBeforeComma Identifier
highlight link mmdMessageDelimiter Delimiter
highlight link mmdMessage String
highlight link mmdNote Keyword
highlight link mmdGroup Statement
highlight link mmdAutonumber Statement
highlight link mmdColor Constant

let b:current_syntax = 'mermaid'
