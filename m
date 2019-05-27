Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD522AF41
	for <lists+linux-scsi@lfdr.de>; Mon, 27 May 2019 09:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfE0HMC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 May 2019 03:12:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33774 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfE0HMC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 27 May 2019 03:12:02 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4R74FMd023222;
        Mon, 27 May 2019 07:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=FVrw2RHcub7v4u0eKQMazlxbD/JdfSIgqrb4uCX8Vi0=;
 b=JkYGLmnV9n6rVY81qrsDMrIKPuK0fg3elCyo+5VF1qkXT7xFnC5XTSRIvR09QbA0H7OO
 g9hd4s0le4+QtU6G8J9x2Mrjv8VtVAH5Tw4hd5DT72svkza4rBV9l5KoKZDF5yTTS+0r
 vAecY67qXeiVSAsLm3EOxp5tawia6GAetdLkH/UWP9DWBkUPqJFZykByM0bqHRnXpU+R
 WK2o4/ocBrlF34jwqiV59LDoh52qoWpe1lPHkvzM+ej951evEVCns75Ibi5pTR+a1Pg+
 MuSTUQrMjP8JdZqKKq6oYaixFc46BDtyyJSTdDrA6CsoKykNY+YKSRmxTPt7+CIEk10b 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2spu7d4s6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 07:11:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4R7BkfG158344;
        Mon, 27 May 2019 07:11:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2sqcmjkap4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 07:11:51 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4R7Bo94010388;
        Mon, 27 May 2019 07:11:50 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 May 2019 00:11:49 -0700
Date:   Mon, 27 May 2019 10:11:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Douglas Gilbert <dgilbert@interlog.com>
Cc:     kbuild-all@01.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: Re: [PATCH 05/19] sg: replace rq array with lists
Message-ID: <20190527071142.GD24680@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524184809.25121-6-dgilbert@interlog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905270050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905270050
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Douglas,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Douglas-Gilbert/sg-v4-interface-rq-sharing-multiple-rqs/20190525-161346
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/scsi/sg.c:3637 sg_proc_seq_show_dbg() warn: returning -1 instead of -ENOMEM is sloppy

Old smatch warnings:
drivers/scsi/sg.c:3520 sg_proc_dbg_sreq() error: uninitialized symbol 'is_dur'.

# https://github.com/0day-ci/linux/commit/c5ad643d999d34c92f76e1459be33e2c1321f699
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout c5ad643d999d34c92f76e1459be33e2c1321f699
vim +3637 drivers/scsi/sg.c

