Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D446E2A4EA
	for <lists+linux-scsi@lfdr.de>; Sat, 25 May 2019 16:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfEYOjG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 25 May 2019 10:39:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:4554 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfEYOjF (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 25 May 2019 10:39:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 May 2019 07:39:05 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 May 2019 07:39:04 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hUXp9-000EQy-MY; Sat, 25 May 2019 22:39:03 +0800
Date:   Sat, 25 May 2019 22:38:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     kbuild-all@01.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
Subject: Re: [PATCH 05/19] sg: replace rq array with lists
Message-ID: <201905252216.aVjzTqbr%lkp@intel.com>
References: <20190524184809.25121-6-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524184809.25121-6-dgilbert@interlog.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Douglas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on next-20190524]
[cannot apply to v5.2-rc1]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Douglas-Gilbert/sg-v4-interface-rq-sharing-multiple-rqs/20190525-161346
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/scsi/sg.c:2808:20: sparse: sparse: incorrect type in initializer (different base types) @@    expected int gfp @@    got restricted gfp_t [usertyint gfp @@
>> drivers/scsi/sg.c:2808:20: sparse:    expected int gfp
>> drivers/scsi/sg.c:2808:20: sparse:    got restricted gfp_t [usertype]
>> drivers/scsi/sg.c:2811:51: sparse: sparse: restricted gfp_t degrades to integer
>> drivers/scsi/sg.c:2811:49: sparse: sparse: incorrect type in argument 2 (different base types) @@    expected restricted gfp_t [usertype] flags @@    got  [usertype] flags @@
>> drivers/scsi/sg.c:2811:49: sparse:    expected restricted gfp_t [usertype] flags
>> drivers/scsi/sg.c:2811:49: sparse:    got unsigned int
   drivers/scsi/sg.c:2813:51: sparse: sparse: restricted gfp_t degrades to integer
   drivers/scsi/sg.c:2813:49: sparse: sparse: incorrect type in argument 2 (different base types) @@    expected restricted gfp_t [usertype] flags @@    got  [usertype] flags @@
   drivers/scsi/sg.c:2813:49: sparse:    expected restricted gfp_t [usertype] flags
   drivers/scsi/sg.c:2813:49: sparse:    got unsigned int
   include/linux/spinlock.h:393:9: sparse: sparse: context imbalance in 'sg_add_request' - different lock contexts for basic block

vim +2808 drivers/scsi/sg.c

  2797	
  2798	/*
  2799	 * Makes a new sg_request object. If 'first' is set then use GFP_KERNEL which
  2800	 * may take time but has improved chance of success, otherwise use GFP_ATOMIC.
  2801	 * Note that basic initialization is done but srp is not added to either sfp
  2802	 * list. On error returns twisted negated errno value (not NULL).
  2803	 */
  2804	static struct sg_request *
  2805	sg_mk_srp(struct sg_fd *sfp, bool first)
  2806	{
  2807		struct sg_request *srp;
> 2808		int gfp =  __GFP_NOWARN;
  2809	
  2810		if (first)      /* prepared to wait if none already outstanding */
> 2811			srp = kzalloc(sizeof(*srp), gfp | GFP_KERNEL);
  2812		else
  2813			srp = kzalloc(sizeof(*srp), gfp | GFP_ATOMIC);
  2814		if (srp) {
  2815			spin_lock_init(&srp->req_lck);
  2816			atomic_set(&srp->rq_st, SG_RS_INACTIVE);
  2817			srp->parentfp = sfp;
  2818			return srp;
  2819		} else {
  2820			return ERR_PTR(-ENOMEM);
  2821		}
  2822	}
  2823	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
