# CLEAN_ROOM_CHECK
Ran R1/R2/R3 from the package directory (not the original project dirs), fixed-seed, CPU, stdlib-only, no
cached outputs used (R2/R3 regenerate raw fresh; R1 recomputes from the frozen raw candidate set). Benchmark
hash verified MATCH. All three executed successfully and reproduced their results within this environment.
INDEPENDENCE: same operator + clean package environment => INTERNAL_CLEAN_ROOM (Independence Audit case B).
NOT external independent replication.
