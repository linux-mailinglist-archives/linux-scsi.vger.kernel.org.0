Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46874337C3D
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Mar 2021 19:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCKSOs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Mar 2021 13:14:48 -0500
Received: from smtp.infotech.no ([82.134.31.41]:51109 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhCKSOg (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 11 Mar 2021 13:14:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id B63E0204269;
        Thu, 11 Mar 2021 19:14:32 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5QomvcwjMeRp; Thu, 11 Mar 2021 19:14:26 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        by smtp.infotech.no (Postfix) with ESMTPA id EF538204196;
        Thu, 11 Mar 2021 19:14:25 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        colin.king@canonical.com
Subject: [PATCH 0/4] sg: fixes for 5.13/scsi-staging
Date:   Thu, 11 Mar 2021 13:14:19 -0500
Message-Id: <20210311181423.137646-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patchset addresses reports sent by Colin King to the linux-scsi
list in 20210311 based on coverity reports. This was due to a 45
part patchset "sg: add v4 interface" applied to 5.13/scsi-staging
recently. Patches 1 and 2 address those concerns. Additionally
Colin King sent a patch titled "[PATCH][next] scsi: sg: Fix use of
pointer sfp after it has been kfree'd" [linux-scsi 20210311] which
should be applied.

Patches 3 and 4 are due to the author's ongoing testing.

This patchset is against MKP's repository, 5.13/scsi-staging
branch.

Douglas Gilbert (4):
  sg: sg_rq_map_kern: fix uninitialized
  sg: sg_remove_sfp_usercontext: remove NULL check
  sg: sg_rq_end_io: set SG_FRQ_ISSUED
  sg: sg_common_write: remove debug remnant

 drivers/scsi/sg.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

-- 
2.25.1

