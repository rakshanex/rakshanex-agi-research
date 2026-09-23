#!/bin/bash
set -e; cd "$(dirname "$0")"
echo "[1] repo/benchmark integrity"
python3 -c "import json,hashlib;d=json.load(open('benchmark_v1_locked.json'));o={k:d[k] for k in d if k!='sha256'};assert hashlib.sha256(json.dumps(o,sort_keys=True).encode()).hexdigest()==d['sha256'];print('benchmark sha256 OK')"
echo "[2] required artifacts"
for f in ARC_TRANSFER_FINAL.json ZERO_COST_CLOSURE/three_family_synthesis.json; do [ -f "$f" ] && echo "  present: $f" || { echo "  MISSING $f"; exit 1; }; done
echo "[3] deterministic core analysis + compare to published"
python3 REPRODUCIBILITY/reproduce_core.py
echo "[4] classification check"
python3 -c "import json;d=json.load(open('ARC_TRANSFER_FINAL.json'));print('ARC determination:',d['determination']);assert d['A_wrong_B_right']==0,'capability signal would contradict published result'"
echo "RESULT: reproduction harness PASS (deterministic parts). Model-inference parts require a GPU + open-weight model (see guide)."
