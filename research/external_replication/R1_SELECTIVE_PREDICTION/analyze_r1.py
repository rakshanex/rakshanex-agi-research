"""R1 analysis: recompute selective-prediction metrics from raw/candidate_locked.json. CPU, stdlib only."""
import json,math,sys
from collections import defaultdict
def wilson(k,n,z=1.96):
    if n==0:return(0,0,0)
    p=k/n;d=1+z*z/n;c=(p+z*z/(2*n))/d;h=z*math.sqrt(p*(1-p)/n+z*z/(4*n*n))/d;return(round(p,4),round(max(0,c-h),4),round(min(1,c+h),4))
cl=json.load(open("raw/candidate_locked.json"))
agg=defaultdict(lambda:[0,0,0])
for r in cl: agg[r['policy']][0]+=r.get('answered',0);agg[r['policy']][1]+=r.get('correct',0);agg[r['policy']][2]+=r.get('confident_wrong',0)
out={}
for pol,(ans,cor,cw) in sorted(agg.items()):
    out[pol]={"answered":ans,"accuracy":round(cor/ans,4) if ans else None,"acc_ci95":wilson(cor,ans),"confident_wrong":cw,"cw_rate":round(cw/ans,4) if ans else None}
print(json.dumps(out,indent=2))
json.dump(out,open("analysis/R1_ANALYSIS.json","w"),indent=2)
