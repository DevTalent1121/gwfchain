package params

const (
	Version = "1.0.0" //Version = "3.4.7" - Forked GoChain Version
)

func VersionWithCommit(gitCommit string) string {
	vsn := Version
	if len(gitCommit) >= 8 {
		vsn += "-" + gitCommit[:8]
	}
	return vsn
}
