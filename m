Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8745D576
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Nov 2021 08:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhKYHck (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Nov 2021 02:32:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:29119 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234057AbhKYHaj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 25 Nov 2021 02:30:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="234192255"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="234192255"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 23:27:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="675142606"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Nov 2021 23:27:26 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq9AD-0005xm-Cq; Thu, 25 Nov 2021 07:27:25 +0000
Date:   Thu, 25 Nov 2021 15:26:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Shelekhin <k.shelekhin@yadro.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        target-devel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-scsi@vger.kernel.org,
        linux@yadro.com, Konstantin Shelekhin <k.shelekhin@yadro.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>
Subject: Re: [PATCH 2/2] scsi: target: iblock: Report space allocation errors
Message-ID: <202111251517.Xys8GZym-lkp@intel.com>
References: <20211020184319.588002-3-k.shelekhin@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020184319.588002-3-k.shelekhin@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Konstantin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on v5.16-rc2 next-20211125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Konstantin-Shelekhin/scsi-target-iblock-Report-space-allocation-errors/20211021-024526
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
config: i386-randconfig-s001-20211021 (https://download.01.org/0day-ci/archive/20211125/202111251517.Xys8GZym-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/15d4d8f9601b04ee21f8f6042481828c4c34f6b7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Konstantin-Shelekhin/scsi-target-iblock-Report-space-allocation-errors/20211021-024526
        git checkout 15d4d8f9601b04ee21f8f6042481828c4c34f6b7
        # save the config file to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/target/target_core_iblock.c:329:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted blk_status_t [usertype] status @@     got int @@
   drivers/target/target_core_iblock.c:329:57: sparse:     expected restricted blk_status_t [usertype] status
   drivers/target/target_core_iblock.c:329:57: sparse:     got int
>> drivers/target/target_core_iblock.c:351:61: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int new @@     got restricted blk_status_t [usertype] bi_status @@
   drivers/target/target_core_iblock.c:351:61: sparse:     expected int new
   drivers/target/target_core_iblock.c:351:61: sparse:     got restricted blk_status_t [usertype] bi_status

vim +329 drivers/target/target_core_iblock.c

   319	
   320	static void iblock_complete_cmd(struct se_cmd *cmd)
   321	{
   322		struct iblock_req *ibr = cmd->priv;
   323		u8 status;
   324		sense_reason_t reason;
   325	
   326		if (!refcount_dec_and_test(&ibr->pending))
   327			return;
   328	
 > 329		reason = iblock_blk_status_to_reason(atomic_read(&ibr->status));
   330	
   331		if (reason != TCM_NO_SENSE)
   332			status = SAM_STAT_CHECK_CONDITION;
   333		else
   334			status = SAM_STAT_GOOD;
   335	
   336		target_complete_cmd_with_sense(cmd, status, reason);
   337		kfree(ibr);
   338	}
   339	
   340	static void iblock_bio_done(struct bio *bio)
   341	{
   342		struct se_cmd *cmd = bio->bi_private;
   343		struct iblock_req *ibr = cmd->priv;
   344	
   345		if (bio->bi_status) {
   346			pr_err("bio error: %p,  err: %d\n", bio, bio->bi_status);
   347			/*
   348			 * Set the error status of the iblock request to the error
   349			 * status of the first failed bio.
   350			 */
 > 351			atomic_cmpxchg(&ibr->status, BLK_STS_OK, bio->bi_status);
   352			smp_mb__after_atomic();
   353		}
   354	
   355		bio_put(bio);
   356	
   357		iblock_complete_cmd(cmd);
   358	}
   359	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
