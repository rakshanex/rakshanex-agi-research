# BLINDNESS_AUDIT_BEFORE_FIX (2026-09-22)
| file | current location | leak type | SHA256 | action | destination |
|---|---|---|---|---|---|
| R1_ANALYSIS.json | R1/analysis/ | R1 expected result (S0..S4) | 729d8392… | RELOCATE | original_outputs/R1/ |
| failure_surface.json | R2/raw/ | R2 expected result (M4 0.033->1.0) | 6bc57d07… | RELOCATE | original_outputs/R2/ |
| stage1.json | R3/raw/ | R3 expected result (invariance) | 7ffc01f2… | RELOCATE | original_outputs/R3/ |
| candidate_locked.json | R1/raw/ | R1 INPUT that also contains per-record correct/confident_wrong (reveals result if inspected) | e71f6cbc… | KEEP-IN-PLACE (required input; runner cannot run without it) + LABEL as PUBLIC_RESULT_ARTIFACT | R1/raw/ |
NOTE: candidate_locked.json is a genuine dependency of analyze_r1.py (it is the locked candidate data being
scored). It cannot be relocated without breaking R1. It is documented as a post-run comparison artifact; a
truly blind R1 replicator should score from the benchmark independently — but the released R1 protocol scores
the locked candidate file, so R1 blindness is PARTIAL-BY-DESIGN and disclosed. R2 and R3 become fully blind.
