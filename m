Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F3AEC19B
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Nov 2019 12:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbfKALSm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Nov 2019 07:18:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:34746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728996AbfKALSm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 1 Nov 2019 07:18:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FF10B2CE;
        Fri,  1 Nov 2019 11:18:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/4] scsi: remove legacy cmd_list implementation
Date:   Fri,  1 Nov 2019 12:18:34 +0100
Message-Id: <20191101111838.140027-1-hare@suse.de>
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

Hannes Reinecke (4):
  dpt_i2o: use midlayer tcq implementation
  dpt_i2o: make adpt_i2o_to_scsi() a void function
  aacraid: use blk_mq_rq_busy_iter() for traversing outstanding commands
  scsi: Remove cmd_list functionality

 drivers/scsi/aacraid/aachba.c   | 127 ++++++++++++++++++++++------------------
 drivers/scsi/aacraid/comminit.c |  30 ++++------
 drivers/scsi/aacraid/commsup.c  |  38 +++++-------
 drivers/scsi/aacraid/linit.c    |  87 ++++++++++++++-------------
 drivers/scsi/dpt_i2o.c          |  27 ++++-----
 drivers/scsi/dpti.h             |   2 +-
 drivers/scsi/scsi.c             |  14 -----
 drivers/scsi/scsi_error.c       |   1 -
 drivers/scsi/scsi_lib.c         |  32 ----------
 drivers/scsi/scsi_priv.h        |   2 -
 drivers/scsi/scsi_scan.c        |   1 -
 include/scsi/scsi_cmnd.h        |   1 -
 include/scsi/scsi_device.h      |   1 -
 include/scsi/scsi_host.h        |   2 -
 14 files changed, 160 insertions(+), 205 deletions(-)

-- 
2.16.4

