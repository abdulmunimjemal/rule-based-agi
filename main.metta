 ; Knowledge Base
(Male Abdella)
(Female Kedija)
(Male Munim)
(Female Hanim)
(Parent Abdella Munim)
(Parent Kedija Munim)
(Parent Abdella Hanim)
(Parent Kedija Hanim)
 ; Added for grand parent relations
(Male Mohammed)
(Male Abizer)
(Female Fatuma)
(Female Zeyneb)
(Parent Mohammed Abdella)
(Parent Fatuma Abdella)
(Parent Abizer Kedija)
(Parent Zeyneb Kedija)

(Parent Chemeda Mohammed)
(Parent Hundessa Fatuma)
(Parent Habtamu Abizer)
(Parent Chala Zeyneb)

(Parent Hanim Nephew1)
(Male Nephew1)
(Parent Hanim Niece1)
(Female Niece1)

(Parent Munim Nephew2)
(Male Nephew2)
(Parent Munim Niece2)
(Female Niece2)

 ; Define functions for obtaining new information from the Atomspace
(= (get-parents $y)
    (match &self (Parent $x $y) $x))

(= (get-children $x)
    (match &self (Parent $x $y) $y))

(= (get-father $x)
    (match &self
        (, (Parent $y $x)
            (Male $y))
        $y
    )
)

(= (get-brothers $x)
    (match &self
        (, (Parent $y $x)
            (Parent $y $z)
            (Male $z))
        $z
    )
)

 ; Call the functions with some entries in the Atomspace

 ; Write the following functions: get-mother, get-sisters, get-siblings, get-grandparents, get-grandfather, get-grandmother, get-uncles, get-aunts, get-nieces, get-nephews.
( = (get-mother $x)
    (match &self
        (, (Parent $y $x) (Female $y))
        $y
    )
)

( = (get-sisters $x)
    (match &self
        (, (Parent $y $x) (Parent $y $z) (Female $z))
        $z ; returns doubled because it matches for both Mother and Father separately
    )
)

( = (get-siblings $x)
    (match &self
        (, (Parent $y $x) (Parent $y $z)) $z)
)

( = (get-grandparents $x)
    (match &self
        (, (Parent $y $x) (Parent $z $y))
        $z
    )
)

( = (get-grandmother $x)
    (match &self
        (, (Parent $y $x) (Parent $z $y) (Female $z))
        $z
    )
)

( = (get-grandfather $x)
    (match &self
        (, (Parent $y $x) (Parent $z $y) (Male $z))
        $z
    )
)

 ; get-uncles, get-aunts, get-nieces, get-nephews.

( = (get-uncles $x)
    (get-brothers (get-parents $x))
)
! (get-uncles Nephew1)

( = (get-aunts $x)
    (get-sisters (get-parents $x))
)
! (get-aunts Nephew2)

( = (get-nieces $x)
    (match &self
        (, (Parent $y $x) (Parent $y $z) (Parent $z $n) (Female $n) )
        $n)
)
! (get-nieces Munim)

( = (get-nephews $x)
    (match &self
        (, (Parent $y $x) (Parent $y $z) (Parent $z $n) (Male $n) )
        $n)
)
! (get-nephews Munim)

( = (get-nth-predecessors $person $n)
    (if (> $n 0)
        (get-nth-predecessors (get-parents $person) (- $n 1))
        $person
    )
)

! (get-parents Munim) ; [Kedija, Abdella]
! (get-children Kedija) ; [Munim, Hanim]
! (get-father Munim) ; [Abdella]
! (get-brothers Kedija) ; [Munim, Munim] ... Munim can't be a brother of himself,but
! (get-grandparents Munim)
! (get-grandmother Munim)
! (get-grandfather Munim)
! (get-mother Munim)
! (get-sisters Munim)
! (get-siblings Munim)
! (get-nth-predecessors Munim 3) ; should return Habtamu, Chala, Chemeda, Hundessa