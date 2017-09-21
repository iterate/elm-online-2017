Endre counters slik at modellen er en record som inneholder to tellere, `counter1: Int` og `counter2: Int`.
Dupliser litt kode i view og Msg slik at man kan oppdatere disse tellerne og de vises.

Ikke tenk for mye på gjenbruk av kode. Det kommer vi til i neste runde.


## Tips

```elm
type alias Person
    { name: String
    , address: String
    , age: Int
    }

updatePerson : Person -> Person
updatePerson person =
    { person | age = person.age + 1}
```

## Ekstraoppgave

Lag to knapper til for hver teller. Disse skal legge til og trekke fra 10.