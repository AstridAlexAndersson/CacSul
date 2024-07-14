module load angsd
#POP1xPOP2
winsfs [POP1_prefix].saf.idx [POP2_prefix].saf.idx -vv > [POP1xPOP2_2DSFS].sfs
#POP2xPOP3
winsfs [POP2_prefix].saf.idx [POP3_prefix].saf.idx -vv > [POP2xPOP3_2DSFS].sfs
