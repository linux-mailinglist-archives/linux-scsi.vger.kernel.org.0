Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DB44E800
	for <lists+linux-scsi@lfdr.de>; Fri, 21 Jun 2019 14:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfFUMb4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 21 Jun 2019 08:31:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:17853 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfFUMb4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 21 Jun 2019 08:31:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 05:31:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,400,1557212400"; 
   d="scan'208";a="358850790"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2019 05:31:54 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1heIht-00073N-J4; Fri, 21 Jun 2019 20:31:53 +0800
Date:   Fri, 21 Jun 2019 20:31:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@01.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: Re: [PATCH 5/6] qla2xxx: Make the code for freeing SRBs more
 systematic
Message-ID: <201906212040.xsQNBmoB%lkp@intel.com>
References: <20190617203847.184407-6-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617203847.184407-6-bvanassche@acm.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bart,

I love your patch! Perhaps something to improve:

[auto build test WARNING on scsi/for-next]
[also build test WARNING on v5.2-rc5 next-20190620]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bart-Van-Assche/qla2xxx-Make-qla2x00_abort_srb-again-decrease-the-sp-reference-count/20190618-094414
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/scsi/qla2xxx/qla_gs.c:517:1-3: ERROR: test of a variable/field address
   drivers/scsi/qla2xxx/qla_gs.c:524:1-3: ERROR: test of a variable/field address

vim +517 drivers/scsi/qla2xxx/qla_gs.c

   511	
   512	static void qla2x00_async_sns_sp_free(srb_t *sp)
   513	{
   514		struct scsi_qla_host *vha = sp->vha;
   515		struct ct_arg *ctarg = &sp->u.iocb_cmd.u.ctarg;
   516	
 > 517		if (&ctarg->rsp) {
   518			dma_free_coherent(&vha->hw->pdev->dev,
   519					  ctarg->rsp_allocated_size, ctarg->rsp,
   520					  ctarg->rsp_dma);
   521			ctarg->rsp = NULL;
   522		}
   523	
   524		if (&ctarg->req) {
   525			dma_free_coherent(&vha->hw->pdev->dev,
   526					  ctarg->req_allocated_size, ctarg->req,
   527					  ctarg->req_dma);
   528			ctarg->req = NULL;
   529		}
   530	
   531		qla2x00_sp_free(sp);
   532	}
   533	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
