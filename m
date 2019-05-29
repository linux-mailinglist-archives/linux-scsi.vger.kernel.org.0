Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C840C2DE20
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 15:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfE2N3L (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 09:29:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:45508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726702AbfE2N3K (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 29 May 2019 09:29:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18BCBAF26;
        Wed, 29 May 2019 13:29:09 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH RFC 00/24] scsi: enable reserved commands for LLDDs
Date:   Wed, 29 May 2019 15:28:37 +0200
Message-Id: <20190529132901.27645-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi all,

quite some drivers use internal commands for various purposes, most
commonly sending TMFs or querying the HBA status.
While these commands use the same submission mechanism than normal
I/O commands, they will not be counted as outstanding commands,
requiring those drivers to implement their own mechanism to figure
out outstanding commands.
This patchset enables the use of reserved tags for the SCSI midlayer,
enabling LLDDs to rely on the block layer for tracking outstanding
commands.
More importantly, it allows LLDD to request a valid tag from the block
layer without having to implement some tracking mechanism within the
driver. This removes quite some hacks which were required for some
drivers (eg. fnic or snic).

As usual, comments and reviews are welcome.

Hannes Reinecke (24):
  block: disable elevator for reserved tags
  scsi: add scsi_{get,put}_reserved_cmd()
  scsi: add 'nr_reserved_cmds' field to the SCSI host template
  csiostor: use reserved command for LUN reset
  scsi: add scsi_cmd_from_priv()
  virtio_scsi: use reserved commands for TMF
  scsi: add host tagset busy iterator
  fnic: use reserved commands
  fnic: use scsi_host_tagset_busy_iter() to traverse commands
  scsi: allocate separate queue for reserved commands
  scsi: add scsi_host_get_reserved_cmd()
  hpsa: move hpsa_hba_inquiry after scsi_add_host()
  hpsa: use reserved commands
  hpsa: use blk_mq_tagset_busy_iter() to traverse outstanding commands
  hpsa: drop refcount field from CommandList
  snic: use reserved commands
  snic: use tagset iter for traversing commands
  scsi: Implement scsi_is_reserved_cmd()
  aacraid: move scsi_add_host()
  aacraid: use private commands
  aacraid: replace cmd_list with scsi_host_tagset_busy_iter()
  aacraid: use scsi_host_tagset_busy_iter() to traverse outstanding
    commands
  dpt_i2o: drop cmd_list usage
  scsi: drop scsi command list

 block/blk-mq.c                    |  22 +-
 drivers/scsi/aacraid/aachba.c     | 125 +++---
 drivers/scsi/aacraid/aacraid.h    |   6 +-
 drivers/scsi/aacraid/comminit.c   |  28 +-
 drivers/scsi/aacraid/commsup.c    | 134 +++---
 drivers/scsi/aacraid/linit.c      | 302 +++++++------
 drivers/scsi/csiostor/csio_init.c |   3 +-
 drivers/scsi/csiostor/csio_scsi.c |  48 +-
 drivers/scsi/dpt_i2o.c            |  23 +-
 drivers/scsi/fnic/fnic_scsi.c     | 916 ++++++++++++++++----------------------
 drivers/scsi/hosts.c              |  27 ++
 drivers/scsi/hpsa.c               | 310 ++++++-------
 drivers/scsi/hpsa.h               |   1 -
 drivers/scsi/hpsa_cmd.h           |   1 -
 drivers/scsi/scsi.c               |   1 -
 drivers/scsi/scsi_lib.c           |  69 +--
 drivers/scsi/scsi_scan.c          |   1 -
 drivers/scsi/snic/snic.h          |   2 +-
 drivers/scsi/snic/snic_main.c     |   3 +
 drivers/scsi/snic/snic_scsi.c     | 502 ++++++++++-----------
 drivers/scsi/virtio_scsi.c        | 100 ++---
 include/linux/blk-mq.h            |   2 +
 include/scsi/scsi_cmnd.h          |  12 +-
 include/scsi/scsi_device.h        |   1 -
 include/scsi/scsi_host.h          |  17 +-
 include/scsi/scsi_tcq.h           |  30 ++
 26 files changed, 1311 insertions(+), 1375 deletions(-)

-- 
2.16.4

