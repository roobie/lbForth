\ Create a GEMDOS executale file in memory.

base @

( Constants )

hex

601A constant magic

1 constant pf-fastload
2 constant pf-ttramload
4 constant pf-ttrammem
00 constant pf-private
10 constant pf-global
20 constant pf-supervisor
30 constant pf-readable

pf-fastload pf-ttramload + pf-ttrammem + pf-private + constant flags

decimal

[undefined] >host [if] : >host ; [then]

( Data types )

: w, ( x -- ) dup 8 rshift c, c, ;
: l, ( x -- ) dup 16 rshift w, w, ;
: l! ( x a -- ) here >r dp ! l, r> dp ! ;
: zeros, ( u -- ) here swap dup allot erase ;

( Data structures )

variable start
variable extra  0 extra !

: start- ( a -- u ) >host start @ >host - ;

: gemdos-start   start ! ;
: gemdos-text   start-  start @ 2 + l! ;
: gemdos-bss   start @ 10 + l! ;
: gemdos-extra-bytes   extra ! ;

( GEMDOS header )

: magic,   w,  20 zeros, ;
: flags,   l, 0 w, ;
: fixup,   0 l, ;
: gemdos,   magic magic,  flags flags, ;

: gemdos-header,   here gemdos-start  gemdos, ;
: gemdos-end   align fixup,  here gemdos-text  extra @ gemdos-bss ;

base !
