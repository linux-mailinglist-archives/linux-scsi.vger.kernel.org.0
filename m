Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E60F8F1BD
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Apr 2019 10:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfD3ICa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Apr 2019 04:02:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:36527 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfD3ICa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 30 Apr 2019 04:02:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 01:02:29 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2019 01:02:28 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hLNid-000HDV-Oy; Tue, 30 Apr 2019 16:02:27 +0800
Date:   Tue, 30 Apr 2019 16:02:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ondrej Zary <linux@zary.sk>
Cc:     kbuild-all@01.org, linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [scsi:misc 301/301] drivers/scsi/fdomain.c:442:12: sparse: sparse:
 context imbalance in 'fdomain_host_reset' - wrong count at exit
Message-ID: <201904301607.g1dqOnQ8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Ondrej,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git misc
head:   9bee24d08c08a08464b97e1da5c37acbc57a67df
commit: 9bee24d08c08a08464b97e1da5c37acbc57a67df [301/301] scsi: fdomain: Resurrect driver - PCI support
reproduce:
        # apt-get install sparse
        git checkout 9bee24d08c08a08464b97e1da5c37acbc57a67df
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/scsi/fdomain.c:442:12: sparse: sparse: context imbalance in 'fdomain_host_reset' - wrong count at exit

vim +/fdomain_host_reset +442 drivers/scsi/fdomain.c

92408047 Ondrej Zary 2019-04-29  441  
92408047 Ondrej Zary 2019-04-29 @442  static int fdomain_host_reset(struct scsi_cmnd *cmd)
92408047 Ondrej Zary 2019-04-29  443  {
92408047 Ondrej Zary 2019-04-29  444  	struct Scsi_Host *sh = cmd->device->host;
92408047 Ondrej Zary 2019-04-29  445  	struct fdomain *fd = shost_priv(sh);
92408047 Ondrej Zary 2019-04-29  446  	unsigned long flags;
92408047 Ondrej Zary 2019-04-29  447  
92408047 Ondrej Zary 2019-04-29  448  	spin_lock_irqsave(sh->host_lock, flags);
92408047 Ondrej Zary 2019-04-29  449  	fdomain_reset(fd->base);
92408047 Ondrej Zary 2019-04-29  450  	spin_lock_irqsave(sh->host_lock, flags);
92408047 Ondrej Zary 2019-04-29  451  	return SUCCESS;
92408047 Ondrej Zary 2019-04-29  452  }
92408047 Ondrej Zary 2019-04-29  453  

:::::: The code at line 442 was first introduced by commit
:::::: 9240804729fef84f15b018e27e398b9a79ac94d7 scsi: fdomain: Resurrect driver - core code

:::::: TO: Ondrej Zary <linux@zary.sk>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
