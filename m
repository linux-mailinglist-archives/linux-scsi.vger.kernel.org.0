Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B11A5F37
	for <lists+linux-scsi@lfdr.de>; Sun, 12 Apr 2020 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgDLPpG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 12 Apr 2020 11:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgDLPpG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 12 Apr 2020 11:45:06 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Apr 2020 11:45:05 EDT
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBD9C0A3BE2
        for <linux-scsi@vger.kernel.org>; Sun, 12 Apr 2020 08:38:25 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.72,374,1580770800"; 
   d="scan'208";a="345718576"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 17:38:12 +0200
Date:   Sun, 12 Apr 2020 17:38:12 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     James Smart <jsmart2021@gmail.com>
cc:     linux-scsi@vger.kernel.org, dwagner@suse.de, maier@linux.ibm.com,
        bvanassche@acm.org, herbszt@gmx.de, natechancellor@gmail.com,
        rdunlap@infradead.org, hare@suse.de,
        James Smart <jsmart2021@gmail.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>, kbuild-all@lists.01.org
Subject: [PATCH] elx: efct: fix zalloc-simple.cocci warnings
Message-ID: <alpine.DEB.2.21.2004121734160.2419@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: kbuild test robot <lkp@intel.com>

Use zeroing allocator rather than allocator followed by memset with 0

Generated by: scripts/coccinelle/api/alloc/zalloc-simple.cocci

CC: James Smart <jsmart2021@gmail.com>
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
---

There are four patches in all from 0-day, all with the same subject.
Maybe you can just squash them.

thanks,
julia

url:    https://github.com/0day-ci/linux/commits/James-Smart/efct-Broadcom-Emulex-FC-Target-driver/20200412-114125
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
:::::: branch date: 4 hours ago
:::::: commit date: 4 hours ago

 efct_hw_queues.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/scsi/elx/efct/efct_hw_queues.c
+++ b/drivers/scsi/elx/efct/efct_hw_queues.c
@@ -170,11 +170,10 @@ efct_hw_new_cq_set(struct hw_eq *eqs[],
 		cqs[i] = NULL;

 	for (i = 0; i < num_cqs; i++) {
-		cq = kmalloc(sizeof(*cq), GFP_KERNEL);
+		cq = kzalloc(sizeof(*cq), GFP_KERNEL);
 		if (!cq)
 			goto error;

-		memset(cq, 0, sizeof(*cq));
 		cqs[i]          = cq;
 		cq->eq          = eqs[i];
 		cq->type        = SLI_QTYPE_CQ;
@@ -373,11 +372,10 @@ efct_hw_new_rq_set(struct hw_cq *cqs[],
 		rqs[i] = NULL;

 	for (i = 0, q_count = 0; i < num_rq_pairs; i++, q_count += 2) {
-		rq = kmalloc(sizeof(*rq), GFP_KERNEL);
+		rq = kzalloc(sizeof(*rq), GFP_KERNEL);
 		if (!rq)
 			goto error;

-		memset(rq, 0, sizeof(*rq));
 		rqs[i] = rq;
 		rq->instance = hw->hw_rq_count++;
 		rq->cq = cqs[i];
