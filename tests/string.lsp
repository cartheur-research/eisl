(import "string")
(import "test")

($test (string-split "asdf def gh" " ") ("asdf" "def" "gh"))
($test (string-split "asdf,def,gh" ",") ("asdf" "def" "gh"))
($test (string-slice "hello" 3 5) "lo")
($test (string-replace "hello" "e" "a") "hallo")
($test (string-remove "hello" 3 5) "hel")
($test (string-reverse "hello") "olleh")
($test (string-delete "hello" "l") "heo")
($test (string-head "hello") "h")
($test (string-tail "hello") "o")

($test (string-upper "asdf") "ASDF")
($test (string-lower "ASDF") "asdf")
($test (list-to-string '(#\h #\e #\l #\l #\o)) "hello")

($test (to-string "derp") "derp")
($test (to-string #\a) "a")
($test (to-string 9) "9")

($test (join `("a" "b" "c") ",") "a,b,c")
($test (join #("a" "b" "c") ",") "a,b,c")
($test (join `("a" "b" "c") "xyz") "axyzbxyzc")
($test (join `("a" "b" "c") #\,) "a,b,c")
($test (join `("a" "b" "c") #\z) "azbzc")
