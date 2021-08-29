package stablecoin

type Fiat struct {
	Continent string
	Name      string
	history   Means
}

func NewFiat(cont, name string) *Fiat {
	result := &Fiat{Continent: cont, Name: name, history: *NewMeans()}
	return result
}
