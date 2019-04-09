OUTDIR=./out
mkdir -p $OUTDIR

IN=$1
IN_FORMAT=$IN.format.mei
OUT=$OUTDIR/out.mei
OUT_FORMAT=$OUTDIR/out.format.mei

rm $OUT
rm $OUT_FORMAT

xmllint --format $IN > $IN_FORMAT
saxon -s:$IN_FORMAT -xsl:mutation.xsl -o:$OUT
xmllint --format $OUT > $OUT_FORMAT
