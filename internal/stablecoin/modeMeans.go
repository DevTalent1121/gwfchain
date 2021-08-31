package stablecoin

type Means struct {
	Mean3Hr  float64
	Mean12Hr float64
	Mean24Hr float64
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
	m.Mean3Hr = 0.0 	// 2700 blocks every 3 hours
	m.Mean12Hr = 0.0 	// 10,800 blocks every 12 hours
	m.Mean24Hr = 0.0 	// 21,600 blocks per day
	m.Mean1Wk = 0.0 	// 151,200 blocks per week
	m.Mean1Mo = 0.0 	// 657,000 blocks per month
	m.Mean3Mo = 0.0 	// 1,971,000 blocks per quarter
	m.Mean6Mo = 0.0 	// 3,942,000 blocks for semi-annual
	m.Mean1Yr = 0.0 	// 7,884,000 blocks per year
}

