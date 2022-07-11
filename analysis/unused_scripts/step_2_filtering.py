'''Filter the dataset with the consistency filtering.

Author: David Kaplan
Date: 11/18/20
MDSINE2 version: 4.0.6

Methodology
-----------
1) Load in dataset
   This is a pickle of an `mdsine2.Study` object. This can be created with the 
   `MDSINE2.gibson_1_preprocessing.py` script. To quickly generate this pickle:
    ```python
    import mdsine2
    dset = mdsine2.dataset.gibson()
    dset.save('file/location.pkl')
    ```
2) Perform filtering
   Filter out the Taxa/OTUs that do not have enough dynamical information for 
   effective inference.
3) Save the filtered dataset
'''
import argparse
import mdsine2 as md2

if __name__ == '__main__':
    parser = argparse.ArgumentParser(usage=__doc__)
    parser.add_argument('--dataset', '-i', type=str, dest='dataset',
        help='This is the Gibson dataset that you want to parse')
    parser.add_argument('--outfile', '-o', type=str, dest='outfile',
        help='This is where you want to save the parsed dataset')
    parser.add_argument('--dtype', '-d', type=str, dest='dtype',
        help='This is what data we are thresholding. Options are "raw" (counts), "rel" (relative ' \
             'abundance), or "abs" (absolute abundance).')
    parser.add_argument('--threshold', '-t', type=float, dest='threshold',
        help='This is the threshold the taxon must pass at each timepoint')
    parser.add_argument('--min-num-consecutive', '-m', type=int, dest='min_num_consecutive',
        help='Number of consecutive timepoints to look for in a row')
    parser.add_argument('--min-num-subjects', '-s', type=int, dest='min_num_subjects',
        help='This is the minimum number of subjects this needs to be valid for.')
    parser.add_argument('--colonization-time', '-c', type=int, dest='colonization_time',
        help='This is the time we are looking after for colonization. Default to nothing', default=None)
    parser.add_argument('--max-n-otus', type=int, dest='max_n_otus',
        help='If defined, truncates the OTUs to only the `--max-n-otus` top OTUs and removes everything else',
        default=None)

    args = parser.parse_args()

    study = md2.Study.load(args.dataset)
    study = md2.consistency_filtering(subjset=study,
        dtype=args.dtype,
        threshold=args.threshold,
        min_num_consecutive=args.min_num_consecutive,
        min_num_subjects=args.min_num_subjects,
        colonization_time=args.colonization_time)

    if args.max_n_otus is not None:
        n = args.max_n_otus
        if n <= 0:
            raise ValueError('`max_n_otus` ({}) must be > 0'.format(n))
        to_delete = []
        for taxon in study.taxa:
            if taxon.idx >= n:
                to_delete.append(taxon.name)
        study.pop_taxa(to_delete)

    print('{} taxa left in {}'.format(len(study.taxa), study.name))
    study.save(args.outfile)