c5ad643d9 Douglas Gilbert 2019-05-24  3610  
c5ad643d9 Douglas Gilbert 2019-05-24  3611  /* Called via dbg_seq_ops once for each sg device */
b600cfdd9 Douglas Gilbert 2019-05-24  3612  static int
c5ad643d9 Douglas Gilbert 2019-05-24  3613  sg_proc_seq_show_dbg(struct seq_file *s, void *v)
^1da177e4 Linus Torvalds  2005-04-16  3614  {
c5ad643d9 Douglas Gilbert 2019-05-24  3615  	bool found = false;
c5ad643d9 Douglas Gilbert 2019-05-24  3616  	bool trunc = false;
c5ad643d9 Douglas Gilbert 2019-05-24  3617  	const int bp_len = SG_PROC_DEBUG_SZ;
c5ad643d9 Douglas Gilbert 2019-05-24  3618  	int n = 0;
c5ad643d9 Douglas Gilbert 2019-05-24  3619  	int k = 0;
c5ad643d9 Douglas Gilbert 2019-05-24  3620  	unsigned long iflags;
^1da177e4 Linus Torvalds  2005-04-16  3621  	struct sg_proc_deviter *it = (struct sg_proc_deviter *)v;
b600cfdd9 Douglas Gilbert 2019-05-24  3622  	struct sg_device *sdp;
c5ad643d9 Douglas Gilbert 2019-05-24  3623  	int *fdi_p;
c5ad643d9 Douglas Gilbert 2019-05-24  3624  	char *bp;
c5ad643d9 Douglas Gilbert 2019-05-24  3625  	char *disk_name;
c5ad643d9 Douglas Gilbert 2019-05-24  3626  	char b1[128];
^1da177e4 Linus Torvalds  2005-04-16  3627  
c5ad643d9 Douglas Gilbert 2019-05-24  3628  	b1[0] = '\0';
cc833acbe Douglas Gilbert 2014-06-25  3629  	if (it && (0 == it->index))
cc833acbe Douglas Gilbert 2014-06-25  3630  		seq_printf(s, "max_active_device=%d  def_reserved_size=%d\n",
c5ad643d9 Douglas Gilbert 2019-05-24  3631  			   (int)it->max, def_reserved_size);
c5ad643d9 Douglas Gilbert 2019-05-24  3632  	fdi_p = it ? &it->fd_index : &k;
c5ad643d9 Douglas Gilbert 2019-05-24  3633  	bp = kzalloc(bp_len, __GFP_NOWARN | GFP_KERNEL);
c5ad643d9 Douglas Gilbert 2019-05-24  3634  	if (!bp) {
c5ad643d9 Douglas Gilbert 2019-05-24  3635  		seq_printf(s, "%s: Unable to allocate %d on heap, finish\n",
c5ad643d9 Douglas Gilbert 2019-05-24  3636  			   __func__, bp_len);
c5ad643d9 Douglas Gilbert 2019-05-24 @3637  		return -1;
                                                        ^^^^^^^^^
-1 is -EPERM.

c5ad643d9 Douglas Gilbert 2019-05-24  3638  	}
c6517b794 Tony Battersby  2009-01-21  3639  	read_lock_irqsave(&sg_index_lock, iflags);
c6517b794 Tony Battersby  2009-01-21  3640  	sdp = it ? sg_lookup_dev(it->index) : NULL;
cc833acbe Douglas Gilbert 2014-06-25  3641  	if (NULL == sdp)
cc833acbe Douglas Gilbert 2014-06-25  3642  		goto skip;
c5ad643d9 Douglas Gilbert 2019-05-24  3643  	read_lock(&sdp->sfd_llock);
cc833acbe Douglas Gilbert 2014-06-25  3644  	if (!list_empty(&sdp->sfds)) {
c5ad643d9 Douglas Gilbert 2019-05-24  3645  		found = true;
c5ad643d9 Douglas Gilbert 2019-05-24  3646  		disk_name = (sdp->disk ? sdp->disk->disk_name : "?_?");
cc833acbe Douglas Gilbert 2014-06-25  3647  		if (atomic_read(&sdp->detaching))
c5ad643d9 Douglas Gilbert 2019-05-24  3648  			snprintf(b1, sizeof(b1), " >>> device=%s  %s\n",
c5ad643d9 Douglas Gilbert 2019-05-24  3649  				 disk_name, "detaching pending close\n");
cc833acbe Douglas Gilbert 2014-06-25  3650  		else if (sdp->device) {
c5ad643d9 Douglas Gilbert 2019-05-24  3651  			n = sg_proc_dbg_sdev(sdp, bp, bp_len, fdi_p);
c5ad643d9 Douglas Gilbert 2019-05-24  3652  			if (n >= bp_len - 1) {
c5ad643d9 Douglas Gilbert 2019-05-24  3653  				trunc = true;
c5ad643d9 Douglas Gilbert 2019-05-24  3654  				if (bp[bp_len - 2] != '\n')
c5ad643d9 Douglas Gilbert 2019-05-24  3655  					bp[bp_len - 2] = '\n';
c5ad643d9 Douglas Gilbert 2019-05-24  3656  			}
c5ad643d9 Douglas Gilbert 2019-05-24  3657  		} else {
c5ad643d9 Douglas Gilbert 2019-05-24  3658  			snprintf(b1, sizeof(b1), " >>> device=%s  %s\n",
c5ad643d9 Douglas Gilbert 2019-05-24  3659  				 disk_name, "sdp->device==NULL, skip");
cc833acbe Douglas Gilbert 2014-06-25  3660  		}
^1da177e4 Linus Torvalds  2005-04-16  3661  	}
c5ad643d9 Douglas Gilbert 2019-05-24  3662  	read_unlock(&sdp->sfd_llock);
cc833acbe Douglas Gilbert 2014-06-25  3663  skip:
c6517b794 Tony Battersby  2009-01-21  3664  	read_unlock_irqrestore(&sg_index_lock, iflags);
c5ad643d9 Douglas Gilbert 2019-05-24  3665  	if (found) {
c5ad643d9 Douglas Gilbert 2019-05-24  3666  		if (n > 0) {
c5ad643d9 Douglas Gilbert 2019-05-24  3667  			seq_puts(s, bp);
c5ad643d9 Douglas Gilbert 2019-05-24  3668  			if (seq_has_overflowed(s))
c5ad643d9 Douglas Gilbert 2019-05-24  3669  				goto s_ovfl;
c5ad643d9 Douglas Gilbert 2019-05-24  3670  			if (trunc)
c5ad643d9 Douglas Gilbert 2019-05-24  3671  				seq_printf(s, "   >> Output truncated %s\n",
c5ad643d9 Douglas Gilbert 2019-05-24  3672  					   "due to buffer size");
c5ad643d9 Douglas Gilbert 2019-05-24  3673  		} else if (b1[0]) {
c5ad643d9 Douglas Gilbert 2019-05-24  3674  			seq_puts(s, b1);
c5ad643d9 Douglas Gilbert 2019-05-24  3675  			if (seq_has_overflowed(s))
c5ad643d9 Douglas Gilbert 2019-05-24  3676  				goto s_ovfl;
c5ad643d9 Douglas Gilbert 2019-05-24  3677  		}
c5ad643d9 Douglas Gilbert 2019-05-24  3678  	}
c5ad643d9 Douglas Gilbert 2019-05-24  3679  s_ovfl:
c5ad643d9 Douglas Gilbert 2019-05-24  3680  	kfree(bp);
^1da177e4 Linus Torvalds  2005-04-16  3681  	return 0;
^1da177e4 Linus Torvalds  2005-04-16  3682  }
^1da177e4 Linus Torvalds  2005-04-16  3683  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
