
1.cleaning the data

trim_galore -q 20 --stringency 1 --fastqc --length 50 -o ./ --paired --trim1 --phred33 \
            -a AGATCGGAAGAGC -a2 AGATCGGAAGAGC *.R1.fastq.gz *.R2.fastq.gz

for i in `ls *.R1.fastq.gz`
do
id=$(basename $i .R1.fastq.gz)
fastp -i $i -I ${id}.R2.fastq.gz -o ${id}_clean.R1.fq.gz -O ${id}_clean.R2.fq.gz --thread=5 \
            --detect_adapter_for_pe --length_required=50 -h ${id}.html -j ${id}.json
done

2.转换效率
for i in `ls *_clean.R1.fq.gz`
do
id=$(basename $i _clean.R1.fq.gz)
bismark --parallel 5 --output_dir ./01_zhuanhua/ --gzip --nucleotide_coverage 20_lambda/ -1 $i -2 ${id}_clean.R2.fq.gz
done
# 对lambda序列进行index
$ ll 20_lambda/ 
total 512K
drwxr-xr-x 4 zqq20190923 student 4.0K Jan 21  2021 Bisulfite_Genome
-rw-r--r-- 1 zqq20190923 student  160 Jan 21  2021 genomic_nucleotide_frequencies.txt
-rw-r--r-- 1 zqq20190923 student  49K Jan 21  2021 lambda.fa

3. mapping
# index of genome for bismark：~/index/rice_bismark_for_DNA/ 
for i in `ls *R1.fq.gz`
do
id=$(basename $i R1.fq.gz)
bismark --bowtie2 -p 20 -N 0 -L 20 --temp_dir tmp_dir --genome ~/index/rice_bismark_for_DNA/ -1 ${i} -2 ${id}R2.fq.gz
done

for i in `ls *.bam`
do
deduplicate_bismark -p $i --bam
done

4.提取甲基化
for i in `ls *bam`
do
bismark_methylation_extractor --parallel 10 -p --no_overlap --bedGraph --comprehensive --counts --buffer_size 20G --gzip --cytosine_report --CX --genome_folder ~/index/rice_bismark_for_DNA/ $i
done

5.甲基化文件格式转化
for i in `ls ../*CX*`
do
id=$(basename $i .CX_report.txt.gz)
cgmaptools convert bismark2cgmap -i $i -o ${id}.CGmap.gz
done


cgmaptools intersect -C CG -1 BCD_filter5.CGmap.gz -2 CK_filter5.CGmap.gz |cgmaptools dmr -s 100 -S 500 -o 01_DMR/DMR_BCDvsCK_CG.gz
cgmaptools intersect -C CHG -1 BCD_filter5.CGmap.gz -2 CK_filter5.CGmap.gz |cgmaptools dmr -s 100 -S 500 -o 01_DMR/DMR_BCDvsCK_CHG.gz
cgmaptools intersect -C CHH -1 BCD_filter5.CGmap.gz -2 CK_filter5.CGmap.gz |cgmaptools dmr -s 100 -S 500 -o 01_DMR/DMR_BCDvsCK_CHH.gz
cgmaptools intersect -1 BCD_filter5.CGmap.gz -2 CK_filter5.CGmap.gz |cgmaptools dmr -s 100 -S 500 -o DMR_BCDvsCK_all.gz

cgmaptools intersect -C CG -1 BCD_filter5.CGmap.gz -2 CK_filter5.CGmap.gz |cgmaptools dms -o 02_DMS/DMS_BCDvsCK_CG.gz
cgmaptools intersect -C CHG -1 BCD_filter5.CGmap.gz -2 CK_filter5.CGmap.gz |cgmaptools dms -o 02_DMS/DMS_BCDvsCK_CHG.gz
cgmaptools intersect -C CHH -1 BCD_filter5.CGmap.gz -2 CK_filter5.CGmap.gz |cgmaptools dms -o 02_DMS/DMS_BCDvsCK_CHH.gz
cgmaptools intersect -1 BCD_filter5.CGmap.gz -2 CK_filter5.CGmap.gz |cgmaptools dms -o DMS_BCDvsCK_all.gz