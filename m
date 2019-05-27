Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B29F2B038
	for <lists+linux-scsi@lfdr.de>; Mon, 27 May 2019 10:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfE0IbN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 May 2019 04:31:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59270 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0IbN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 27 May 2019 04:31:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4R8TwIj095476;
        Mon, 27 May 2019 08:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=eoo1aItEsbJQg1+Af/In4J3JQ+v4KH92vEv90TgWcBI=;
 b=WjDjtfpMFAbTHLOtywzWHmsnVaTMYUIyLTC8vzJjbHUsrQ3zCws28HCvsGUrDxmitdg5
 rLQe1Uuobza0dT6pNAHFnklUlEQCcWPnHhvZZpChaBJaC64Enf/aB0bKoXyTeaNrO/cT
 EOsmd4bkvt1gpB3gkfHddAcJK+b0Z2PFjjCkbHYujaFZjQNO3bc02z3G2x0+Vn7Jrw4U
 mPuWLmj7LAMX5hwUscKJnVhmNpnTrGwI8INxC+qt2y3cUY98QaLsUM3oulWpIuemmVAF
 2rIIMb0N4pHigWVkq0acdq6foqgkDgQAATSv+g1SykCilBwvrFdIJWV4j6sYCHYxC0mo IA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2spu7d56fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 08:31:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4R8SHGm174710;
        Mon, 27 May 2019 08:29:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2sqh72k2sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 08:29:01 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4R8T0LD025347;
        Mon, 27 May 2019 08:29:00 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 May 2019 01:28:59 -0700
Date:   Mon, 27 May 2019 11:28:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Douglas Gilbert <dgilbert@interlog.com>
Cc:     kbuild-all@01.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: Re: [PATCH 13/19] sg: sgat_elem_sz and sum_fd_dlens
Message-ID: <20190527082852.GF24680@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524184809.25121-14-dgilbert@interlog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905270060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905270060
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
drivers/scsi/sg.c:3374 sg_remove_sgat() error: we previously assumed 'sfp' could be null (see line 3367)

Old smatch warnings:
drivers/scsi/sg.c:4383 sg_proc_seq_show_dbg() warn: returning -1 instead of -ENOMEM is sloppy

# https://github.com/0day-ci/linux/commit/ecbddf3329c05a33a780f39084acb2f104067d6a
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout ecbddf3329c05a33a780f39084acb2f104067d6a
vim +/sfp +3374 drivers/scsi/sg.c

c5ad643d Douglas Gilbert 2019-05-24  3358  
c5ad643d Douglas Gilbert 2019-05-24  3359  /* Remove the data (possibly a sgat list) held by srp, not srp itself */
c5ad643d Douglas Gilbert 2019-05-24  3360  static void
c5ad643d Douglas Gilbert 2019-05-24  3361  sg_remove_sgat(struct sg_request *srp)
c5ad643d Douglas Gilbert 2019-05-24  3362  {
c5ad643d Douglas Gilbert 2019-05-24  3363  	struct sg_scatter_hold *schp = &srp->sgat_h; /* care: remove own data */
c5ad643d Douglas Gilbert 2019-05-24  3364  	struct sg_fd *sfp = srp->parentfp;
c5ad643d Douglas Gilbert 2019-05-24  3365  	struct sg_device *sdp;
c5ad643d Douglas Gilbert 2019-05-24  3366  
c5ad643d Douglas Gilbert 2019-05-24 @3367  	sdp = (sfp ? sfp->parentdp : NULL);
                                                       ^^^
Null heck

c5ad643d Douglas Gilbert 2019-05-24  3368  	SG_LOG(4, sdp, "%s: num_sgat=%d%s\n", __func__, schp->num_sgat,
c5ad643d Douglas Gilbert 2019-05-24  3369  	       ((srp->parentfp ? (sfp->rsv_srp == srp) : false) ?
c5ad643d Douglas Gilbert 2019-05-24  3370  		" [rsv]" : ""));
c5ad643d Douglas Gilbert 2019-05-24  3371  	if (!test_bit(SG_FRQ_DIO_IN_USE, srp->frq_bm))
c5ad643d Douglas Gilbert 2019-05-24  3372  		sg_remove_sgat_helper(sdp, schp);
c5ad643d Douglas Gilbert 2019-05-24  3373  
ecbddf33 Douglas Gilbert 2019-05-24 @3374  	if (sfp->tot_fd_thresh > 0) {
                                                    ^^^^^^^^^^^^^^^^^^
Unchecked dereference.

ecbddf33 Douglas Gilbert 2019-05-24  3375  		/* this is a subtraction, error if it goes negative */
ecbddf33 Douglas Gilbert 2019-05-24  3376  		if (atomic_add_negative(-schp->buflen, &sfp->sum_fd_dlens)) {
ecbddf33 Douglas Gilbert 2019-05-24  3377  			SG_LOG(2, sfp->parentdp,
ecbddf33 Douglas Gilbert 2019-05-24  3378  			       "%s: logic error: this dlen > %s\n",
ecbddf33 Douglas Gilbert 2019-05-24  3379  			       __func__, "sum_fd_dlens");
ecbddf33 Douglas Gilbert 2019-05-24  3380  			atomic_set(&sfp->sum_fd_dlens, 0);
ecbddf33 Douglas Gilbert 2019-05-24  3381  		}
ecbddf33 Douglas Gilbert 2019-05-24  3382  	}
c5ad643d Douglas Gilbert 2019-05-24  3383  	memset(schp, 0, sizeof(*schp));         /* zeros buflen and dlen */
^1da177e Linus Torvalds  2005-04-16  3384  }
^1da177e Linus Torvalds  2005-04-16  3385  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
