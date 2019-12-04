Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17706112DE0
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Dec 2019 15:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfLDO70 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Dec 2019 09:59:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:36206 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727958AbfLDO7Z (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 4 Dec 2019 09:59:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9216ACB8;
        Wed,  4 Dec 2019 14:59:23 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        Balsundar P <balsundar.p@microchip.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv6 00/13] scsi: remove legacy cmd_list implementation
Date:   Wed,  4 Dec 2019 15:59:05 +0100
Message-Id: <20191204145918.143134-1-hare@suse.de>
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

Changes to v3:
- Include reviews from Christoph
- Add midlayer helper to terminate outstanding commands
- Split off aacraid modifcations into several patches

Changes to v4:
- Include reviews from Bart
- Add new midlayer helper scsi_host_quiesce()/scsi_host_resume()
- Improve comments

Changes to v5:
- Add reviews from Balsundar P.
- Rename scsi_host_flush_commands()
- Replace patch using scsi_host_quiesce() by using busy iterator

Hannes Reinecke (13):
  dpt_i2o: rename adpt_i2o_to_scsi() to adpt_i2o_scsi_complete()
  scsi: add scsi_host_complete_all_commands() helper
  dpt_i2o: use scsi_host_complete_all_commands() to abort outstanding
    commands
  aacraid: Do not wait for outstanding write commands on
    synchronize_cache
  aacraid: use scsi_host_complete_all_commands() to terminate
    outstanding commands
  aacraid: replace aac_flush_ios() with midlayer helper
  aacraid: move scsi_(block,unblock)_requests out of
    _aac_reset_adapter()
  scsi: add scsi_host_(block,unblock) helper function
  aacraid: use scsi_host_(block,unblock) to block I/O
  scsi: add scsi_host_busy_iter()
  aacraid: use scsi_host_busy_iter() to wait for outstanding commands
  aacraid: use scsi_host_busy_iter() in get_num_of_incomplete_fibs()
  scsi: Remove cmd_list functionality

 drivers/scsi/aacraid/aachba.c   |  76 +------------------------
 drivers/scsi/aacraid/comminit.c |  35 ++++++------
 drivers/scsi/aacraid/commsup.c  |  46 +++------------
 drivers/scsi/aacraid/linit.c    | 120 ++++++++++++++++------------------------
 drivers/scsi/dpt_i2o.c          |  25 +--------
 drivers/scsi/dpti.h             |   3 +-
 drivers/scsi/hosts.c            |  61 ++++++++++++++++++++
 drivers/scsi/scsi.c             |  14 -----
 drivers/scsi/scsi_error.c       |   1 -
 drivers/scsi/scsi_lib.c         |  61 ++++++++++----------
 drivers/scsi/scsi_priv.h        |   2 -
 drivers/scsi/scsi_scan.c        |   1 -
 include/scsi/scsi_cmnd.h        |   1 -
 include/scsi/scsi_device.h      |   1 -
 include/scsi/scsi_host.h        |  10 +++-
 15 files changed, 178 insertions(+), 279 deletions(-)

-- 
2.16.4

