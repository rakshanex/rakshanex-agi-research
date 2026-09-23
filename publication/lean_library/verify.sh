#!/bin/bash
export PATH="$HOME/.elan/bin:$PATH"
lean RakshanexNumberTheory.lean && echo "LIBRARY VERIFIED: 0 errors, kernel-checked"
