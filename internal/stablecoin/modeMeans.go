package stablecoin

type Means struct {
	Mean3Hr  float64
	Mean12Hr float64
	Mean24Hr float64
	Mean84Hr float64
	Mean1Wk  float64
	Mean1Mo  float64
	Mean3Mo  float64
	Mean6Mo  float64
	Mean1Yr  float64
}

func NewMeans() *Means {
	result := &Means{}
	result.Zero()
	return result
}

func (m *Means) Zero() {
	m.Mean3Hr = 0.0
	m.Mean3Hr = 0.0
	m.Mean12Hr = 0.0
	m.Mean24Hr = 0.0
	m.Mean84Hr = 0.0
	m.Mean1Wk = 0.0
	m.Mean1Mo = 0.0
	m.Mean3Mo = 0.0
	m.Mean6Mo = 0.0
	m.Mean1Yr = 0.0
}
