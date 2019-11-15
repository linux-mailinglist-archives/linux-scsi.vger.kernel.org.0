Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D972FDDCF
	for <lists+linux-scsi@lfdr.de>; Fri, 15 Nov 2019 13:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKOM2M (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 15 Nov 2019 07:28:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:57694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727323AbfKOM2M (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 15 Nov 2019 07:28:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04031B1E0;
        Fri, 15 Nov 2019 12:28:10 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3 0/5] scsi: remove legacy cmd_list implementation
Date:   Fri, 15 Nov 2019 13:27:52 +0100
Message-Id: <20191115122757.132006-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

with the switch to blk-mq we have an efficient way of looking up
outstanding commands via blk_mq_rq_busy_iter().
In this patchset the dpt_i2o and aacraid drivers are switched over
to using that function, and the now obsolete cmd_list implemantation
in the SCSI midlayer is removed.

As usual, comments and reviews are welcome.

Changes to v1:
- Fixup kbuild warning

Changes to v2:
- Add scsi_host_busy_iter()
- Include reviews from Christoph

Hannes Reinecke (5):
  scsi: add scsi_host_busy_iter()
  dpt_i2o: use midlayer tcq implementation
  dpt_i2o: rename adpt_i2o_to_scsi() to adpt_i2o_scsi_complete()
  aacraid: use scsi_host_busy_iter() for traversing outstanding commands
  scsi: Remove cmd_list functionality

 drivers/scsi/aacraid/aachba.c   | 127 ++++++++++++++++++++++------------------
 drivers/scsi/aacraid/comminit.c |  29 ++++-----
 drivers/scsi/aacraid/commsup.c  |  37 +++++-------
 drivers/scsi/aacraid/linit.c    |  86 ++++++++++++++-------------
 drivers/scsi/dpt_i2o.c          |  28 ++++-----
 drivers/scsi/dpti.h             |   2 +-
 drivers/scsi/hosts.c            |  33 +++++++++++
 drivers/scsi/scsi.c             |  14 -----
 drivers/scsi/scsi_error.c       |   1 -
 drivers/scsi/scsi_lib.c         |  32 ----------
 drivers/scsi/scsi_priv.h        |   2 -
 drivers/scsi/scsi_scan.c        |   1 -
 include/scsi/scsi_cmnd.h        |   1 -
 include/scsi/scsi_device.h      |   1 -
 include/scsi/scsi_host.h        |   7 ++-
 15 files changed, 195 insertions(+), 206 deletions(-)

-- 
2.16.4

